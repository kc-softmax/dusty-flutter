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
      gameRef.playScene.hud.informationText!.text = '';
      dusty.isPlayer = true;
      gameRef.playScene.player = dusty;
      gameRef.playScene.hud.updateHud(message);
    }
  }

  @override
  void onRemoveObject(DustyMessage message) {
    Dusty? deathDusty = objects[message.dustyId];
    if (deathDusty != null) {
      if (deathDusty.isPlayer) {
        gameRef.playScene.hud.informationText!.text = "It revives in 5 seconds";
      }
      Dusty? killer = objects[message.killerId];
      debugPrint("onRemoveObject ${message.dustyId} ${message.killerId}");
      if (killer != null && killer.isPlayer) {
        final killerAvatarName =
            killer.team == Team.alpha ? 'po_mask' : 'nature_mask';
        final loserAvatarName =
            deathDusty.team == Team.alpha ? 'po_mask' : 'nature_mask';
        final killerAvatar =
            gameRef.atlas.findSpriteByName(killerAvatarName) as Sprite;
        final loserAvatar =
            gameRef.atlas.findSpriteByName(loserAvatarName) as Sprite;
        if (killer.isPlayer) {
          gameRef.playScene.hud.playerKillLogs!
              .addKillLog(loserAvatar, deathDusty.dustyName, message.removeBy!);
        }
        gameRef.playScene.hud.killLogs!.addKillLog(killer.dustyName,
            deathDusty.dustyName, killerAvatar, loserAvatar, message.removeBy!);
      }
      switch (message.removeBy) {
        case RemoveBy.missaile:
          gameRef.world.add(DefaultExplosion(DefaultExplosionType.yellow)
            ..x = deathDusty.x
            ..y = deathDusty.y
            ..size = deathDusty.size * 2);
          break;
        default:
          final exType = deathDusty.team == Team.alpha
              ? DefaultExplosionType.red
              : DefaultExplosionType.yellow;
          gameRef.world.add(DefaultExplosion(exType)
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
      if (message.position != null && message.position! > 0) {
        dusty.updateNextPosition(Vector2(message.x, message.y));
      }
      if (message.status != null) {
        dusty.directionIndex = message.direction;
        dusty.setFinishState(message.isFinishing, message.finishType);
        dusty.setDustyShield(message.isShield);
        dusty.updateDustyState(message.dustyState, message.position!);
        if (dusty == user) {
          gameRef.playScene.hud.updateHud(message);
          //.. update hud
        }
        // data 가 올거라 믿고있기 때문에
      }

      // for only player
      if (dusty.isPlayer) {
        if (message.targetId != null) {
          dusty.targetId = message.targetId;
        }
      }
    }
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
