import 'package:flame/game.dart';
import 'package:dusty_flutter/arbiter/live_service/game_message.dart';
import 'package:dusty_flutter/characters/dusty.dart';
import 'package:dusty_flutter/mixins/game_mixin.dart';

class DustyFactory extends ObjectFactoryComponent<Dusty, DustyMessage> {
// 사용자 플레이어 저장해두기
  Dusty? user;

  @override
  void onGenerateObject(DustyMessage message) {
    final player = facotry(message);
    objects[message.dustyId] = player;
    gameRef.world.add(player);
    setUser(message.dustyId);
  }

  @override
  void onRemoveObject(DustyMessage message) {}

  @override
  void onUpdateObject(DustyMessage message) {
    Dusty? dusty = objects[message.dustyId];
    if (dusty != null) {
      if (message.position != null) {
        dusty.nextPosition = Vector2(
          (message.position! & 0xFFFF) as double,
          message.position! >> 16 as double,
        );
        dusty.updateSpeed();
      }
      if (message.status != null) {
        dusty.updateDustyState(message.dustyState);
      }
    }
    //.. 비교
    //.. 이벤트 도출
    // .. 호출 dusty.updateSkin();
    // .. 또는 dusty.state = newState;
  }

  @override
  Dusty facotry(DustyMessage message) {
    // position = math.floor(self.anchor.y) << 16 | math.floor(self.anchor.x)
    assert(message.position != null, "position is null");
    final dusty = Dusty()
      ..x = (message.position! & 0xFFFF) as double
      ..y = message.position! >> 16 as double;
    // print(dusty.x);
    // print(message.dustyId);
    // print(message.name);
    return dusty;
  }

  void setUser(int userId) {
    user = objects[userId];
    assert(user != null, "user not found");
    gameRef.camera.follow(user!);
  }
}
