import 'dart:ui';
import 'package:flame/components.dart';
import 'package:flutter/material.dart' hide Image;

Future<Image> createEmptyImage(Vector2 size) {
  final recorder = PictureRecorder();
  final canvas = Canvas(recorder);
  final paint = Paint()..color = Colors.transparent;
  canvas.drawRect(Rect.fromLTWH(0, 0, size.x, size.y), paint);
  final picture = recorder.endRecording();
  final img = picture.toImage(size.x.toInt(), size.y.toInt());
  return img;
}
