import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'package:dusty_flutter/arbiter/live_connection/base/connection.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:dusty_flutter/arbiter/live_connection/web_rtc/extension.dart';
import 'package:dusty_flutter/arbiter/live_connection/web_rtc/model.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';

class ArbiterWebRTCConnection
    extends BaseArbiterLiveConnection<WebRTCEventCallbackType> {
  final _config = {
    'iceServers': [
      {
        "urls": "turn:211.119.91.210:3478?transport=tcp",
        "username": "softmax",
        "credential": "softmax"
      },
    ]
  };
  late final StreamController<ArbiterWebRTCEvent> _streamController;
  late final WebSocketChannel _webSocketChannel;
  late final RTCPeerConnection _pc;
  late final RTCDataChannel _rtcDataChannel;

  RTCSignalingState? get signalingState => _pc.signalingState;
  RTCPeerConnectionState? get peerConnectionState => _pc.connectionState;
  RTCIceConnectionState? get iceConnectionState => _pc.iceConnectionState;
  RTCDataChannelState? get dataChannelState => _rtcDataChannel.state;

  ArbiterWebRTCConnection({required super.baseSocketUrl});

  @override
  Future<void> on(
    String url,
    WebRTCEventCallbackType onEvent, {
    DoneCallbackType? onDone,
  }) async {
    _streamController = StreamController<ArbiterWebRTCEvent>();
    _webSocketChannel =
        WebSocketChannel.connect(Uri.parse('$baseSocketUrl$url'))
          ..stream.listen(
            (signalingEvent) {
              final signalingEventJson = jsonDecode(jsonDecode(signalingEvent));
              _onSignalingMessageReceived(signalingEventJson);
            },
            onError: (error) async {
              await _closeConnection(error: Exception(error));
            },
          );

    _pc = await createPeerConnection(_config)
      ..onIceCandidate = (RTCIceCandidate candidate) {
        _webSocketChannel.sink.add(jsonEncode(candidate.toJson()));
      }
      ..onConnectionState = _onPeerConnectionStateChanged
      ..onDataChannel = (RTCDataChannel channel) {
        _rtcDataChannel = channel;
        channel.onDataChannelState = _onDataChannelStateChanged;
        channel.onMessage = _onDataChannelMessageReceived;
      };
    await _webSocketChannel.ready;
    _streamController.stream.listen(onEvent, onDone: () => onDone?.call(null));
  }

  @override
  Future<void> close() async {
    await _closeConnection();
  }

  @override
  Future<void> send(dynamic message) async {
    if (message is ByteBuffer) {
      _rtcDataChannel
          .send(RTCDataChannelMessage.fromBinary(message.asUint8List()));
      return;
    }
    _rtcDataChannel.send(RTCDataChannelMessage(message));
  }

  // 서버에서 offer를 만들어서 받을 경우 기준
  void _onSignalingMessageReceived(Map<String, dynamic> json) async {
    final signalingData = WebRTCSignalData.fromJson(json);
    switch (signalingData.type) {
      case SignalingMessageType.offer:
        if (signalingData.sdp == null) return;
        await _pc.setRemoteDescription(
          RTCSessionDescription(
            signalingData.sdp!,
            signalingData.type.name,
          ),
        );
        final answer = await _pc.createAnswer({});
        await _pc.setLocalDescription(answer);
        _webSocketChannel.sink.add(jsonEncode(answer.toMap()));
        break;
      default:
    }
  }

  void _onPeerConnectionStateChanged(RTCPeerConnectionState state) async {
    try {
      switch (state) {
        case RTCPeerConnectionState.RTCPeerConnectionStateConnected:
          _streamController.add(Connected());
          break;
        case RTCPeerConnectionState.RTCPeerConnectionStateClosed ||
              RTCPeerConnectionState.RTCPeerConnectionStateDisconnected ||
              RTCPeerConnectionState.RTCPeerConnectionStateFailed:
          await _closeConnection();
          break;
        default:
          break;
      }
    } on Exception catch (e) {
      await _closeConnection(error: e);
    }
  }

  void _onDataChannelStateChanged(RTCDataChannelState state) async {
    try {
      switch (state) {
        case RTCDataChannelState.RTCDataChannelOpen:
          _streamController.add(DataChannelOpened());
          break;
        default:
      }
    } on Exception catch (e) {
      await _closeConnection(error: e);
    }
  }

  void _onDataChannelMessageReceived(RTCDataChannelMessage data) async {
    try {
      _streamController.add(DataChannelMessageReceived(
        messageData: DataChannelMessageData.fromJson(json.decode(data.text)),
      ));
    } on Exception catch (e) {
      await _closeConnection(error: e);
    }
  }

  Future<void> _closeConnection({Exception? error}) async {
    if (_streamController.isClosed) return;
    _streamController.add(Closed(error: error));
    await _streamController.close();
    await _webSocketChannel.sink.close();
    await _rtcDataChannel.close();
    await _pc.close();
  }
}
