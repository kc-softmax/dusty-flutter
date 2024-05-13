import 'package:dusty_flutter/game/base/object_factory.dart';
import 'package:dusty_flutter/game/cameras/camera.dart';
import 'package:dusty_flutter/game/effects/ui/const.dart';
import 'package:dusty_flutter/game/effects/ui/default_explosion.dart';
import 'package:dusty_flutter/arbiter/live_service/game_event.dart';
import 'package:dusty_flutter/game/game_objects/characters/dusty/dusty.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/material.dart';

class DustyFactory extends BaseObjectsFactory<Dusty, DustyEvent> {
// 사용자 플레이어 저장해두기
  Dusty? user;

  @override
  Dusty facotry(DustyEvent message) {
    assert(message.position != null, "position is null");
    final dusty = Dusty(message.name!, message.team!, message.objectId)
      ..x = message.x
      ..y = message.y;
    return dusty;
  }

  @override
  void onGenerateObject(DustyEvent message) {
    final dusty = facotry(message);
    objects[message.objectId] = dusty;
    gameRef.world.add(dusty);
    debugPrint("onGenerateObject ${message.objectId} ${message.name}");
    if (message.isPlayer != null && message.isPlayer!) {
      setFollowUser(message.objectId);
      gameRef.playWorld!.player = dusty..isPlayer = true;
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
            killer.team == Team.colonists ? 'po_mask' : 'nature_mask';
        final loserAvatarName =
            deathDusty.team == Team.guardians ? 'po_mask' : 'nature_mask';
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

      final exType = deathDusty.team == Team.colonists
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
    super.onUpdateObject(message);
    Dusty? dusty = objects[message.objectId];
    if (dusty != null) {
      // for only player
      if (dusty.isPlayer) {}
    }
    // if (dusty != null) {
    //   if (message.position != null && message.position! > 0) {
    //     dusty.updateNextPosition(Vector2(message.x, message.y));
    //   }
    //   if (message.status != null) {
    //     // dusty.directionIndex = message.direction;
    //     dusty.setFinishState(message.isFinishing, message.finishType);
    //     dusty.setDustyShield(message.isShield);
    //     dusty.updateDustyState(message.dustyState, message.position!);
    //     if (dusty == user) {
    //       gameRef.gameCamera.hud.updateHud(message);
    //       //.. update hud
    //     }
    //     // data 가 올거라 믿고있기 때문에
    //   }

    //   // for only player
    //   if (dusty.isPlayer) {
    //     if (message.targetId != null) {
    //       dusty.targetId = message.targetId;
    //     }
    //   }
    // }
  }

  void setFollowUser(int userId) {
    user = objects[userId];
    assert(user != null, "user not found");
    assert(gameRef.camera is DICamera);
    (gameRef.camera as DICamera).start(user!);
    debugPrint("setFollowUser ${user!.dustyName}");
  }

  void addUserIngameUpdateEvent(List<StateData> states) {
    if (user == null) return;
    addEvents([
      DustyEvent.ingameUpdateEvent(
        objectId: user!.objectId,
        states: states,
        isPlayer: true,
      )
    ]);
  }
}
