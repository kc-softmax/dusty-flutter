import 'package:dusty_flutter/game/active_objects/active_objects_factory.dart';
import 'package:dusty_flutter/arbiter/live_service/game_message.dart';
import 'package:dusty_flutter/game/characters/dusty.dart';
import 'package:dusty_flutter/game/game.dart';
import 'package:flame/components.dart';

class NormalPunch extends SpriteAnimationComponent
    with HasGameRef<DustyIslandGame>, ActiveObjects {
  ActiveObjectMessage message;
  late Dusty owner;
  late Vector2 direction;
  late double lifeStep;
  NormalPunch({
    required this.message,
  }) : super(anchor: Anchor.center);

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    final spriteList =
        gameRef.atlas.findSpritesByName(message.team == 1 ? 'pm' : 'ym');
    animation = SpriteAnimation.spriteList(
      spriteList,
      stepTime: 0.05,
    );
    direction = Vector2(
      message.directionX! * 0.001,
      message.directionY! * 0.001,
    );
    lifeStep = message.lifeStep!.toDouble();
    owner = gameRef.playWorld!.dustyFactory.objects[message.ownerId] as Dusty;
  }

  @override
  void update(double dt) {
    super.update(dt);
    final rangeRatio = (lifeStep / message.lifeStep!) - 0.3;
    double speed;
    if (rangeRatio < 0) {
      // change direction
      final toDirection = Vector2(owner.x - x, owner.y - y);
      direction.lerp(toDirection, 0.02);
      direction = direction.normalized();
      speed = rangeRatio.abs() * toDirection.length;
    } else {
      speed = message.speed! * rangeRatio.abs() * 2;
    }
    position.add(direction *
        speed *
        gameRef.playWorld!.gameConfig!.frameRate.toDouble() *
        dt);
    lifeStep -= dt / gameRef.playWorld!.serverDelta;
  }
}
