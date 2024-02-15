enum DustyGlassesType { idle, boost }

enum DustyBodyType { red, blue }

enum DustyBodyEffectType { none, shield, electricShock }

enum DustyState { normal, boost, shield }

DustyState dustyStateFromValue(int value) {
  switch (value) {
    case 0:
      return DustyState.normal;
    case 1:
      return DustyState.boost;
    case 2:
      return DustyState.shield;
    default:
      throw ArgumentError('Invalid value for DustyState: $value');
  }
}
