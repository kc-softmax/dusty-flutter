import 'package:flutter_webrtc/flutter_webrtc.dart';

extension RTCIceCandidateConverter on RTCIceCandidate {
  static RTCIceCandidate? fromJson(Map<String, dynamic>? json) {
    if (json == null) return null;
    return RTCIceCandidate(
      json['candidate'] as String,
      json['id'] as String,
      json['label'] as int,
    );
  }

  Map<String, dynamic>? toJson() {
    return {
      'type': 'candidate',
      'candidate': candidate,
      'id': sdpMid,
      'label': sdpMLineIndex,
    };
  }
}
