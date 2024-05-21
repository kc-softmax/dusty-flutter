import 'dart:math';
import 'dart:ui';

import 'package:dusty_flutter/game/game.dart';
import 'package:dusty_flutter/game/game_objects/passive_objects/passive_objects_factory.dart';
import 'package:dusty_flutter/game/base/object.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';

class NormalAxeItem extends SpriteComponent
    with HasGameRef<DustyIslandGame>, DIObject, PickupObject, PassiveObjects {
  late bool _isFacingRight;

  NormalAxeItem(int objectId, bool isFacingRight) {
    this.objectId = objectId;
    _isFacingRight = isFacingRight;
  }

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    sprite = gameRef.atlas.findSpriteByName('normal_axe_item') as Sprite;
    anchor = Anchor.center;
    if (!_isFacingRight) flipHorizontally();
  }

  @override
  void idle() {}

  @override
  void removeObject() {
    add(OpacityEffect.to(0, EffectController(duration: 0.2),
        onComplete: () => super.removeObject()));
  }

  @override
  void startPickup(int requireDuration) {
    super.startPickup(requireDuration);
    pickupDuration = requireDuration * gameRef.playWorld!.serverDelta;
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (isAttemptingPickup) {
      attemptTime += dt;
    }
  }

  @override
  void render(Canvas canvas) {
    if (isAttemptingPickup) {
      final rect = Rect.fromLTWH(0, height * 0.5, width * 1.2, width * 0.6);
      canvas.drawOval(rect, pickupBackgroundPaint);
      const startAngle = -pi / 2;
      final sweepAngle = pi * 2 * (attemptTime / pickupDuration);
      canvas.drawArc(rect, startAngle, sweepAngle, true, pickupPaint);
    }
    super.render(canvas);
  }
}
