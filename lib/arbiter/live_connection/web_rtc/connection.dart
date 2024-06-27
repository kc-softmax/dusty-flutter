import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:dusty_flutter/arbiter/live_connection/base/connection.dart';
import 'package:dusty_flutter/arbiter/live_connection/web_rtc/extension.dart';
import 'package:dusty_flutter/arbiter/live_connection/web_rtc/model.dart';

class ArbiterWebRTCConnection
    extends BaseArbiterLiveConnection<WebRTCEventCallbackType> {
  final _config = {
    'sdpSemantics': 'unified-plan',
    'iceServers': [
      {
        "urls": "turn:211.119.91.210:3478?transport=tcp",
        "username": "softmax",
        "credential": "softmax"
      },
    ]
  };
  final _defaultMediaConstraints = {"video": true, "audio": true};
  final _localRenderer = RTCVideoRenderer();
  final _remoteRenderer = RTCVideoRenderer();

  late final StreamController<ArbiterWebRTCEvent> _streamController;
  late final WebSocketChannel _webSocketChannel;
  late final RTCPeerConnection _pc;
  late final RTCDataChannel _rtcDataChannel;
  late MediaStream _localMediaStream;

  RTCSignalingState? get signalingState => _pc.signalingState;
  RTCPeerConnectionState? get peerConnectionState => _pc.connectionState;
  RTCIceConnectionState? get iceConnectionState => _pc.iceConnectionState;
  RTCDataChannelState? get dataChannelState => _rtcDataChannel.state;
  RTCVideoRenderer get localVideoRenderer => _localRenderer;
  RTCVideoRenderer get remoteVideoRenderer => _remoteRenderer;

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
      }
      ..onTrack = (event) async {
        print('on track ${event.track.id}');
        if (event.track.kind == 'video') {
          await readyRemoteMediaStream(event.streams.first);
        }
      };

    _localMediaStream.getTracks().forEach((track) async {
      print('local track: $track');
      await _pc.addTrack(track, _localMediaStream);
    });

    _streamController.stream.listen(onEvent, onDone: () => onDone?.call(null));

    await _webSocketChannel.ready;

    // final offer = await _pc.createOffer();
    // print('offer: $offer');
    // _pc.setLocalDescription(offer);
    // _webSocketChannel.sink.add(jsonEncode(offer.toMap()));
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

  void clear() {
    _localRenderer.dispose();
  }

  Future<void> readyLocalMediaStream(
      {Map<String, dynamic>? constraints}) async {
    await _localRenderer.initialize();
    final mediaConstraints = constraints ?? _defaultMediaConstraints;
    _localMediaStream =
        await navigator.mediaDevices.getUserMedia(mediaConstraints);
    _localRenderer.srcObject = _localMediaStream;
  }

  Future<void> readyRemoteMediaStream(MediaStream stream) async {
    await _remoteRenderer.initialize();
    _remoteRenderer.srcObject = stream;
  }

  void _onSignalingMessageReceived(Map<String, dynamic> json) async {
    final signalingData = WebRTCSignalData.fromJson(json);
    switch (signalingData.type) {
      case SignalingMessageType.offer || SignalingMessageType.answer:
        if (signalingData.sdp == null) return;
        await _pc.setRemoteDescription(
          RTCSessionDescription(
            signalingData.sdp!,
            signalingData.type.name,
          ),
        );
        if (signalingData.type == SignalingMessageType.offer) {
          final answer = await _pc.createAnswer();
          await _pc.setLocalDescription(answer);
          _webSocketChannel.sink.add(jsonEncode(answer.toMap()));
          return;
        }
        break;
      case SignalingMessageType.candidate:
        _pc.addCandidate(RTCIceCandidate(
          signalingData.candidate,
          signalingData.id,
          signalingData.label,
        ));
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
