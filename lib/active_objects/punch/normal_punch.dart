import 'package:dusty_flutter/active_objects/active_objects_factory.dart';
import 'package:dusty_flutter/arbiter/live_service/game_message.dart';
import 'package:dusty_flutter/characters/dusty.dart';
import 'package:dusty_flutter/game.dart';
import 'package:flame/components.dart';

class NormalPunch extends SpriteAnimationComponent
    with HasGameRef<DustyIslandGame>, ActiveObjects {
  ActiveObjectMessage message;
  late Dusty owner;
  late Vector2 direction;
  late double stride;
  late double life;
  NormalPunch({
    required this.message,
  }) : super(anchor: Anchor.center);

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    final spriteList = gameRef.atlas.findSpritesByName('bm');
    animation = SpriteAnimation.spriteList(
      spriteList,
      stepTime: 0.05,
    );
    direction = Vector2(
      message.directionX! * 0.001,
      message.directionY! * 0.001,
    );
    stride = message.stride!;
    life = message.life!;
    owner = gameRef.playScene.dustyFactory.objects[message.ownerId] as Dusty;
  }

  @override
  void update(double dt) {
    super.update(dt);
    final rangeRatio = (life / message.life!) - 0.3;
    if (rangeRatio < 0) {
      // change direction
      final toDirection = Vector2(owner.x - x, owner.y - y);
      direction.lerp(toDirection, 0.02);
      direction = direction.normalized();
      stride = rangeRatio.abs() * toDirection.length;
    } else {
      stride = message.stride! * rangeRatio.abs() * 2;
    }
    final speed = stride * gameRef.playScene.gameConfig!.frameRate * dt;
    position.add(direction * speed);
    life -= dt;
  }
}
