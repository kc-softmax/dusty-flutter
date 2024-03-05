import 'dart:typed_data';

enum DustyAction {
  idle(-1),
  one(1),
  two(2),
  three(3),
  four(4),
  five(5),
  six(6),
  seven(7),
  eight(8),
  nine(9),
  ten(10),
  eleven(11),
  twelve(12),
  rotateLeft(13),
  rotateRight(14),
  stop(15),
  forward(16),
  activeSkill(18),
  specialSkill(19),
  special2Skill(20),
  boost(21),
  finishing(22);

  final int code;
  const DustyAction(this.code);

  ByteBuffer encode() => Uint8List.fromList([code]).buffer;
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
