import 'package:dusty_flutter/game/cameras/camera.dart';
import 'package:flame/game.dart';
import 'package:dusty_flutter/game/effects/ui/const.dart';
import 'package:dusty_flutter/game/effects/ui/default_explosion.dart';
import 'package:dusty_flutter/arbiter/live_service/game_event.dart';
import 'package:dusty_flutter/game/game_objects/characters/dusty/dusty.dart';
import 'package:dusty_flutter/mixins/game_mixin.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/material.dart';

class DustyFactory extends ObjectFactoryComponent<Dusty, DustyEvent> {
// 사용자 플레이어 저장해두기
  Dusty? user;

  @override
  void onGenerateObject(DustyEvent message) {
    final dusty = facotry(message);
    objects[message.objectId] = dusty;
    gameRef.world.add(dusty);
    debugPrint("onGenerateObject ${message.objectId} ${message.name}");
    if (message.isPlayer != null && message.isPlayer!) {
      setFollowUser(message.objectId);
      gameRef.playWorld!.player = dusty;
    }
    // if (message.dustyId == gameRef.playWorld!.followerId) {
    // }
    // if (message.dustyId == PlaySceneWorld.playerId) {
    //   gameRef.gameCamera.hud.informationText.text = '';
    //   dusty.isPlayer = true;
    //
    //   gameRef.gameCamera.hud.updateHud(message);
    // }
  }

  @override
  void onRemoveObject(DustyEvent message) {
    Dusty? deathDusty = objects[message.objectId];
    if (deathDusty != null) {
      if (deathDusty.isPlayer) {
        gameRef.gameCamera.hud.informationText.text = "It revives in 5 seconds";
      }
      Dusty? killer = objects[message.killerId];
      debugPrint("onRemoveObject ${message.objectId} ${message.killerId}");
      if (killer != null && killer.isPlayer) {
        final killerAvatarName =
            killer.team == Team.alpha ? 'po_mask' : 'nature_mask';
        final loserAvatarName =
            deathDusty.team == Team.alpha ? 'po_mask' : 'nature_mask';
        final killerAvatar =
            gameRef.atlas.findSpriteByName(killerAvatarName) as Sprite;
        final loserAvatar =
            gameRef.atlas.findSpriteByName(loserAvatarName) as Sprite;
        // if (killer.isPlayer) {
        //   gameRef.gameCamera.hud.playerKillLogs
        //       .addKillLog(loserAvatar, deathDusty.dustyName, message.removeBy!);
        // }
        // gameRef.gameCamera.hud.killLogs.addKillLog(killer.dustyName,
        //     deathDusty.dustyName, killerAvatar, loserAvatar, message.removeBy!);
      }

      final exType = deathDusty.team == Team.alpha
          ? DefaultExplosionType.red
          : DefaultExplosionType.yellow;
      gameRef.world.add(DefaultExplosion(exType)
        ..x = deathDusty.x
        ..y = deathDusty.y
        ..size = deathDusty.size * 2);

      deathDusty.dead();
      objects.remove(message.objectId);
    }
  }

  @override
  void onUpdateObject(DustyEvent message) {
    Dusty? dusty = objects[message.objectId];
    if (dusty != null) {
      if (message.position != null && message.position! > 0) {
        dusty.updateNextPosition(Vector2(message.x, message.y));
      }
      if (message.status != null) {
        // dusty.directionIndex = message.direction;
        dusty.setFinishState(message.isFinishing, message.finishType);
        dusty.setDustyShield(message.isShield);
        dusty.updateDustyState(message.dustyState, message.position!);
        if (dusty == user) {
          gameRef.gameCamera.hud.updateHud(message);
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
  Dusty facotry(DustyEvent message) {
    assert(message.position != null, "position is null");
    final dusty = Dusty(message.name!, message.team!)
      ..x = message.x
      ..y = message.y;
    return dusty;
  }

  void setFollowUser(int userId) {
    user = objects[userId];
    assert(user != null, "user not found");
    assert(gameRef.camera is DICamera);
    (gameRef.camera as DICamera).start(user!);
    (gameRef.camera as DICamera).hud.minimapCamera.follow(user!);
    debugPrint("setFollowUser ${user!.dustyName}");
  }
}
