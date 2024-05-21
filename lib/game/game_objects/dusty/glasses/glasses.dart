import 'package:dusty_flutter/game/game.dart';
import 'package:flame/components.dart';
import 'package:dusty_flutter/game/game_objects/dusty/const.dart';

class DustyGlasses extends SpriteGroupComponent<DustyGlassesType>
    with HasGameRef<DustyIslandGame> {
  late String _glassesName;
  int _parentAnimationIndex = 0;
  List<List<double>> offsets = [
    [0.25, 0.6], //0 default
    [0.2, 0.4], //1
    [0.15, 0.1], //2
    [0.1, 0.0], //3 bottom
    [0.15, 0.1], //4
    [0.2, 0.4], //5
    [0.25, 0.6], //6 default
    [0.3, 0.7], //7
    [0.35, 0.8], //8 top
    [0.3, 0.7], //9
  ];

  DustyGlasses({String glassesName = 'g0'}) {
    _glassesName = glassesName;
  }

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    sprites = {
      DustyGlassesType.idle:
          gameRef.atlas.findSpriteByName(_glassesName) as Sprite,
      DustyGlassesType.attack:
          gameRef.atlas.findSpriteByName('${_glassesName}_attack') as Sprite,
      DustyGlassesType.damaged:
          gameRef.atlas.findSpriteByName('${_glassesName}_damaged') as Sprite,
    };
    current = DustyGlassesType.idle;
    anchor = offsets.isEmpty
        ? Anchor.center
        : Anchor(offsets.first[0], offsets.first[1]);
  }

  void updatePosition(int? parentAnimationIndex) {
    if (parentAnimationIndex == null) return;
    if (parentAnimationIndex == _parentAnimationIndex) return;
    _parentAnimationIndex = parentAnimationIndex;
    if (offsets.isEmpty) return;
    if (parentAnimationIndex < offsets.length) {
      final offset = offsets[parentAnimationIndex];
      anchor = Anchor(offset[0], offset[1]);
    }
  }
}
