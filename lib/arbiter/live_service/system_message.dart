import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:dusty_flutter/arbiter/live_service/game_message.dart';

part 'system_message.freezed.dart';
part 'system_message.g.dart';

// TODO 임시
@freezed
class GamePlayerRecord with _$GamePlayerRecord {
  const factory GamePlayerRecord({
    required int userId,
    required String userName,
    required Team team,
    required int kill,
    required int death,
    required int territory,
  }) = _GamePlayerRecord;

  factory GamePlayerRecord.fromJson(Map<String, dynamic> json) =>
      _$GamePlayerRecordFromJson(json);
}
