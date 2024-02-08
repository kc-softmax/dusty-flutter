import 'package:flame/components.dart';

class NotifiableJoyStick extends JoystickComponent with Notifier {
  NotifiableJoyStick({
    super.knob,
    super.background,
    super.margin,
    super.position,
    super.size,
    super.knobRadius,
    super.anchor,
    super.children,
    super.priority,
    super.key,
  });

  @override
  void update(double dt) {
    final oldDelta = delta.copyInto(Vector2.zero());
    final oldIntensity = intensity;
    final oldDirection = direction;

    super.update(dt);

    if (oldIntensity != intensity &&
        (oldDelta.x != delta.x || oldDelta.y != delta.y) &&
        oldDirection != direction) {
      notifyListeners();
    }
  }
}
