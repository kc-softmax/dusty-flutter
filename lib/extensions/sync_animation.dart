import 'package:flame/components.dart';

extension SyncAnimation on SpriteAnimationGroupComponent<Enum> {
  void changeState(Enum state, int? index) {
    current = state;
    if (index != null) {
      animationTickers?[current]?.currentIndex = index;
    }
  }
}
