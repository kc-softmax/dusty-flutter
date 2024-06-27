import 'package:freezed_annotation/freezed_annotation.dart';

part 'model.freezed.dart';
part 'model.g.dart';

/*
WebRTC 이벤트를 나타내는 sealed 클래스 및 하위 클래스들.
ArbiterWebRTCEvent
- Connected
- Closed
- DataChannelOpened
- DataChannelMessageReceived
**/
sealed class ArbiterWebRTCEvent {}

class Connected extends ArbiterWebRTCEvent {}

class Closed extends ArbiterWebRTCEvent {
  // TODO rtc 관련 에러로 좁혀주기
  final Exception? error;
  Closed({this.error});
}

class DataChannelOpened extends ArbiterWebRTCEvent {}

class DataChannelMessageReceived extends ArbiterWebRTCEvent {
  final DataChannelMessageData messageData;
  DataChannelMessageReceived({required this.messageData});
}

/*
WebRTC 연결을 위한 데이터 클래스들(서버와 프로토콜 맞춰야함)
SignalingMessageType
WebRTCSignalData
**/
enum SignalingMessageType {
  @JsonValue('offer')
  offer,
  @JsonValue('answer')
  answer,
  @JsonValue('candidate')
  candidate,
}

// {type, sdp}: WebRTC 데이터
@freezed
class WebRTCSignalData with _$WebRTCSignalData {
  const factory WebRTCSignalData({
    required SignalingMessageType type,
    String? sdp,
    String? candidate,
    String? id,
    int? label,
  }) = _WebRTCSignalData;

  factory WebRTCSignalData.fromJson(Map<String, dynamic> json) =>
      _$WebRTCSignalDataFromJson(json);
}

@freezed
class DataChannelMessageData with _$DataChannelMessageData {
  const factory DataChannelMessageData({
    @JsonKey(name: 'user_id') required int userId,
    required String text,
  }) = _DataChannelMessageData;

  factory DataChannelMessageData.fromJson(Map<String, dynamic> json) =>
      _$DataChannelMessageDataFromJson(json);
}
