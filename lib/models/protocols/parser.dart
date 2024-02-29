import 'package:dusty_flutter/arbiter/live_service/game_message.dart';
import 'package:dusty_flutter/models/protocols/const.dart';

class StatusParser {
  static direction(int status) => status & 0x3;
  static activeAvailable(int status) => (status >> 4) & 0x1;
  static specialAvailable(int status) => (status >> 5) & 0x1;
  static special2Available(int status) => (status >> 6) & 0x1;
  static finishAvailable(int status) => (status >> 7) & 0x1;
  static boostAvailable(int status) => (status >> 8) & 0x1;
  static isFinishing(int status) => (status >> 9) & 0x1;
  static isShield(int status) => (status >> 10) & 0x1;
  static isRiding(int status) => (status >> 11) & 0x1;
  static DustyState dustyState(int status) =>
      DustyState.parse((status >> 12) & 0x3);
  static FinishType finishType(int status) =>
      FinishType.parse((status >> 15) & 0x3);
  static finishGauge(int status) => (status >> 18) & 0xff;
}

class PositionParser {
  static double x(int position) => (position & 0xFFFF).toDouble();
  static double y(int position) => (position >> 16).toDouble();
}

class TileAddressParser {
  static int col(int address) => address & 0xff;
  static int row(int address) => address >> 8;
}

class TileStatusParser {
  static int tileIndex(int status) => status & 0xff;
  static Team team(int status) => Team.parse(status >> 8 & 0x3);
  static TileState state(int status) => TileState.parse(status >> 12 & 0x3);
  static int occupiedRate(int status) => status >> 16 & 0xff;
}

class ActiveStatusParser {
  static double size(int status) => (status & 0xff).toDouble();
  static double stride(int status) => (status >> 8 & 0xff).toDouble();
  static double life(int status) => (status >> 16).toDouble();
}
