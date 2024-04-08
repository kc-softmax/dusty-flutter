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
import 'package:dusty_flutter/ui/pollution_text.dart';
import 'package:dusty_flutter/ui/sound_option.dart';
import 'package:dusty_flutter/worlds/play.dart';
import 'package:flame/components.dart';
import 'package:flame/layout.dart';
import 'package:flame/palette.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Hud extends Component with HasGameRef<DustyIslandGame>, KeyboardHandler {
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
  TextComponent? informationText;

  // ScoreText? pollutionScoreText;
  // ScoreText? cleaningScoreText;

  Minimap? minimap;
  late Sprite waterIcon;
  late Sprite skullIcon;
  late SpriteComponent pollutionIndicator;
  late PollutionText pollutionText;

  PlayerInfoComponent? playerInfo;
  PlayerKillLogsComponent? playerKillLogs;
  KillLogsComponent? killLogs;
  GameConfig gameConfig;
  DustyAction lastAction = DustyAction.idle;

  Hud({required this.gameConfig});

  @override
  FutureOr<void> onLoad() {
    final size = gameRef.size;
    if (!kIsWeb) {
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
      gameRef.camera.viewport.add(joystick!);
    }

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
        reloadDuration: gameConfig.activeSkillDuration,
        keyboardKey: LogicalKeyboardKey.keyQ);
    // activeButton?.setIcon(game.atlas.findSprit
    // eByName('attack_icon') as Sprite);

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
      finishDuration: gameConfig.finishDuration,
      keyboardKey: LogicalKeyboardKey.keyW,
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
      handleButtonAction: _onPressedBoostButton,
      reloadDuration: gameConfig.boostSkillReloadTime,
      keyboardKey: LogicalKeyboardKey.space,
    );
    // final boostSprite =
    //     SpriteComponent(sprite: game.atlas.findSpriteByName('invinsible'))
    //       ..size = Vector2(24, 36);
    // boostButton!.add(AlignComponent(
    //   child: boostSprite,
    //   alignment: Anchor.center,
    // ));
    // final blinkIcon = boostButton
    //     ?.setIcon(game.atlas.findSpriteByName('type_a_static') as Sprite);
    // blinkIcon!.size = Vector2(32, 10);
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
      margin: const EdgeInsets.only(left: 44, top: 22),
    );

    // playerInfo = PlayerInfoComponent()
    //   ..x = 52
    //   ..y = 18;

    final infoBgSprite =
        SpriteComponent(sprite: gameRef.atlas.findSpriteByName('rank_bg'))
          ..size = Vector2(196, 88)
          ..anchor = Anchor.center
          ..x = gameRef.size.x / 2;
    // ..y = ;

    final timeBgSprite =
        SpriteComponent(sprite: gameRef.atlas.findSpriteByName('rank_bg'))
          ..size = Vector2(44, 22)
          ..anchor = Anchor.center
          ..x = gameRef.size.x / 2
          ..y = 44;

    rematinTimeText = TextComponent(
      text: '',
      textRenderer: TextPaint(
        style: TextStyle(
          fontSize: 12.0,
          fontFamily: 'ONEMobilePOP',
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

    waterIcon = gameRef.atlas.findSpriteByName('water_icon') as Sprite;
    skullIcon = gameRef.atlas.findSpriteByName('skull_icon') as Sprite;

    final pollutionBar =
        SpriteComponent(sprite: gameRef.atlas.findSpriteByName('pollution_bar'))
          ..size = Vector2(168, 18)
          ..anchor = Anchor.center
          ..x = gameRef.size.x / 2
          ..y = 16;
    pollutionIndicator = SpriteComponent(sprite: waterIcon)
      ..size = Vector2(12, 18);
    // ..anchor = Anchor.center;

    pollutionBar.add(
        AlignComponent(child: pollutionIndicator, alignment: Anchor.center));

    pollutionText =
        PollutionText(boxConfig: const TextBoxConfig(timePerChar: 0.05))
          ..x = gameRef.size.x / 2
          ..y = 110
          ..anchor = Anchor.center;

// boxConfig: TextBoxConfig(timePerChar: 0.05))
    informationText = TextComponent(
      text: "",
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
    )
      ..position = gameRef.size / 2
      ..anchor = Anchor.center;

    // pollutionScoreText = ScoreText(
    //   x: gameRef.size.x / 2 - 128,
    //   label: 'pollution',
    // );

    // cleaningScoreText = ScoreText(
    //   x: gameRef.size.x / 2 + 128,
    //   label: 'cleaning',
    // );

    gameRef.camera.viewport.addAll([
      infoBgSprite,
      activeButton!,
      informationText!,
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
      // pollutionScoreText!,
      // cleaningScoreText!,
      pollutionBar,
      pollutionText,
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
      pollutionIndicator.x = 168 * pollutedRate;

      if (pollutedRate > 0.75 && pollutionIndicator.sprite == waterIcon) {
        pollutionIndicator.sprite = skullIcon;
      }
      if (pollutedRate < 0.75 && pollutionIndicator.sprite == skullIcon) {
        pollutionIndicator.sprite = waterIcon;
      }

      // pollutionScoreText?.updateScore(pollutedRate);
      // cleaningScoreText?.updateScore(1 - pollutedRate);
    }
  }

  // void setupPlayer(Dusty player) {
  //   //
  // }

  @override
  bool onKeyEvent(KeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    if (!kIsWeb) return false;

    DustyAction action = DustyAction.idle;

    if (keysPressed.length == 1 &&
        keysPressed.first == LogicalKeyboardKey.arrowUp) {
      action = DustyAction.twelve;
    } else if (keysPressed.length == 2 &&
        keysPressed.containsAll(
            [LogicalKeyboardKey.arrowUp, LogicalKeyboardKey.arrowRight])) {
      action = DustyAction.one;
    } else if (keysPressed.length == 1 &&
        keysPressed.first == LogicalKeyboardKey.arrowRight) {
      action = DustyAction.three;
    } else if (keysPressed.length == 2 &&
        keysPressed.containsAll(
            [LogicalKeyboardKey.arrowRight, LogicalKeyboardKey.arrowDown])) {
      action = DustyAction.five;
    } else if (keysPressed.length == 1 &&
        keysPressed.first == LogicalKeyboardKey.arrowDown) {
      action = DustyAction.six;
    } else if (keysPressed.length == 2 &&
        keysPressed.containsAll(
            [LogicalKeyboardKey.arrowDown, LogicalKeyboardKey.arrowLeft])) {
      action = DustyAction.seven;
    } else if (keysPressed.length == 1 &&
        keysPressed.first == LogicalKeyboardKey.arrowLeft) {
      action = DustyAction.nine;
    } else if (keysPressed.length == 2 &&
        keysPressed.containsAll(
            [LogicalKeyboardKey.arrowLeft, LogicalKeyboardKey.arrowUp])) {
      action = DustyAction.eleven;
    } else {
      action = DustyAction.stop;
    }
    final currentWorld = gameRef.world;
    if (currentWorld is! PlaySceneWorld) throw ('게임 플레이 중이 아닙니다.');
    currentWorld.player!.targetDirectionIndex = action.code;
    Arbiter.liveService.sendByte(action.encode());
    return true;
  }

  void updateHud(DustyMessage message) {
    // final equipment1Quantity =
    //     message.quantity == null ? 0 : message.quantity! & 0x0F;
    // final equipment2Quantity =
    //     message.quantity == null ? 0 : message.quantity! >> 4;
    if (activeButton?.buttonIcon == null) {
      final spriteList = gameRef.atlas
          .findSpritesByName(message.team == Team.alpha ? 'pm' : 'ym');
      final activeAnimationSprite = SpriteAnimationComponent(
          animation: SpriteAnimation.spriteList(
            spriteList,
            stepTime: 0.05,
          ),
          playing: false);
      activeAnimationSprite.size = activeButton!.size * 0.75;
      activeButton?.setIcon(activeAnimationSprite);
    }

    if (boostButton?.buttonIcon == null) {
      final spriteList = gameRef.atlas.findSpritesByName(
          message.team == Team.alpha ? 'type_a_static' : 'type_a_static');
      final boostAnimationSprite = SpriteAnimationComponent(
          animation: SpriteAnimation.spriteList(
            spriteList,
            stepTime: 0.1,
          ),
          playing: false);
      boostAnimationSprite.size = Vector2(28, 10);

      boostButton?.setIcon(boostAnimationSprite);
    }

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
    final currentWorld = gameRef.world;
    if (currentWorld is! PlaySceneWorld) throw ('게임 플레이 중이 아닙니다.');
    currentWorld.player!.targetDirectionIndex = action.code;
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
    if (gameRef.playWorld!.isSoundOn) {
      DustySoundPool.instance.effectOnActiveSkil();
    }
    Arbiter.liveService.sendByte(DustyAction.activeSkill.encode());
  }

  // void _onPressedSpecialButton(double progress, int gauge) {
  //   if (progress != 0) return;
  //   debugPrint("press special button");
  //   if (gameRef.playWorld!.isSoundOn) {
  //     DustySoundPool.instance.effectOnSpecialSkil();
  //   }
  //   Arbiter.liveService.sendByte(DustyAction.specialSkill.encode(value: gauge));
  // }

  // void _onPressedSpecial2Button(double progress, int gauge) {
  //   if (progress != 0) return;
  //   debugPrint("press special 2 button");
  //   if (gameRef.playWorld!.isSoundOn) {
  //     DustySoundPool.instance.effectOnSecondarySpecialSkil();
  //   }
  //   Arbiter.liveService
  //       .sendByte(DustyAction.special2Skill.encode(value: gauge));
  // }

  String _formatDuration(int time) {
    final duration = Duration(seconds: time);
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String minutes = twoDigits(duration.inMinutes.remainder(60));
    String seconds = twoDigits(duration.inSeconds.remainder(60));
    return "$minutes:$seconds";
  }
}
