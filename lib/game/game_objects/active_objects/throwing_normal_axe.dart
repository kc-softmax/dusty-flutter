import 'dart:math';

import 'package:dusty_flutter/game/game_objects/active_objects/active_objects_factory.dart';
import 'package:dusty_flutter/game/game.dart';
import 'package:dusty_flutter/game/base/object.dart';
import 'package:flame/components.dart';

class ThrowingNormalAxe extends SpriteComponent
    with
        HasGameRef<DustyIslandGame>,
        DIObject,
        ActiveObjects,
        MovingObject,
        HittingObject {
  late Vector2 initialPosition;

  ThrowingNormalAxe(int objectId) {
    this.objectId = objectId;
  }

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    sprite = gameRef.atlas.findSpriteByName('normal_axe');
    anchor = const Anchor(0.5, 0.7);
    initialPosition = Vector2(x, y);
    nextPosition = Vector2(x, y);
    direction = Vector2(x, y);
    serverDelta = gameRef.playWorld!.serverDelta;
  }

  @override
  void moveTo(Vector2 currentPosition, Vector2 moveToPosition) {
    super.moveTo(currentPosition, moveToPosition);
    final nextAngle = (nextPosition - position).screenAngle();
    if (nextAngle != 0) {
      if (nextAngle >= 0 && isFlippedHorizontally) {
        flipHorizontally();
      }
      if (nextAngle < 0 && !isFlippedHorizontally) {
        flipHorizontally();
      }
    }
  }

  @override
  void update(double dt) {
    super.update(dt);
    position.add(movement(dt));
    if (!isFlippedHorizontally) {
      angle += pi * 10 * dt;
    } else {
      angle -= pi * 10 * dt;
    }
    double anchorY = anchor.y;
    if (anchorY > 0.5) anchorY += -0.01;
    anchor = Anchor(0.5, anchorY);
  }

  @override
  void idle() {}

  @override
  void hit(DIObject? targetObject) {
    print('hit!!');
  }
}
