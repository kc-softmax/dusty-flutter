import 'dart:math';
import 'package:dusty_flutter/arbiter/live_service/game_message.dart';
import 'package:dusty_flutter/characters/dusty.dart';
import 'package:dusty_flutter/mixins/game_mixin.dart';

class DustyFactory extends ObjectFactoryComponent<Dusty, DustyMessage> {
  @override
  Dusty facotry(DustyMessage message) {
    return Dusty()
      ..x = Random().nextInt(400) + 300
      ..y = Random().nextInt(400) + 300;
  }

  @override
  void onGenerateObject(DustyMessage message) {
    final player = facotry(message);
    objects[message.dustyId] = player;
    gameRef.world.add(player);
  }

  @override
  void onRemoveObject(DustyMessage message) {}

  @override
  void onUpdateObject(DustyMessage message) {
    // final dusty = objects[message.dustyId];
    //.. 비교
    //.. 이벤트 도출
    // .. 호출 dusty.updateSkin();
  }
}
