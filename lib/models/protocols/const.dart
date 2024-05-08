import 'dart:typed_data';

enum DustyAction {
  stop(1),
  forward(2),
  rotateLeft(3),
  rotateRight(4),
  activeSkillDown(5),
  activeSkillUp(6),
  activeSkillCancel(7),
  specialSkillDown(8),
  specialSkillUp(9),
  specialSkillCancel(10),
  nne(11),
  ne(12),
  ene(13),
  e(14),
  ese(15),
  se(16),
  sse(17),
  s(18),
  ssw(19),
  sw(20),
  wsw(21),
  w(22),
  wnw(23),
  nw(24),
  nnw(25),
  n(26);

  final int code;
  const DustyAction(this.code);

  ByteBuffer encode({int value = 0}) {
    return Uint8List.fromList([code, value]).buffer;
  }

  int getDirectionIndex() {
    return code - 10;
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
