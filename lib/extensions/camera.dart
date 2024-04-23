import 'package:flame/components.dart';
import 'package:flame/experimental.dart';

extension CameraCompoentExtension on CameraComponent {
  void setBoundToMapSize(double mapWidth, double mapHeight, double zoom) {
    setBounds(
      Rectangle.fromLTWH(
        viewport.size.x * 0.5 / zoom,
        viewport.size.y * 0.5 / zoom,
        mapWidth - (viewport.size.x / zoom),
        mapHeight - (viewport.size.y / zoom),
      ),
    );
  }
}
