import 'package:flame/palette.dart';
import 'package:flame/text.dart';
import 'package:flutter/material.dart';

enum HudButtonType { circle, smallCircle }

enum GaugeBarColor {
  red('red_gauge');

  final String value;

  const GaugeBarColor(this.value);
}

class Priority {
  static const int low = 0;
  static const int normal = 1;
  static const int weapon = 2;
  static const int dusty = 3;
  static const int environment = 4;
  static const int environmentIntersected = 5;
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
const Color fireColor = Color(0xeeFC5403);
const Color lightningColor = Color(0xeeF7D851);
const Color yellowDusty = Color(0xffEFC992);
const Color gameBackgroundColor = Colors.black;
const Color curtonColor = Color(0xFFD9D9D9);
const Color dimColor = Color(0xFF333333);

final regularText = TextPaint(
  style: TextStyle(
    fontSize: 10.0,
    fontFamily: 'ONEMobilePOP',
    color: BasicPalette.white.color,
    shadows: [
      Shadow(
          color: BasicPalette.black.color,
          offset: const Offset(0, 0),
          blurRadius: 1),
    ],
  ),
);

enum RankingTableColumnsData {
  userId('ID'),
  userName('NAME'),
  team('TEAM'),
  kill('KILL'),
  death('DEATH'),
  territory('TERRITORY');

  final String label;
  const RankingTableColumnsData(this.label);
}
