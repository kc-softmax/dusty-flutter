import 'package:flame/game.dart';
import 'package:dusty_flutter/effects/ui/const.dart';
import 'package:dusty_flutter/effects/ui/default_explosion.dart';
import 'package:dusty_flutter/arbiter/live_service/game_message.dart';
import 'package:dusty_flutter/characters/dusty.dart';
import 'package:dusty_flutter/mixins/game_mixin.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/material.dart';

class DustyFactory extends ObjectFactoryComponent<Dusty, DustyMessage> {
// 사용자 플레이어 저장해두기
  Dusty? user;

  @override
  void onGenerateObject(DustyMessage message) {
    final dusty = facotry(message);
    objects[message.dustyId] = dusty;
    gameRef.world.add(dusty);
    debugPrint("onGenerateObject ${message.dustyId} ${message.name}");
    if (message.dustyId == gameRef.playScene.followerId) {
      setFollowUser(message.dustyId);
    }
    if (message.dustyId == gameRef.playScene.playerId) {
      dusty.isPlayer = true;
      gameRef.playScene.player = dusty;
    }
  }

  @override
  void onRemoveObject(DustyMessage message) {
    Dusty? deathDusty = objects[message.dustyId];
    if (deathDusty != null) {
      Dusty? killer = objects[message.killerId];
      debugPrint("onRemoveObject ${message.dustyId} ${message.killerId}");
      if (killer != null && killer.isPlayer) {
        final avatar = gameRef.atlas.findSpriteByName('raft') as Sprite;
        if (killer.isPlayer) {
          gameRef.playScene.hud.playerKillLogs!
              .addKillLog(avatar, deathDusty.dustyName, message.removeBy!);
        }
        gameRef.playScene.hud.killLogs!.addKillLog(killer.dustyName,
            deathDusty.dustyName, avatar, avatar, message.removeBy!);
      }
      switch (message.removeBy) {
        case RemoveBy.missaile:
          gameRef.world.add(DefaultExplosion(DefaultExplosionType.blue)
            ..x = deathDusty.x
            ..y = deathDusty.y
            ..size = deathDusty.size * 2);
          break;
        default:
          gameRef.world.add(DefaultExplosion(DefaultExplosionType.red)
            ..x = deathDusty.x
            ..y = deathDusty.y
            ..size = deathDusty.size * 2);
          break;
      }
      deathDusty.dead();
      objects.remove(message.dustyId);
    }
  }

  @override
  void onUpdateObject(DustyMessage message) {
    Dusty? dusty = objects[message.dustyId];
    if (dusty != null) {
      if (message.position != null) {
        dusty.nextPosition = Vector2(message.x, message.y);
        dusty.updateSpeed();
      }
      if (message.status != null) {
        dusty.setFinishState(message.isFinishing, message.finishType);
        dusty.setDustyShield(message.isShield);
        dusty.updateDustyState(message.dustyState);
        if (dusty == user) {
          gameRef.playScene.hud.updateHud(message);
          //.. update hud
        }
      }

      // for only player
      if (dusty.isPlayer) {
        if (message.targetId != null) {
          dusty.targetId = message.targetId;
          // Dusty? targetDusty = objects[message.targetId];
          // // Tower? targetTower = gameRef.playScene.towerFactory.objects[message.targetId];
          // if (targetDusty != null) {
          //   // dusty.target = targetDusty;
          // }
        }
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
    final dusty = Dusty(message.name!, message.team!)
      ..x = message.x
      ..y = message.y;
    return dusty;
  }

  void setFollowUser(int userId) {
    user = objects[userId];
    assert(user != null, "user not found");
    gameRef.camera.follow(user!);
    debugPrint("setFollowUser ${user!.dustyName}");
  }
}
