import 'package:dusty_flutter/models/protocols/const.dart';

class StatusParser {
  static direction(int status) => status & 0x3;
  static activeAvailable(int status) => (status >> 4) & 0x1;
  static specialAvailable(int status) => (status >> 5) & 0x1;
  static finishAvailable(int status) => (status >> 6) & 0x1;
  static boostAvailable(int status) => (status >> 7) & 0x1;
  static shieldAvailable(int status) => (status >> 8) & 0x1;
  static finishing(int status) => (status >> 7) & 0x1;
  static punching(int status) => (status >> 8) & 0x1;
  static DustyState dustyState(int status) =>
      DustyState.parse((status >> 9) & 0x3);
  static rafting(int status) => (status >> 12) & 0x1;
  static finishType(int status) => (status >> 13) & 0x3;
}
