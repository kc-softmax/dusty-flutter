import 'dart:async';
import 'dart:math';
import 'dart:ui';

import 'package:dusty_flutter/arbiter/live_service/game_message.dart';
import 'package:dusty_flutter/mixins/game_mixin.dart';
import 'package:dusty_flutter/tiles/normal/normal_tile.dart';
import 'package:dusty_flutter/ui/const.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame_noise/flame_noise.dart';

abstract mixin class DustyTiles implements PositionComponent {
  factory DustyTiles.normal() => NormalTile()
    ..size = Vector2(48, 48)
    ..anchor = Anchor.center;
}

class TileGridComponent extends PositionComponent with Snapshot {
  Map<int, Team> tileMap = {};
  late final Paint alphaTilePaint;
  late final Paint beatTilePaint;

  // setBackgroundColor to random
  @override
  Future<void> onLoad() async {
    super.onLoad();
    alphaTilePaint = Paint()..color = alphaTileColor;
    beatTilePaint = Paint()..color = betaTileColor;

    // final random = Random();
    // tilePaint = Paint()
    //   ..color = Color.fromRGBO(
    //     random.nextInt(255),
    //     random.nextInt(255),
    //     random.nextInt(255),
    //     1,
    //   );
    // final color = Color.fromRGBO(
    //   random.nextInt(255),
    //   random.nextInt(255),
    //   random.nextInt(255),
    //   0.4,
    // );
    // final paint = Paint()..color = color;

    // add(RectangleComponent()
    //   ..size = size
    //   ..paint = paint);
  }

  void updateTile(
      int address, int row, int col, int tileIndex, Sprite tileSprite) {
    if (tileMap.containsKey(address)) {
      tileMap.remove(address);
    }
    tileMap[address] = Team.alpha;
    add(SpriteComponent(sprite: tileSprite)
      ..x = col * 32
      ..y = row * 32
      ..size = Vector2.all(32));
  }
}

class TileFactory extends ObjectFactoryComponent<DustyTiles, TileMessage> {
  static const int numOfTileInGrid = 20; // 20x20 grid
  late final Sprite alphaTile;
  late final Sprite betaTile;
  late final List<TileGridComponent> tileGrids;

  @override
  FutureOr<void> onLoad() {
    super.onLoad();
    tileGrids = [];
    alphaTile = gameRef.atlas.findSpriteByName('alpha_tile') as Sprite;
    betaTile = gameRef.atlas.findSpriteByName('beta_tile') as Sprite;
    // final mapComponent = gameRef.mapComponent;
    for (var i = 0; i < numOfTileInGrid; i++) {
      for (var j = 0; j < numOfTileInGrid; j++) {
        final tileGrid = TileGridComponent()
          ..size = Vector2.all(640)
          ..position = Vector2(i * 640, j * 640);
        tileGrids.add(tileGrid);
        gameRef.world.add(tileGrid);
      }
    }
  }

  @override
  DustyTiles facotry(TileMessage message) {
    return DustyTiles.normal();
  }

  @override
  void onGenerateObject(TileMessage message) {
    throw UnimplementedError('tile factory only supports onUpdateObject');
  }

  @override
  void onRemoveObject(TileMessage message) {
    // reset tile
    // ex) tile is occupied, remove occupied effect
    // ex) tile is burn, remove burn effect
  }

  @override
  void onUpdateObject(TileMessage message) {
    final mapComponent = gameRef.mapComponent;
    // get tileGrid
    final gridIndex = (message.col ~/ numOfTileInGrid) * numOfTileInGrid +
        (message.row ~/ numOfTileInGrid);
    final tileGrid = tileGrids[gridIndex];
    final tileRowInGrid = message.row % numOfTileInGrid;
    final tileColInGrid = message.col % numOfTileInGrid;
    final tileName =
        'pollution-${message.pollutionTileIndex - 1}'; // server add 1 value avoid zero
    final tileSprite = gameRef.atlas.findSpriteByName(tileName) as Sprite;
    // tempTileSprite not involved in tileGrid

    // consider anchor is center
    var worldPosition = Vector2(
        message.col * 32.toDouble() + 16, message.row * 32.toDouble() + 16);

    var spritePostion = worldPosition;
    if (gameRef.playScene.dustyFactory.objects
        .containsKey(message.occupierId)) {
      spritePostion =
          gameRef.playScene.dustyFactory.objects[message.occupierId]!.position;
    }

    final tempTileSprite =
        SpriteComponent(sprite: tileSprite, size: Vector2.all(32))
          ..anchor = Anchor.center
          ..position = spritePostion
          ..scale = Vector2.zero();
    tempTileSprite.addAll([
      MoveEffect.to(worldPosition, EffectController(duration: 0.5)),
      ScaleEffect.to(Vector2.all(1), EffectController(duration: 0.5)),
      ScaleEffect.to(Vector2.all(1),
          DelayedEffectController(EffectController(duration: 0.25), delay: 0.8))
        ..onComplete = () {
          tileGrid.takeSnapshot();
          tempTileSprite.removeFromParent();
        },
      MoveEffect.by(
        Vector2(-16, 16),
        DelayedEffectController(
            NoiseEffectController(
                duration: 0.25, noise: PerlinNoise(frequency: 5)),
            delay: 0.5),
      )..onComplete = () {
          tileGrid.updateTile(message.address, tileRowInGrid, tileColInGrid,
              message.tileIndex, tileSprite);
        },
    ]);
    gameRef.world.add(tempTileSprite);
  }
}
