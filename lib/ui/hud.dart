import 'dart:async';
import 'dart:math';
import 'package:dusty_flutter/arbiter/arbiter_client.dart';
import 'package:dusty_flutter/arbiter/live_service/game_message.dart';
import 'package:dusty_flutter/buttons/dusty_hud_button.dart';
import 'package:dusty_flutter/game.dart';
import 'package:dusty_flutter/models/protocols/const.dart';
import 'package:dusty_flutter/ui/joystick.dart';
import 'package:dusty_flutter/ui/kill_logs.dart';
import 'package:dusty_flutter/ui/minimap.dart';
import 'package:dusty_flutter/ui/player_info.dart';
import 'package:dusty_flutter/ui/player_kill_logs.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class Hud extends Component with HasGameRef<DustyIslandGame> {
  static final smallButtonSize = Vector2(44, 46);
  static final middleButtonSize = Vector2(55, 58);
  static final largeButtonSize = Vector2(66, 70);

  Joystick? joystick;
  DustyHudButton? activeButton;
  DustyHudButton? finishingButton;
  DustyHudButton? boostButton;
  DustyHudButton? specialButton;
  DustyHudButton? special2Button;
  DustyHudButton? itemSlot1;
  DustyHudButton? itemSlot2;

  Minimap? minimap;

  PlayerInfoComponent? playerInfo;
  PlayerKillLogsComponent? playerKillLogs;
  KillLogsComponent? killLogs;

  DustyAction lastAction = DustyAction.idle;

  @override
  FutureOr<void> onLoad() {
    final size = gameRef.size;
    joystick = Joystick(
      knob: SpriteComponent(
        sprite: game.atlas.findSpriteByName('knob'),
        size: Vector2.all(size.y * 0.1),
      ),
      background: SpriteComponent(
        sprite: game.atlas.findSpriteByName('joystick_bg'),
        size: Vector2.all(size.y * 0.35),
      ),
      margin: const EdgeInsets.only(left: 66, bottom: 22),
      onMovedJoystick: _onMovedJoyStick,
    );

    finishingButton = DustyHudButton(
      button: SpriteComponent(
        sprite: game.atlas.findSpriteByName('circle_button'),
        size: middleButtonSize,
      ),
      margin: const EdgeInsets.only(
        right: 90,
        bottom: 164,
      ),
      onPressed: _onPressedFinishingButton,
    );

    special2Button = DustyHudButton(
      button: SpriteComponent(
        sprite: game.atlas.findSpriteByName('circle_button'),
        size: middleButtonSize,
      ),
      margin: const EdgeInsets.only(
        right: 182,
        bottom: 114,
      ),
      onPressed: _onPressedShieldButton,
    );

    specialButton = DustyHudButton(
      button: SpriteComponent(
        sprite: game.atlas.findSpriteByName('circle_button'),
        size: middleButtonSize,
      ),
      margin: const EdgeInsets.only(
        right: 258,
        bottom: 46,
      ),
      onPressed: _onPressedSpecialButton,
    );

    boostButton = DustyHudButton(
      button: SpriteComponent(
        sprite: game.atlas.findSpriteByName('circle_button'),
        size: smallButtonSize,
      ),
      margin: const EdgeInsets.only(
        right: 189,
        bottom: 22,
      ),
      onPressed: _onPressedActiveButton,
    );

    activeButton = DustyHudButton(
      button: SpriteComponent(
        sprite: game.atlas.findSpriteByName('circle_button'),
        size: largeButtonSize,
      ),
      margin: const EdgeInsets.only(
        right: 85,
        bottom: 33,
      ),
      onPressed: _onPressedActiveButton,
    );

    itemSlot1 = DustyHudButton(
      button: SpriteComponent(
        sprite: game.atlas.findSpriteByName('circle_button'),
        size: smallButtonSize,
      ),
      margin: const EdgeInsets.only(
        right: 342,
        bottom: 50,
      ),
      onPressed: _onPressedSpecialButton,
    );

    itemSlot2 = DustyHudButton(
      button: SpriteComponent(
        sprite: game.atlas.findSpriteByName('circle_button'),
        size: smallButtonSize,
      ),
      margin: const EdgeInsets.only(
        right: 412,
        bottom: 50,
      ),
      onPressed: _onPressedSpecialButton,
    );

    // minimap = Minimap();
    playerKillLogs = PlayerKillLogsComponent();
    playerKillLogs?.x = gameRef.size.x / 2;
    playerKillLogs?.y = gameRef.size.y / 2 - 48;

    killLogs = KillLogsComponent(
      margin: const EdgeInsets.only(left: 44, top: 74),
    );

    playerInfo = PlayerInfoComponent()
      ..x = 52
      ..y = 18;

    gameRef.camera.viewport.add(joystick!);

    gameRef.camera.viewport.addAll([
      activeButton!,
      specialButton!,
      special2Button!,
      finishingButton!,
      itemSlot1!,
      itemSlot2!,
      boostButton!,
      playerKillLogs!,
      killLogs!,
      playerInfo!,
      // minimap!
    ]);
  }

  @override
  void onRemove() {
    gameRef.camera.viewport.removeAll([...gameRef.camera.viewport.children]);
    super.onRemove();
  }

  void updateHud(DustyMessage message) {
    activeButton?.updateAvailable(message.activeAvailable,
        gameRef.playScene.gameConfig!.activeSkillDuration);
    specialButton?.updateAvailable(message.specialAvailable,
        gameRef.playScene.gameConfig!.specialSkillReloadTime);
    // shieldButton?.updateAvailable(message.shieldAvailable,
    //     gameRef.playScene.gameConfig!.shieldSkillReloadTime);
    // finishingButton?.updateAvailable(message.finishAvailable,
    //     gameRef.playScene.gameConfig!.finishSkillReloadTime);
  }

  void _onMovedJoyStick() {
    // TODO refactor this to use a more elegant solution
    // Since screenAngle and angleTo doesn't care about "direction" of the angle
    // we have to use angleToSigned and create an only increasing angle by
    // removing negative angles from 2*pi.
    final delta = joystick?.delta;
    if (delta == null) {
      return;
    }

    DustyAction action = DustyAction.idle;
    if (delta.isZero()) {
      action = DustyAction.stop;
    } else {
      const double twelveOfPi = pi / 12;
      var knobAngle = delta.screenAngle();
      knobAngle = knobAngle < 0 ? 2 * pi + knobAngle : knobAngle;
      if (knobAngle >= 0 && knobAngle <= twelveOfPi) {
        action = DustyAction.twelve; // top
      } else if (knobAngle > 1 * twelveOfPi && knobAngle <= 3 * twelveOfPi) {
        action = DustyAction.one;
      } else if (knobAngle > 3 * twelveOfPi && knobAngle <= 5 * twelveOfPi) {
        action = DustyAction.two;
      } else if (knobAngle > 5 * twelveOfPi && knobAngle <= 7 * twelveOfPi) {
        action = DustyAction.three;
      } else if (knobAngle > 7 * twelveOfPi && knobAngle <= 9 * twelveOfPi) {
        action = DustyAction.four;
      } else if (knobAngle > 9 * twelveOfPi && knobAngle <= 11 * twelveOfPi) {
        action = DustyAction.five;
      } else if (knobAngle > 11 * twelveOfPi && knobAngle <= 13 * twelveOfPi) {
        action = DustyAction.six;
      } else if (knobAngle > 13 * twelveOfPi && knobAngle <= 15 * twelveOfPi) {
        action = DustyAction.seven;
      } else if (knobAngle > 15 * twelveOfPi && knobAngle <= 17 * twelveOfPi) {
        action = DustyAction.eight;
      } else if (knobAngle > 17 * twelveOfPi && knobAngle <= 19 * twelveOfPi) {
        action = DustyAction.nine;
      } else if (knobAngle > 19 * twelveOfPi && knobAngle <= 21 * twelveOfPi) {
        action = DustyAction.ten;
      } else if (knobAngle > 21 * twelveOfPi && knobAngle <= 23 * twelveOfPi) {
        action = DustyAction.eleven;
      } else if (knobAngle > 23 * twelveOfPi) {
        action = DustyAction.twelve;
      } else {
        action = DustyAction.stop;
      }
    }

    // if (action != DustyAction.idle && action != lastAction) {
    //   lastAction = action;
    Arbiter.liveService.sendByte(action.encode());
    // }
  }

  void _onPressedFinishingButton() {
    final avatar = gameRef.atlas.findSpriteByName('raft') as Sprite;
    killLogs!.addKillLog('choichoi', 'ycsycs', avatar, avatar, RemoveBy.flame);

    // Arbiter.liveService.sendByte(DustyAction.finishing.encode());
    debugPrint("press finishing button");
  }

  void _onPressedShieldButton() {
    Arbiter.liveService.sendByte(DustyAction.shield.encode());
    debugPrint("press shield button");
  }

  void _onPressedActiveButton() {
    debugPrint("press active button");
    Arbiter.liveService.sendByte(DustyAction.activeSkill.encode());
  }

  void _onPressedSpecialButton() {
    debugPrint("press special button");
    Arbiter.liveService.sendByte(DustyAction.specialSkill.encode());
  }
}
