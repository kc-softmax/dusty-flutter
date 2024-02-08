import 'dart:async';
import 'dart:convert';
import 'package:dusty_flutter/arbiter/arbiter_client.dart';
import 'package:dusty_flutter/arbiter/live_service/game_message.dart';
import 'package:dusty_flutter/characters/const.dart';
import 'package:dusty_flutter/characters/dusty.dart';
import 'package:dusty_flutter/effects/const.dart';
import 'package:dusty_flutter/effects/default_explosion.dart';
import 'package:dusty_flutter/effects/thunder_effect.dart';
import 'package:dusty_flutter/game.dart';
import 'package:dusty_flutter/mixins/game_mixin.dart';
import 'package:flame/components.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PlayScene extends Component with HasGameRef<DustyIslandGame> {
  static const routerName = 'play';
  static final buttonSize = Vector2(56, 59);
  static final smallButtonSize = Vector2(44, 46);

  GameConfig? gameConfig;
  late final Dusty player;
  late final JoystickComponent joystick;

  final exampleDustyFactory = ExampleDustyFactory();

  @override
  FutureOr<void> onLoad() async {
    await add(exampleDustyFactory);

    gameRef.overlays.addEntry("RestartButton", ((context, game) {
      return FilledButton(
        onPressed: () async {
          debugPrint("restart!!");
          await _resetGame();
        },
        child: const Text("다시 시작"),
      );
    }));
    gameRef.overlays.add("RestartButton");

    player = Dusty()
      ..x = 500
      ..y = 500;

    joystick = JoystickComponent(
      knob: SpriteComponent(
        sprite: game.atlas.findSpriteByName('knob'),
        size: Vector2.all(40),
      ),
      background: SpriteComponent(
        sprite: game.atlas.findSpriteByName('joystick_bg'),
        size: Vector2.all(136),
      ),
      margin: const EdgeInsets.only(left: 44, bottom: 44),
    );

    final shieldButton = HudButtonComponent(
      button: SpriteComponent(
        sprite: game.atlas.findSpriteByName('circle_button'),
        size: buttonSize,
      ),
      buttonDown: SpriteComponent(
        sprite: game.atlas.findSpriteByName('press_circle_button'),
        size: buttonSize,
      ),
      margin: const EdgeInsets.only(
        right: 68,
        bottom: 65,
      ),
      onPressed: () =>
          {game.world.add(ThunderEffect.generate(player.position))},
    );

    final boostButton = HudButtonComponent(
        button: SpriteComponent(
          sprite: game.atlas.findSpriteByName('small_circle_button'),
          size: smallButtonSize,
        ),
        buttonDown: SpriteComponent(
          sprite: game.atlas.findSpriteByName('press_small_circle_button'),
          size: smallButtonSize,
        ),
        margin: const EdgeInsets.only(
          right: 144,
          bottom: 38,
        ),
        onPressed: () => {
              if (player.bodyEffectType == DustyBodyEffectType.none)
                player.bodyEffectType = DustyBodyEffectType.electricShock
              else
                player.bodyEffectType = DustyBodyEffectType.none
            });

    final activeButton = HudButtonComponent(
        button: SpriteComponent(
          sprite: game.atlas.findSpriteByName('small_circle_button'),
          size: smallButtonSize,
        ),
        buttonDown: SpriteComponent(
          sprite: game.atlas.findSpriteByName('press_small_circle_button'),
          size: smallButtonSize,
        ),
        margin: const EdgeInsets.only(
          right: 144,
          bottom: 108,
        ),
        onPressed: () => {
              if (player.glassesType == DustyGlassesType.idle)
                player.glassesType = DustyGlassesType.boost
              else
                player.glassesType = DustyGlassesType.idle
            });

    final specialButton = HudButtonComponent(
      button: SpriteComponent(
        sprite: game.atlas.findSpriteByName('small_circle_button'),
        size: smallButtonSize,
      ),
      buttonDown: SpriteComponent(
        sprite: game.atlas.findSpriteByName('press_small_circle_button'),
        size: smallButtonSize,
      ),
      margin: const EdgeInsets.only(
        right: 88,
        bottom: 150,
      ),
      onPressed: () => {
        game.playScene.add(
          DefaultExplosion.generate(
            DefaultExplosionType.red,
            player.position,
          ),
        )
      },
    );

    gameRef.world.add(gameRef.mapComponent);
    gameRef.world.addAll([player]);
    gameRef.camera.viewport.addAll([
      joystick,
      shieldButton,
      boostButton,
      activeButton,
      specialButton,
    ]);
    gameRef.camera.follow(player);
  }

  @override
  void onMount() {
    super.onMount();
    _startGame();
  }

  @override
  void onRemove() {
    super.onRemove();
    _closeGame();
  }

  Future<void> _startGame() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("token");
    Arbiter.liveService.on(
      "/di/ws?token=$token",
      _parseGameMessage,
    );
  }

  void _closeGame() {
    Arbiter.liveService.close();
  }

  Future<void> _resetGame() async {
    _closeGame();
    exampleDustyFactory.clear();
    await _startGame();
  }

  void _parseGameMessage(message) {
    final decoded = const Utf8Decoder().convert(message);
    final gameMessage = GameMessage.fromJson(jsonDecode(decoded));

    debugPrint(gameMessage.toString());

    if (gameMessage.gameConfig != null) {
      gameConfig = gameMessage.gameConfig!;
    }
    if (gameMessage.dusties != null) {
      exampleDustyFactory.addMessages(gameMessage.dusties!);
    }
  }
}
