import 'package:flame/components.dart';
import 'package:flutter/material.dart';

// DustyHudButton({
//   super.button,
//   super.buttonDown,
//   super.margin,
//   super.onReleased,
//   super.onCancelled,
//   super.position,
//   super.size,
//   super.scale,
//   super.angle,
//   super.anchor,
//   super.children,
//   super.priority,
//   required this.reloadDuration,
//   this.handleButtonAction,
// }) {
//   super.onPressed = () {
//     handleButtonAction?.call(progress);
//   };
// }

class PollutionText extends TextBoxComponent {
  PollutionText({super.boxConfig});
  @override
  void drawBackground(Canvas c) {
    super.drawBackground(c);
    c.drawColor(Colors.transparent, BlendMode.clear);
  }
}
