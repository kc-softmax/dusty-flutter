import 'dart:math';

import 'package:dusty_flutter/game/game_objects/active_objects/active_objects_factory.dart';
import 'package:dusty_flutter/game/game.dart';
import 'package:dusty_flutter/game/base/object.dart';
import 'package:dusty_flutter/models/protocols/parser.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

class Axe extends SpriteAnimationComponent
    with
        HasGameRef<DustyIslandGame>,
        CollisionCallbacks,
        DIObject,
        ActiveObjects,
        MovingObject {
  late Vector2 initialPosition;
  int secondPosition;

  Axe(int objectId, {required this.secondPosition}) {
    this.objectId = objectId;
  }

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    final spriteList = gameRef.atlas.findSpritesByName('normal_axe');
    animation = SpriteAnimation.spriteList(
      spriteList,
      stepTime: 0.05,
    );

    scale = Vector2(0.25, 0.25);
    initialPosition = Vector2(x, y);
    nextPosition = Vector2(
        PositionParser.x(secondPosition), PositionParser.y(secondPosition));
    direction = Vector2(x, y);
    serverDelta = gameRef.playWorld!.serverDelta;
    // print(initialAngle);
    angle = (nextPosition - initialPosition).screenAngle() - pi * 0.5;
  }

  @override
  void update(double dt) {
    super.update(dt);
    position.add(movement(dt));
    final nextAngle = (position - initialPosition).screenAngle();
    if (nextAngle != 0) angle = nextAngle - pi * 0.5;
  }

  @override
  void idle() {}
}
