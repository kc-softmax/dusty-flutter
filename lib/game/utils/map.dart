import 'dart:ui';

import 'package:flame_tiled/flame_tiled.dart';

Image mapToImage({required RenderableTiledMap tileMap}) {
  final recorder = PictureRecorder();
  final canvas = Canvas(recorder);
  tileMap.render(canvas);
  final picture = recorder.endRecording();

  final image = picture.toImageSync(tileMap.map.width * tileMap.map.tileWidth,
      tileMap.map.height * tileMap.map.tileHeight);
  picture.dispose();

  return image;
}
