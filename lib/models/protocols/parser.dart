import 'package:dusty_flutter/models/protocols/const.dart';

class StatusParser {
  static direction(int status) => status & 0x3;
  static activeAvailable(int status) => (status >> 4) & 0x1;
  static specialAvailable(int status) => (status >> 5) & 0x1;
  static finishAvailable(int status) => (status >> 6) & 0x1;
  static shieldAvailable(int status) => (status >> 7) & 0x1;
  static isFinishing(int status) => (status >> 8) & 0x1;
  static isRiding(int status) => (status >> 9) & 0x1;
  static DustyState dustyState(int status) =>
      DustyState.parse((status >> 10) & 0x3);
  static finishType(int status) => (status >> 13) & 0x3;
  static finishGauge(int status) => (status >> 16) & 0x4;
}

class PositionParser {
  static double x(int position) => (position & 0xFFFF).toDouble();
  static double y(int position) => (position >> 16).toDouble();
}

class TileAddressParser {
  static int col(int address) => address & 0xff;
  static int row(int address) => address >> 8;
}

class ActiveStatusParser {
  static double size(int status) => (status & 0xff).toDouble();
  static double stride(int status) => (status >> 8 & 0xff).toDouble();
  static double life(int status) => (status >> 16).toDouble();
}
