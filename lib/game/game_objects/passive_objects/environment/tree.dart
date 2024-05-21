import 'package:dusty_flutter/arbiter/live_service/game_event.dart';
import 'package:dusty_flutter/game/game.dart';
import 'package:dusty_flutter/game/game_objects/passive_objects/passive_objects_factory.dart';
import 'package:dusty_flutter/game/ui/const.dart';
import 'package:dusty_flutter/game/ui/gauge_bar.dart';
import 'package:dusty_flutter/game/base/object.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame_noise/flame_noise.dart';

class Tree extends SpriteAnimationComponent
    with
        HasGameRef<DustyIslandGame>,
        CollisionCallbacks,
        DIObject,
        PassiveObjects,
        DamagedObject {
  PassiveObjectType treeType;
  Tree(int objectId, {required this.treeType}) {
    this.objectId = objectId;
  }

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    final spriteList = gameRef.atlas.findSpritesByName('tree');
    animation = SpriteAnimation.spriteList(
      spriteList,
      stepTime: 0.05,
    );
    anchor = Anchor.bottomCenter;
    priority = Priority.environment;
    hpGaugeBar = HorizontalGaugeBar(gaugeColor: GaugeBarColor.red)
      ..anchor = const Anchor(-0.5, 0.5)
      ..y = height * 0.5;
    add(hpGaugeBar);
  }

  @override
  void getDamaged(double value) {
    super.getDamaged(value);
    add(SequenceEffect(
      [
        MoveEffect.by(
          Vector2(-10, 10),
          NoiseEffectController(duration: 1, noise: PerlinNoise(frequency: 20)),
        ),
        MoveEffect.by(Vector2.zero(), LinearEffectController(2)),
      ],
    ));
  }

  @override
  void idle() {}

  @override
  void removeObject() {
    add(OpacityEffect.to(0, EffectController(duration: 0.2),
        onComplete: () => super.removeObject()));
  }
}
