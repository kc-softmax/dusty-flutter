import 'dart:typed_data';

enum Direction {
  none(0),
  nne(1),
  ne(2),
  ene(3),
  e(4),
  ese(5),
  se(6),
  sse(7),
  s(8),
  ssw(9),
  sw(10),
  wsw(11),
  w(12),
  wnw(13),
  nw(14),
  nnw(15),
  n(16);

  final int code;
  const Direction(this.code);
}

enum WheelAction {
  forward(1),
  rotateLeft(2),
  rotateRight(3),
  stop(4);

  final int code;
  const WheelAction(this.code);
}

enum DustyAction {
  activeSkillDown(1),
  activeSkillUp(2),
  activeSkillCancel(3),
  specialSkillDown(4),
  specialSkillUp(5),
  specialSkillCancel(6),
  aimingLeft(7),
  aimingRight(8);

  final int code;
  const DustyAction(this.code);
}

enum ControlAction {
  wheelControl(1),
  immediateControl(2),
  active(3);

  final int code;
  const ControlAction(this.code);

  ByteBuffer encode({int value = 0}) {
    return Uint8List.fromList([code, value]).buffer;
  }
}

enum DustyState {
  normal(0),
  invisible(1),
  invincible(2);

  final int code;
  const DustyState(this.code);

  factory DustyState.parse(int code) =>
      DustyState.values.firstWhere((state) => code == state.code);
}

enum FinishType {
  fire(1),
  lightning(3);

  final int code;
  const FinishType(this.code);

  factory FinishType.parse(int code) =>
      FinishType.values.firstWhere((state) => code == state.code);
}

enum TileState {
  normal(0);

  final int code;
  const TileState(this.code);

  factory TileState.parse(int code) =>
      TileState.values.firstWhere((state) => code == state.code);
}
