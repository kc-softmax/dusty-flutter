import 'dart:async';
import 'dart:math';
import 'package:dusty_flutter/arbiter/arbiter_client.dart';
import 'package:dusty_flutter/arbiter/live_service/game_message.dart';
import 'package:dusty_flutter/buttons/dusty_hud_finish_button.dart';
import 'package:dusty_flutter/buttons/dusty_hud_button.dart';
import 'package:dusty_flutter/effects/sound/dusty_sound.dart';
import 'package:dusty_flutter/game.dart';
import 'package:dusty_flutter/models/protocols/const.dart';
import 'package:dusty_flutter/ui/joystick.dart';
import 'package:dusty_flutter/ui/kill_logs.dart';
import 'package:dusty_flutter/ui/minimap.dart';
import 'package:dusty_flutter/ui/player_info.dart';
import 'package:dusty_flutter/ui/player_kill_logs.dart';
import 'package:dusty_flutter/ui/score_text.dart';
import 'package:dusty_flutter/ui/sound_option.dart';
import 'package:flame/components.dart';
import 'package:flame/layout.dart';
import 'package:flame/palette.dart';
import 'package:flutter/material.dart';

class Hud extends Component with HasGameRef<DustyIslandGame> {
  static final smallButtonSize = Vector2(44, 46);
  static final middleButtonSize = Vector2(55, 58);
  static final largeButtonSize = Vector2(66, 70);

  Joystick? joystick;
  DustyHudFinishButton? finishingButton;
  DustyHudButton? activeButton;
  DustyHudButton? boostButton;
  // DustyHudButton? specialButton;
  // DustyHudButton? special2Button;
  // DustyHudButton? itemSlot1;
  // DustyHudButton? itemSlot2;
  TextComponent? rematinTimeText;
  ScoreText? pollutionScoreText;
  ScoreText? cleaningScoreText;

  Minimap? minimap;
  PlayerInfoComponent? playerInfo;
  PlayerKillLogsComponent? playerKillLogs;
  KillLogsComponent? killLogs;
  GameConfig gameConfig;
  DustyAction lastAction = DustyAction.idle;

  Hud({required this.gameConfig});

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
        size: Vector2.all(size.y * 0.45),
      ),
      margin: const EdgeInsets.only(left: 66, bottom: 22),
      onMovedJoystick: _onMovedJoyStick,
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
        handleButtonAction: _onPressedActiveButton,
        reloadDuration: gameConfig.activeSkillDuration);

    // specialButton = LongTapDustyHudButton(
    //     button: SpriteComponent(
    //       sprite: game.atlas.findSpriteByName('circle_button'),
    //       size: middleButtonSize,
    //     ),
    //     margin: const EdgeInsets.only(
    //       right: 90,
    //       bottom: 164,
    //     ),
    //     longTapMaxTime: gameConfig.specialPressedStep,
    //     handleLongTapButtonAction: _onPressedSpecialButton,
    //     reloadDuration: gameConfig.specialSkillReloadTime);

    // special2Button = LongTapDustyHudButton(
    //     button: SpriteComponent(
    //       sprite: game.atlas.findSpriteByName('circle_button'),
    //       size: middleButtonSize,
    //     ),
    //     margin: const EdgeInsets.only(
    //       right: 182,
    //       bottom: 114,
    //     ),
    //     longTapMaxTime: gameConfig.specialPressedStep,
    //     handleLongTapButtonAction: _onPressedSpecial2Button,
    //     reloadDuration: gameConfig.special2SkillReloadTime);

    finishingButton = DustyHudFinishButton(
        button: SpriteComponent(
          sprite: game.atlas.findSpriteByName('circle_button'),
          size: middleButtonSize,
        ),
        margin: const EdgeInsets.only(
          right: 258,
          bottom: 46,
        ),
        handleFinishButtonAction: _onPressedFinishingButton,
        finishDuration: gameConfig.finishDuration);

    boostButton = DustyHudButton(
        button: SpriteComponent(
          sprite: game.atlas.findSpriteByName('circle_button'),
          size: smallButtonSize,
        ),
        margin: const EdgeInsets.only(
          right: 189,
          bottom: 22,
        ),
        handleButtonAction: _onPressedBoostButton,
        reloadDuration: gameConfig.boostSkillReloadTime);

    // itemSlot1 = DustyHudButton(
    //     button: SpriteComponent(
    //       sprite: game.atlas.findSpriteByName('circle_button'),
    //       size: smallButtonSize,
    //     ),
    //     margin: const EdgeInsets.only(
    //       right: 342,
    //       bottom: 50,
    //     ),
    //     // handleButtonAction: _onPressedSpecial2Button,
    //     reloadDuration: 1);

    // itemSlot2 = DustyHudButton(
    //     button: SpriteComponent(
    //       sprite: game.atlas.findSpriteByName('circle_button'),
    //       size: smallButtonSize,
    //     ),
    //     margin: const EdgeInsets.only(
    //       right: 412,
    //       bottom: 50,
    //     ),
    //     // handleButtonAction: _onPressedSpecial2Button,
    //     reloadDuration: 1);
//
    // minimap = Minimap();
    playerKillLogs = PlayerKillLogsComponent();
    playerKillLogs?.x = gameRef.size.x / 2;
    playerKillLogs?.y = gameRef.size.y / 2 - 48;

    killLogs = KillLogsComponent(
      margin: const EdgeInsets.only(left: 44, top: 74),
    );

    // playerInfo = PlayerInfoComponent()
    //   ..x = 52
    //   ..y = 18;

    gameRef.camera.viewport.add(joystick!);

    final timeBgSprite =
        SpriteComponent(sprite: gameRef.atlas.findSpriteByName('rank_bg'))
          ..size = Vector2(66, 33)
          ..anchor = Anchor.center
          ..x = gameRef.size.x / 2
          ..y = 40;
    rematinTimeText = TextComponent(
      text: '',
      textRenderer: TextPaint(
        style: TextStyle(
          fontSize: 16.0,
          color: BasicPalette.white.color,
          shadows: [
            Shadow(
              color: BasicPalette.black.color,
              offset: const Offset(1, 1),
              blurRadius: 1,
            ),
          ],
        ),
      ),
    )..anchor = Anchor.center;
    timeBgSprite.add(AlignComponent(
      child: rematinTimeText!,
      alignment: Anchor.center,
      keepChildAnchor: true,
    ));

    pollutionScoreText = ScoreText(
      x: gameRef.size.x / 2 - 128,
      label: 'pollution',
    );

    cleaningScoreText = ScoreText(
      x: gameRef.size.x / 2 + 128,
      label: 'cleaning',
    );

    gameRef.camera.viewport.addAll([
      activeButton!,
      // specialButton!,
      // special2Button!,
      finishingButton!,
      // itemSlot1!,
      // itemSlot2!,
      boostButton!,
      playerKillLogs!,
      killLogs!,
      timeBgSprite,
      SoundOptionButton(),
      pollutionScoreText!,
      cleaningScoreText!,
      // playerInfo!,
      // minimap!
    ]);
  }

  @override
  void onRemove() {
    gameRef.camera.viewport.removeAll([...gameRef.camera.viewport.children]);
    super.onRemove();
  }

  void updateSystemMessage(SystemMessage message) {
    if (message.remainTime != null && rematinTimeText != null) {
      rematinTimeText!.text = _formatDuration(message.remainTime!);
    }

    if (message.pollutedCount != null) {
      final pollutedRate =
          message.pollutedCount! / gameConfig.totalOccupyableRegion;
      pollutionScoreText?.updateScore(pollutedRate);
      cleaningScoreText?.updateScore(1 - pollutedRate);
    }
  }

  void updateHud(DustyMessage message) {
    // final equipment1Quantity =
    //     message.quantity == null ? 0 : message.quantity! & 0x0F;
    // final equipment2Quantity =
    //     message.quantity == null ? 0 : message.quantity! >> 4;

    activeButton?.updateAvailable(message.activeAvailable);

    // specialButton?.updateAvailable(message.specialAvailable);
    // special2Button?.updateAvailable(message.special2Available);
    // specialButton?.setEquipment(message.equipment1, equipment1Quantity);
    // special2Button?.setEquipment(message.equipment2, equipment2Quantity);

    boostButton?.updateAvailable(message.boostAvailable);

    finishingButton?.updateAvailable(
        message.finishAvailable, message.finishGauge!, message.finishType);
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
    gameRef.playScene.player!.targetDirectionIndex = action.code;
    // if (action != DustyAction.idle && action != lastAction) {
    //   lastAction = action;
    Arbiter.liveService.sendByte(action.encode());
    // }
  }

  // void _onPressedFinishingButton() {
  //   final avatar = gameRef.atlas.findSpriteByName('raft') as Sprite;
  //   killLogs!.addKillLog('choichoi', 'ycsycs', avatar, avatar, RemoveBy.flame);
  //   finishingButton?.updateAvailable(0, 5);

  //   debugPrint("press finishing button");
  // }

  void _onPressedFinishingButton(bool isAvailable) {
    if (!isAvailable) return;
    Arbiter.liveService.sendByte(DustyAction.finishing.encode());
  }

  void _onPressedBoostButton(double progress) {
    if (progress != 0) return;
    debugPrint("press invinsible button");
    Arbiter.liveService.sendByte(DustyAction.boost.encode());
  }

  void _onPressedActiveButton(double progress) {
    if (progress != 0) return;
    debugPrint("press active button");
    if (gameRef.playScene.isSoundOn) {
      DustySoundPool.instance.effectOnActiveSkil();
    }
    Arbiter.liveService.sendByte(DustyAction.activeSkill.encode());
  }

  void _onPressedSpecialButton(double progress, int gauge) {
    if (progress != 0) return;
    debugPrint("press special button");
    if (gameRef.playScene.isSoundOn) {
      DustySoundPool.instance.effectOnSpecialSkil();
    }
    Arbiter.liveService.sendByte(DustyAction.specialSkill.encode(value: gauge));
  }

  void _onPressedSpecial2Button(double progress, int gauge) {
    if (progress != 0) return;
    debugPrint("press special 2 button");
    if (gameRef.playScene.isSoundOn) {
      DustySoundPool.instance.effectOnSecondarySpecialSkil();
    }
    Arbiter.liveService
        .sendByte(DustyAction.special2Skill.encode(value: gauge));
  }

  String _formatDuration(int time) {
    final duration = Duration(seconds: time);
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String minutes = twoDigits(duration.inMinutes.remainder(60));
    String seconds = twoDigits(duration.inSeconds.remainder(60));
    return "$minutes:$seconds";
  }
}
