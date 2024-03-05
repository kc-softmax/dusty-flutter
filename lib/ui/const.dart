import 'dart:ui';

import 'package:flame/palette.dart';
import 'package:flame/text.dart';

enum HudButtonType { circle, smallCircle }

class Priority {
  static const int low = 0;
  static const int normal = 1;
  static const int environment = 2;
  static const int environmentIntersected = 3;
}

// Colors
const Color neturalColor = Color(0xFFF2E2A1);
const Color boostColor = Color(0xFFE0C3A3);
const Color shieldColor = Color(0xFF30ACFF);
const Color clearSeaColor = Color(0xFF8FE6F5);
const Color normalSeaColor = Color(0xFF02ADDC);
const Color darkSeaColor = Color(0xFF1A708B);
const Color crimsonColor = Color(0xFFD0021B);
const Color alphaTeamColor = Color(0xFF4DAA13);
const Color betaTeamColor = Color(0xFF4D1518);
const Color alphaTileColor = Color(0x884DAA13);
const Color betaTileColor = Color(0x884D1518);

final regularText = TextPaint(
  style: TextStyle(
    fontSize: 12.0,
    color: BasicPalette.white.color,
    shadows: [
      Shadow(
        color: BasicPalette.black.color,
        offset: const Offset(2, 2),
        blurRadius: 1,
      ),
    ],
  ),
);
