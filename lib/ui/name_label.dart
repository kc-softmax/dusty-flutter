import 'package:dusty_flutter/characters/dusty.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class DustyNameLabel extends TextBoxComponent {
  static const textStyle = TextStyle(fontSize: 16);
  static const maxWidth = 100.0;
  static const topMargin = -16.0;

  DustyNameLabel(
    String text, {
    super.size,
  }) : super(
          text: text,
          align: Anchor.center,
          textRenderer: TextPaint(style: textStyle),
          boxConfig: TextBoxConfig(maxWidth: maxWidth),
        );

  @override
  Future<void> onLoad() {
    assert(parent is Dusty);
    center = _caclulateCenter();
    return super.onLoad();
  }

  @override
  void flipHorizontally() {
    super.flipHorizontally();
    // NOTE(@jaehong0721)
    // 부모(더스티)가 flip되어도 텍스트는 flip되지않도록
    // 새로운 좌표계에 맞는 center값으로 변경해준다.
    center = _caclulateCenter();
  }

  Vector2 _caclulateCenter() => Vector2(
        (parent as Dusty).size.x * 0.5,
        topMargin,
      );
}