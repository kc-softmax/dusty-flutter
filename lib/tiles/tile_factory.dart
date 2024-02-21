import 'package:dusty_flutter/arbiter/live_service/game_message.dart';
import 'package:dusty_flutter/mixins/game_mixin.dart';
import 'package:dusty_flutter/tiles/normal/normal_tile.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame_noise/flame_noise.dart';

abstract mixin class DustyTiles implements SpriteAnimationComponent {
  factory DustyTiles.normal() => NormalTile()
    ..size = Vector2(64, 64)
    ..anchor = Anchor.center;
}

class TileFactory extends ObjectFactoryComponent<DustyTiles, TileMessage> {
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
    var tile = mapComponent.tileMap
        .getTileData(layerId: 5, x: message.col, y: message.row);
    mapComponent.tileMap
        .setTileData(layerId: 1, x: message.col, y: message.row, gid: tile!);

    gameRef.playScene.hud.minimap!.updateTile(message.col, message.row, 1);
  }
}
