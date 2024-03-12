// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'game_message.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

GameMessage _$GameMessageFromJson(Map<String, dynamic> json) {
  return _GameMessage.fromJson(json);
}

/// @nodoc
mixin _$GameMessage {
  GameConfig? get gameConfig => throw _privateConstructorUsedError;
  List<DustyMessage>? get dusties => throw _privateConstructorUsedError;
  List<ActiveObjectMessage>? get actives => throw _privateConstructorUsedError;
  List<PassiveObjectMessage>? get passives =>
      throw _privateConstructorUsedError;
  List<TileMessage>? get tiles => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $GameMessageCopyWith<GameMessage> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GameMessageCopyWith<$Res> {
  factory $GameMessageCopyWith(
          GameMessage value, $Res Function(GameMessage) then) =
      _$GameMessageCopyWithImpl<$Res, GameMessage>;
  @useResult
  $Res call(
      {GameConfig? gameConfig,
      List<DustyMessage>? dusties,
      List<ActiveObjectMessage>? actives,
      List<PassiveObjectMessage>? passives,
      List<TileMessage>? tiles});

  $GameConfigCopyWith<$Res>? get gameConfig;
}

/// @nodoc
class _$GameMessageCopyWithImpl<$Res, $Val extends GameMessage>
    implements $GameMessageCopyWith<$Res> {
  _$GameMessageCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? gameConfig = freezed,
    Object? dusties = freezed,
    Object? actives = freezed,
    Object? passives = freezed,
    Object? tiles = freezed,
  }) {
    return _then(_value.copyWith(
      gameConfig: freezed == gameConfig
          ? _value.gameConfig
          : gameConfig // ignore: cast_nullable_to_non_nullable
              as GameConfig?,
      dusties: freezed == dusties
          ? _value.dusties
          : dusties // ignore: cast_nullable_to_non_nullable
              as List<DustyMessage>?,
      actives: freezed == actives
          ? _value.actives
          : actives // ignore: cast_nullable_to_non_nullable
              as List<ActiveObjectMessage>?,
      passives: freezed == passives
          ? _value.passives
          : passives // ignore: cast_nullable_to_non_nullable
              as List<PassiveObjectMessage>?,
      tiles: freezed == tiles
          ? _value.tiles
          : tiles // ignore: cast_nullable_to_non_nullable
              as List<TileMessage>?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $GameConfigCopyWith<$Res>? get gameConfig {
    if (_value.gameConfig == null) {
      return null;
    }

    return $GameConfigCopyWith<$Res>(_value.gameConfig!, (value) {
      return _then(_value.copyWith(gameConfig: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$GameMessageImplCopyWith<$Res>
    implements $GameMessageCopyWith<$Res> {
  factory _$$GameMessageImplCopyWith(
          _$GameMessageImpl value, $Res Function(_$GameMessageImpl) then) =
      __$$GameMessageImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {GameConfig? gameConfig,
      List<DustyMessage>? dusties,
      List<ActiveObjectMessage>? actives,
      List<PassiveObjectMessage>? passives,
      List<TileMessage>? tiles});

  @override
  $GameConfigCopyWith<$Res>? get gameConfig;
}

/// @nodoc
class __$$GameMessageImplCopyWithImpl<$Res>
    extends _$GameMessageCopyWithImpl<$Res, _$GameMessageImpl>
    implements _$$GameMessageImplCopyWith<$Res> {
  __$$GameMessageImplCopyWithImpl(
      _$GameMessageImpl _value, $Res Function(_$GameMessageImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? gameConfig = freezed,
    Object? dusties = freezed,
    Object? actives = freezed,
    Object? passives = freezed,
    Object? tiles = freezed,
  }) {
    return _then(_$GameMessageImpl(
      gameConfig: freezed == gameConfig
          ? _value.gameConfig
          : gameConfig // ignore: cast_nullable_to_non_nullable
              as GameConfig?,
      dusties: freezed == dusties
          ? _value._dusties
          : dusties // ignore: cast_nullable_to_non_nullable
              as List<DustyMessage>?,
      actives: freezed == actives
          ? _value._actives
          : actives // ignore: cast_nullable_to_non_nullable
              as List<ActiveObjectMessage>?,
      passives: freezed == passives
          ? _value._passives
          : passives // ignore: cast_nullable_to_non_nullable
              as List<PassiveObjectMessage>?,
      tiles: freezed == tiles
          ? _value._tiles
          : tiles // ignore: cast_nullable_to_non_nullable
              as List<TileMessage>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$GameMessageImpl implements _GameMessage {
  const _$GameMessageImpl(
      {this.gameConfig,
      final List<DustyMessage>? dusties,
      final List<ActiveObjectMessage>? actives,
      final List<PassiveObjectMessage>? passives,
      final List<TileMessage>? tiles})
      : _dusties = dusties,
        _actives = actives,
        _passives = passives,
        _tiles = tiles;

  factory _$GameMessageImpl.fromJson(Map<String, dynamic> json) =>
      _$$GameMessageImplFromJson(json);

  @override
  final GameConfig? gameConfig;
  final List<DustyMessage>? _dusties;
  @override
  List<DustyMessage>? get dusties {
    final value = _dusties;
    if (value == null) return null;
    if (_dusties is EqualUnmodifiableListView) return _dusties;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<ActiveObjectMessage>? _actives;
  @override
  List<ActiveObjectMessage>? get actives {
    final value = _actives;
    if (value == null) return null;
    if (_actives is EqualUnmodifiableListView) return _actives;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<PassiveObjectMessage>? _passives;
  @override
  List<PassiveObjectMessage>? get passives {
    final value = _passives;
    if (value == null) return null;
    if (_passives is EqualUnmodifiableListView) return _passives;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<TileMessage>? _tiles;
  @override
  List<TileMessage>? get tiles {
    final value = _tiles;
    if (value == null) return null;
    if (_tiles is EqualUnmodifiableListView) return _tiles;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'GameMessage(gameConfig: $gameConfig, dusties: $dusties, actives: $actives, passives: $passives, tiles: $tiles)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GameMessageImpl &&
            (identical(other.gameConfig, gameConfig) ||
                other.gameConfig == gameConfig) &&
            const DeepCollectionEquality().equals(other._dusties, _dusties) &&
            const DeepCollectionEquality().equals(other._actives, _actives) &&
            const DeepCollectionEquality().equals(other._passives, _passives) &&
            const DeepCollectionEquality().equals(other._tiles, _tiles));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      gameConfig,
      const DeepCollectionEquality().hash(_dusties),
      const DeepCollectionEquality().hash(_actives),
      const DeepCollectionEquality().hash(_passives),
      const DeepCollectionEquality().hash(_tiles));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$GameMessageImplCopyWith<_$GameMessageImpl> get copyWith =>
      __$$GameMessageImplCopyWithImpl<_$GameMessageImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GameMessageImplToJson(
      this,
    );
  }
}

abstract class _GameMessage implements GameMessage {
  const factory _GameMessage(
      {final GameConfig? gameConfig,
      final List<DustyMessage>? dusties,
      final List<ActiveObjectMessage>? actives,
      final List<PassiveObjectMessage>? passives,
      final List<TileMessage>? tiles}) = _$GameMessageImpl;

  factory _GameMessage.fromJson(Map<String, dynamic> json) =
      _$GameMessageImpl.fromJson;

  @override
  GameConfig? get gameConfig;
  @override
  List<DustyMessage>? get dusties;
  @override
  List<ActiveObjectMessage>? get actives;
  @override
  List<PassiveObjectMessage>? get passives;
  @override
  List<TileMessage>? get tiles;
  @override
  @JsonKey(ignore: true)
  _$$GameMessageImplCopyWith<_$GameMessageImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

GameConfig _$GameConfigFromJson(Map<String, dynamic> json) {
  return _GameConfig.fromJson(json);
}

/// @nodoc
mixin _$GameConfig {
  int get playerId => throw _privateConstructorUsedError;
  int get frameRate => throw _privateConstructorUsedError;
  int get boostDuration => throw _privateConstructorUsedError;
  int get shieldDuration => throw _privateConstructorUsedError;
  int get finishDuration => throw _privateConstructorUsedError;
  int get boostSkillReloadTime => throw _privateConstructorUsedError;
  int get activeSkillDuration => throw _privateConstructorUsedError;
  int get specialSkillReloadTime => throw _privateConstructorUsedError;
  int get special2SkillReloadTime => throw _privateConstructorUsedError;
  int get raftReloadTime => throw _privateConstructorUsedError;
  int get respawnTime => throw _privateConstructorUsedError;
  int get grenadePowerUnit => throw _privateConstructorUsedError;
  int get defaultPunchRange => throw _privateConstructorUsedError;
  int get autoTargetingRange => throw _privateConstructorUsedError;
  int get autoTargetingAngle => throw _privateConstructorUsedError;
  int get totalOccupyableRegion => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $GameConfigCopyWith<GameConfig> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GameConfigCopyWith<$Res> {
  factory $GameConfigCopyWith(
          GameConfig value, $Res Function(GameConfig) then) =
      _$GameConfigCopyWithImpl<$Res, GameConfig>;
  @useResult
  $Res call(
      {int playerId,
      int frameRate,
      int boostDuration,
      int shieldDuration,
      int finishDuration,
      int boostSkillReloadTime,
      int activeSkillDuration,
      int specialSkillReloadTime,
      int special2SkillReloadTime,
      int raftReloadTime,
      int respawnTime,
      int grenadePowerUnit,
      int defaultPunchRange,
      int autoTargetingRange,
      int autoTargetingAngle,
      int totalOccupyableRegion});
}

/// @nodoc
class _$GameConfigCopyWithImpl<$Res, $Val extends GameConfig>
    implements $GameConfigCopyWith<$Res> {
  _$GameConfigCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? playerId = null,
    Object? frameRate = null,
    Object? boostDuration = null,
    Object? shieldDuration = null,
    Object? finishDuration = null,
    Object? boostSkillReloadTime = null,
    Object? activeSkillDuration = null,
    Object? specialSkillReloadTime = null,
    Object? special2SkillReloadTime = null,
    Object? raftReloadTime = null,
    Object? respawnTime = null,
    Object? grenadePowerUnit = null,
    Object? defaultPunchRange = null,
    Object? autoTargetingRange = null,
    Object? autoTargetingAngle = null,
    Object? totalOccupyableRegion = null,
  }) {
    return _then(_value.copyWith(
      playerId: null == playerId
          ? _value.playerId
          : playerId // ignore: cast_nullable_to_non_nullable
              as int,
      frameRate: null == frameRate
          ? _value.frameRate
          : frameRate // ignore: cast_nullable_to_non_nullable
              as int,
      boostDuration: null == boostDuration
          ? _value.boostDuration
          : boostDuration // ignore: cast_nullable_to_non_nullable
              as int,
      shieldDuration: null == shieldDuration
          ? _value.shieldDuration
          : shieldDuration // ignore: cast_nullable_to_non_nullable
              as int,
      finishDuration: null == finishDuration
          ? _value.finishDuration
          : finishDuration // ignore: cast_nullable_to_non_nullable
              as int,
      boostSkillReloadTime: null == boostSkillReloadTime
          ? _value.boostSkillReloadTime
          : boostSkillReloadTime // ignore: cast_nullable_to_non_nullable
              as int,
      activeSkillDuration: null == activeSkillDuration
          ? _value.activeSkillDuration
          : activeSkillDuration // ignore: cast_nullable_to_non_nullable
              as int,
      specialSkillReloadTime: null == specialSkillReloadTime
          ? _value.specialSkillReloadTime
          : specialSkillReloadTime // ignore: cast_nullable_to_non_nullable
              as int,
      special2SkillReloadTime: null == special2SkillReloadTime
          ? _value.special2SkillReloadTime
          : special2SkillReloadTime // ignore: cast_nullable_to_non_nullable
              as int,
      raftReloadTime: null == raftReloadTime
          ? _value.raftReloadTime
          : raftReloadTime // ignore: cast_nullable_to_non_nullable
              as int,
      respawnTime: null == respawnTime
          ? _value.respawnTime
          : respawnTime // ignore: cast_nullable_to_non_nullable
              as int,
      grenadePowerUnit: null == grenadePowerUnit
          ? _value.grenadePowerUnit
          : grenadePowerUnit // ignore: cast_nullable_to_non_nullable
              as int,
      defaultPunchRange: null == defaultPunchRange
          ? _value.defaultPunchRange
          : defaultPunchRange // ignore: cast_nullable_to_non_nullable
              as int,
      autoTargetingRange: null == autoTargetingRange
          ? _value.autoTargetingRange
          : autoTargetingRange // ignore: cast_nullable_to_non_nullable
              as int,
      autoTargetingAngle: null == autoTargetingAngle
          ? _value.autoTargetingAngle
          : autoTargetingAngle // ignore: cast_nullable_to_non_nullable
              as int,
      totalOccupyableRegion: null == totalOccupyableRegion
          ? _value.totalOccupyableRegion
          : totalOccupyableRegion // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$GameConfigImplCopyWith<$Res>
    implements $GameConfigCopyWith<$Res> {
  factory _$$GameConfigImplCopyWith(
          _$GameConfigImpl value, $Res Function(_$GameConfigImpl) then) =
      __$$GameConfigImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int playerId,
      int frameRate,
      int boostDuration,
      int shieldDuration,
      int finishDuration,
      int boostSkillReloadTime,
      int activeSkillDuration,
      int specialSkillReloadTime,
      int special2SkillReloadTime,
      int raftReloadTime,
      int respawnTime,
      int grenadePowerUnit,
      int defaultPunchRange,
      int autoTargetingRange,
      int autoTargetingAngle,
      int totalOccupyableRegion});
}

/// @nodoc
class __$$GameConfigImplCopyWithImpl<$Res>
    extends _$GameConfigCopyWithImpl<$Res, _$GameConfigImpl>
    implements _$$GameConfigImplCopyWith<$Res> {
  __$$GameConfigImplCopyWithImpl(
      _$GameConfigImpl _value, $Res Function(_$GameConfigImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? playerId = null,
    Object? frameRate = null,
    Object? boostDuration = null,
    Object? shieldDuration = null,
    Object? finishDuration = null,
    Object? boostSkillReloadTime = null,
    Object? activeSkillDuration = null,
    Object? specialSkillReloadTime = null,
    Object? special2SkillReloadTime = null,
    Object? raftReloadTime = null,
    Object? respawnTime = null,
    Object? grenadePowerUnit = null,
    Object? defaultPunchRange = null,
    Object? autoTargetingRange = null,
    Object? autoTargetingAngle = null,
    Object? totalOccupyableRegion = null,
  }) {
    return _then(_$GameConfigImpl(
      playerId: null == playerId
          ? _value.playerId
          : playerId // ignore: cast_nullable_to_non_nullable
              as int,
      frameRate: null == frameRate
          ? _value.frameRate
          : frameRate // ignore: cast_nullable_to_non_nullable
              as int,
      boostDuration: null == boostDuration
          ? _value.boostDuration
          : boostDuration // ignore: cast_nullable_to_non_nullable
              as int,
      shieldDuration: null == shieldDuration
          ? _value.shieldDuration
          : shieldDuration // ignore: cast_nullable_to_non_nullable
              as int,
      finishDuration: null == finishDuration
          ? _value.finishDuration
          : finishDuration // ignore: cast_nullable_to_non_nullable
              as int,
      boostSkillReloadTime: null == boostSkillReloadTime
          ? _value.boostSkillReloadTime
          : boostSkillReloadTime // ignore: cast_nullable_to_non_nullable
              as int,
      activeSkillDuration: null == activeSkillDuration
          ? _value.activeSkillDuration
          : activeSkillDuration // ignore: cast_nullable_to_non_nullable
              as int,
      specialSkillReloadTime: null == specialSkillReloadTime
          ? _value.specialSkillReloadTime
          : specialSkillReloadTime // ignore: cast_nullable_to_non_nullable
              as int,
      special2SkillReloadTime: null == special2SkillReloadTime
          ? _value.special2SkillReloadTime
          : special2SkillReloadTime // ignore: cast_nullable_to_non_nullable
              as int,
      raftReloadTime: null == raftReloadTime
          ? _value.raftReloadTime
          : raftReloadTime // ignore: cast_nullable_to_non_nullable
              as int,
      respawnTime: null == respawnTime
          ? _value.respawnTime
          : respawnTime // ignore: cast_nullable_to_non_nullable
              as int,
      grenadePowerUnit: null == grenadePowerUnit
          ? _value.grenadePowerUnit
          : grenadePowerUnit // ignore: cast_nullable_to_non_nullable
              as int,
      defaultPunchRange: null == defaultPunchRange
          ? _value.defaultPunchRange
          : defaultPunchRange // ignore: cast_nullable_to_non_nullable
              as int,
      autoTargetingRange: null == autoTargetingRange
          ? _value.autoTargetingRange
          : autoTargetingRange // ignore: cast_nullable_to_non_nullable
              as int,
      autoTargetingAngle: null == autoTargetingAngle
          ? _value.autoTargetingAngle
          : autoTargetingAngle // ignore: cast_nullable_to_non_nullable
              as int,
      totalOccupyableRegion: null == totalOccupyableRegion
          ? _value.totalOccupyableRegion
          : totalOccupyableRegion // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$GameConfigImpl implements _GameConfig {
  const _$GameConfigImpl(
      {required this.playerId,
      required this.frameRate,
      required this.boostDuration,
      required this.shieldDuration,
      required this.finishDuration,
      required this.boostSkillReloadTime,
      required this.activeSkillDuration,
      required this.specialSkillReloadTime,
      required this.special2SkillReloadTime,
      required this.raftReloadTime,
      required this.respawnTime,
      required this.grenadePowerUnit,
      required this.defaultPunchRange,
      required this.autoTargetingRange,
      required this.autoTargetingAngle,
      required this.totalOccupyableRegion});

  factory _$GameConfigImpl.fromJson(Map<String, dynamic> json) =>
      _$$GameConfigImplFromJson(json);

  @override
  final int playerId;
  @override
  final int frameRate;
  @override
  final int boostDuration;
  @override
  final int shieldDuration;
  @override
  final int finishDuration;
  @override
  final int boostSkillReloadTime;
  @override
  final int activeSkillDuration;
  @override
  final int specialSkillReloadTime;
  @override
  final int special2SkillReloadTime;
  @override
  final int raftReloadTime;
  @override
  final int respawnTime;
  @override
  final int grenadePowerUnit;
  @override
  final int defaultPunchRange;
  @override
  final int autoTargetingRange;
  @override
  final int autoTargetingAngle;
  @override
  final int totalOccupyableRegion;

  @override
  String toString() {
    return 'GameConfig(playerId: $playerId, frameRate: $frameRate, boostDuration: $boostDuration, shieldDuration: $shieldDuration, finishDuration: $finishDuration, boostSkillReloadTime: $boostSkillReloadTime, activeSkillDuration: $activeSkillDuration, specialSkillReloadTime: $specialSkillReloadTime, special2SkillReloadTime: $special2SkillReloadTime, raftReloadTime: $raftReloadTime, respawnTime: $respawnTime, grenadePowerUnit: $grenadePowerUnit, defaultPunchRange: $defaultPunchRange, autoTargetingRange: $autoTargetingRange, autoTargetingAngle: $autoTargetingAngle, totalOccupyableRegion: $totalOccupyableRegion)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GameConfigImpl &&
            (identical(other.playerId, playerId) ||
                other.playerId == playerId) &&
            (identical(other.frameRate, frameRate) ||
                other.frameRate == frameRate) &&
            (identical(other.boostDuration, boostDuration) ||
                other.boostDuration == boostDuration) &&
            (identical(other.shieldDuration, shieldDuration) ||
                other.shieldDuration == shieldDuration) &&
            (identical(other.finishDuration, finishDuration) ||
                other.finishDuration == finishDuration) &&
            (identical(other.boostSkillReloadTime, boostSkillReloadTime) ||
                other.boostSkillReloadTime == boostSkillReloadTime) &&
            (identical(other.activeSkillDuration, activeSkillDuration) ||
                other.activeSkillDuration == activeSkillDuration) &&
            (identical(other.specialSkillReloadTime, specialSkillReloadTime) ||
                other.specialSkillReloadTime == specialSkillReloadTime) &&
            (identical(
                    other.special2SkillReloadTime, special2SkillReloadTime) ||
                other.special2SkillReloadTime == special2SkillReloadTime) &&
            (identical(other.raftReloadTime, raftReloadTime) ||
                other.raftReloadTime == raftReloadTime) &&
            (identical(other.respawnTime, respawnTime) ||
                other.respawnTime == respawnTime) &&
            (identical(other.grenadePowerUnit, grenadePowerUnit) ||
                other.grenadePowerUnit == grenadePowerUnit) &&
            (identical(other.defaultPunchRange, defaultPunchRange) ||
                other.defaultPunchRange == defaultPunchRange) &&
            (identical(other.autoTargetingRange, autoTargetingRange) ||
                other.autoTargetingRange == autoTargetingRange) &&
            (identical(other.autoTargetingAngle, autoTargetingAngle) ||
                other.autoTargetingAngle == autoTargetingAngle) &&
            (identical(other.totalOccupyableRegion, totalOccupyableRegion) ||
                other.totalOccupyableRegion == totalOccupyableRegion));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      playerId,
      frameRate,
      boostDuration,
      shieldDuration,
      finishDuration,
      boostSkillReloadTime,
      activeSkillDuration,
      specialSkillReloadTime,
      special2SkillReloadTime,
      raftReloadTime,
      respawnTime,
      grenadePowerUnit,
      defaultPunchRange,
      autoTargetingRange,
      autoTargetingAngle,
      totalOccupyableRegion);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$GameConfigImplCopyWith<_$GameConfigImpl> get copyWith =>
      __$$GameConfigImplCopyWithImpl<_$GameConfigImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GameConfigImplToJson(
      this,
    );
  }
}

abstract class _GameConfig implements GameConfig {
  const factory _GameConfig(
      {required final int playerId,
      required final int frameRate,
      required final int boostDuration,
      required final int shieldDuration,
      required final int finishDuration,
      required final int boostSkillReloadTime,
      required final int activeSkillDuration,
      required final int specialSkillReloadTime,
      required final int special2SkillReloadTime,
      required final int raftReloadTime,
      required final int respawnTime,
      required final int grenadePowerUnit,
      required final int defaultPunchRange,
      required final int autoTargetingRange,
      required final int autoTargetingAngle,
      required final int totalOccupyableRegion}) = _$GameConfigImpl;

  factory _GameConfig.fromJson(Map<String, dynamic> json) =
      _$GameConfigImpl.fromJson;

  @override
  int get playerId;
  @override
  int get frameRate;
  @override
  int get boostDuration;
  @override
  int get shieldDuration;
  @override
  int get finishDuration;
  @override
  int get boostSkillReloadTime;
  @override
  int get activeSkillDuration;
  @override
  int get specialSkillReloadTime;
  @override
  int get special2SkillReloadTime;
  @override
  int get raftReloadTime;
  @override
  int get respawnTime;
  @override
  int get grenadePowerUnit;
  @override
  int get defaultPunchRange;
  @override
  int get autoTargetingRange;
  @override
  int get autoTargetingAngle;
  @override
  int get totalOccupyableRegion;
  @override
  @JsonKey(ignore: true)
  _$$GameConfigImplCopyWith<_$GameConfigImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

DustyMessage _$DustyMessageFromJson(Map<String, dynamic> json) {
  return _DustyMessage.fromJson(json);
}

/// @nodoc
mixin _$DustyMessage {
  int get dustyId => throw _privateConstructorUsedError;
  EventType get eventType => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;
  Team? get team => throw _privateConstructorUsedError;
  int? get status => throw _privateConstructorUsedError;
  int? get position => throw _privateConstructorUsedError;
  int? get targetId => throw _privateConstructorUsedError;
  int? get killerId => throw _privateConstructorUsedError;
  int? get quantity => throw _privateConstructorUsedError;
  int? get defence => throw _privateConstructorUsedError;
  RemoveBy? get removeBy => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DustyMessageCopyWith<DustyMessage> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DustyMessageCopyWith<$Res> {
  factory $DustyMessageCopyWith(
          DustyMessage value, $Res Function(DustyMessage) then) =
      _$DustyMessageCopyWithImpl<$Res, DustyMessage>;
  @useResult
  $Res call(
      {int dustyId,
      EventType eventType,
      String? name,
      Team? team,
      int? status,
      int? position,
      int? targetId,
      int? killerId,
      int? quantity,
      int? defence,
      RemoveBy? removeBy});
}

/// @nodoc
class _$DustyMessageCopyWithImpl<$Res, $Val extends DustyMessage>
    implements $DustyMessageCopyWith<$Res> {
  _$DustyMessageCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? dustyId = null,
    Object? eventType = null,
    Object? name = freezed,
    Object? team = freezed,
    Object? status = freezed,
    Object? position = freezed,
    Object? targetId = freezed,
    Object? killerId = freezed,
    Object? quantity = freezed,
    Object? defence = freezed,
    Object? removeBy = freezed,
  }) {
    return _then(_value.copyWith(
      dustyId: null == dustyId
          ? _value.dustyId
          : dustyId // ignore: cast_nullable_to_non_nullable
              as int,
      eventType: null == eventType
          ? _value.eventType
          : eventType // ignore: cast_nullable_to_non_nullable
              as EventType,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      team: freezed == team
          ? _value.team
          : team // ignore: cast_nullable_to_non_nullable
              as Team?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as int?,
      position: freezed == position
          ? _value.position
          : position // ignore: cast_nullable_to_non_nullable
              as int?,
      targetId: freezed == targetId
          ? _value.targetId
          : targetId // ignore: cast_nullable_to_non_nullable
              as int?,
      killerId: freezed == killerId
          ? _value.killerId
          : killerId // ignore: cast_nullable_to_non_nullable
              as int?,
      quantity: freezed == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as int?,
      defence: freezed == defence
          ? _value.defence
          : defence // ignore: cast_nullable_to_non_nullable
              as int?,
      removeBy: freezed == removeBy
          ? _value.removeBy
          : removeBy // ignore: cast_nullable_to_non_nullable
              as RemoveBy?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DustyMessageImplCopyWith<$Res>
    implements $DustyMessageCopyWith<$Res> {
  factory _$$DustyMessageImplCopyWith(
          _$DustyMessageImpl value, $Res Function(_$DustyMessageImpl) then) =
      __$$DustyMessageImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int dustyId,
      EventType eventType,
      String? name,
      Team? team,
      int? status,
      int? position,
      int? targetId,
      int? killerId,
      int? quantity,
      int? defence,
      RemoveBy? removeBy});
}

/// @nodoc
class __$$DustyMessageImplCopyWithImpl<$Res>
    extends _$DustyMessageCopyWithImpl<$Res, _$DustyMessageImpl>
    implements _$$DustyMessageImplCopyWith<$Res> {
  __$$DustyMessageImplCopyWithImpl(
      _$DustyMessageImpl _value, $Res Function(_$DustyMessageImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? dustyId = null,
    Object? eventType = null,
    Object? name = freezed,
    Object? team = freezed,
    Object? status = freezed,
    Object? position = freezed,
    Object? targetId = freezed,
    Object? killerId = freezed,
    Object? quantity = freezed,
    Object? defence = freezed,
    Object? removeBy = freezed,
  }) {
    return _then(_$DustyMessageImpl(
      dustyId: null == dustyId
          ? _value.dustyId
          : dustyId // ignore: cast_nullable_to_non_nullable
              as int,
      eventType: null == eventType
          ? _value.eventType
          : eventType // ignore: cast_nullable_to_non_nullable
              as EventType,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      team: freezed == team
          ? _value.team
          : team // ignore: cast_nullable_to_non_nullable
              as Team?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as int?,
      position: freezed == position
          ? _value.position
          : position // ignore: cast_nullable_to_non_nullable
              as int?,
      targetId: freezed == targetId
          ? _value.targetId
          : targetId // ignore: cast_nullable_to_non_nullable
              as int?,
      killerId: freezed == killerId
          ? _value.killerId
          : killerId // ignore: cast_nullable_to_non_nullable
              as int?,
      quantity: freezed == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as int?,
      defence: freezed == defence
          ? _value.defence
          : defence // ignore: cast_nullable_to_non_nullable
              as int?,
      removeBy: freezed == removeBy
          ? _value.removeBy
          : removeBy // ignore: cast_nullable_to_non_nullable
              as RemoveBy?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DustyMessageImpl extends _DustyMessage {
  _$DustyMessageImpl(
      {required this.dustyId,
      required this.eventType,
      this.name,
      this.team,
      this.status,
      this.position,
      this.targetId,
      this.killerId,
      this.quantity,
      this.defence,
      this.removeBy})
      : super._();

  factory _$DustyMessageImpl.fromJson(Map<String, dynamic> json) =>
      _$$DustyMessageImplFromJson(json);

  @override
  final int dustyId;
  @override
  final EventType eventType;
  @override
  final String? name;
  @override
  final Team? team;
  @override
  final int? status;
  @override
  final int? position;
  @override
  final int? targetId;
  @override
  final int? killerId;
  @override
  final int? quantity;
  @override
  final int? defence;
  @override
  final RemoveBy? removeBy;

  @override
  String toString() {
    return 'DustyMessage(dustyId: $dustyId, eventType: $eventType, name: $name, team: $team, status: $status, position: $position, targetId: $targetId, killerId: $killerId, quantity: $quantity, defence: $defence, removeBy: $removeBy)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DustyMessageImpl &&
            (identical(other.dustyId, dustyId) || other.dustyId == dustyId) &&
            (identical(other.eventType, eventType) ||
                other.eventType == eventType) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.team, team) || other.team == team) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.position, position) ||
                other.position == position) &&
            (identical(other.targetId, targetId) ||
                other.targetId == targetId) &&
            (identical(other.killerId, killerId) ||
                other.killerId == killerId) &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity) &&
            (identical(other.defence, defence) || other.defence == defence) &&
            (identical(other.removeBy, removeBy) ||
                other.removeBy == removeBy));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, dustyId, eventType, name, team,
      status, position, targetId, killerId, quantity, defence, removeBy);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DustyMessageImplCopyWith<_$DustyMessageImpl> get copyWith =>
      __$$DustyMessageImplCopyWithImpl<_$DustyMessageImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DustyMessageImplToJson(
      this,
    );
  }
}

abstract class _DustyMessage extends DustyMessage {
  factory _DustyMessage(
      {required final int dustyId,
      required final EventType eventType,
      final String? name,
      final Team? team,
      final int? status,
      final int? position,
      final int? targetId,
      final int? killerId,
      final int? quantity,
      final int? defence,
      final RemoveBy? removeBy}) = _$DustyMessageImpl;
  _DustyMessage._() : super._();

  factory _DustyMessage.fromJson(Map<String, dynamic> json) =
      _$DustyMessageImpl.fromJson;

  @override
  int get dustyId;
  @override
  EventType get eventType;
  @override
  String? get name;
  @override
  Team? get team;
  @override
  int? get status;
  @override
  int? get position;
  @override
  int? get targetId;
  @override
  int? get killerId;
  @override
  int? get quantity;
  @override
  int? get defence;
  @override
  RemoveBy? get removeBy;
  @override
  @JsonKey(ignore: true)
  _$$DustyMessageImplCopyWith<_$DustyMessageImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ActiveObjectMessage _$ActiveObjectMessageFromJson(Map<String, dynamic> json) {
  return _ActiveObjectMessage.fromJson(json);
}

/// @nodoc
mixin _$ActiveObjectMessage {
  int get objectId => throw _privateConstructorUsedError;
  EventType get eventType => throw _privateConstructorUsedError;
  int? get team => throw _privateConstructorUsedError;
  double? get directionX => throw _privateConstructorUsedError;
  double? get directionY => throw _privateConstructorUsedError;
  double? get gravity => throw _privateConstructorUsedError;
  double? get lifeStep => throw _privateConstructorUsedError;
  int? get speed => throw _privateConstructorUsedError;
  int? get position => throw _privateConstructorUsedError;
  int? get destination => throw _privateConstructorUsedError;
  int? get targetId => throw _privateConstructorUsedError;
  int? get ownerId => throw _privateConstructorUsedError;
  ActiveObjectType? get objectType => throw _privateConstructorUsedError;
  RemoveBy? get removeBy => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ActiveObjectMessageCopyWith<ActiveObjectMessage> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ActiveObjectMessageCopyWith<$Res> {
  factory $ActiveObjectMessageCopyWith(
          ActiveObjectMessage value, $Res Function(ActiveObjectMessage) then) =
      _$ActiveObjectMessageCopyWithImpl<$Res, ActiveObjectMessage>;
  @useResult
  $Res call(
      {int objectId,
      EventType eventType,
      int? team,
      double? directionX,
      double? directionY,
      double? gravity,
      double? lifeStep,
      int? speed,
      int? position,
      int? destination,
      int? targetId,
      int? ownerId,
      ActiveObjectType? objectType,
      RemoveBy? removeBy});
}

/// @nodoc
class _$ActiveObjectMessageCopyWithImpl<$Res, $Val extends ActiveObjectMessage>
    implements $ActiveObjectMessageCopyWith<$Res> {
  _$ActiveObjectMessageCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? objectId = null,
    Object? eventType = null,
    Object? team = freezed,
    Object? directionX = freezed,
    Object? directionY = freezed,
    Object? gravity = freezed,
    Object? lifeStep = freezed,
    Object? speed = freezed,
    Object? position = freezed,
    Object? destination = freezed,
    Object? targetId = freezed,
    Object? ownerId = freezed,
    Object? objectType = freezed,
    Object? removeBy = freezed,
  }) {
    return _then(_value.copyWith(
      objectId: null == objectId
          ? _value.objectId
          : objectId // ignore: cast_nullable_to_non_nullable
              as int,
      eventType: null == eventType
          ? _value.eventType
          : eventType // ignore: cast_nullable_to_non_nullable
              as EventType,
      team: freezed == team
          ? _value.team
          : team // ignore: cast_nullable_to_non_nullable
              as int?,
      directionX: freezed == directionX
          ? _value.directionX
          : directionX // ignore: cast_nullable_to_non_nullable
              as double?,
      directionY: freezed == directionY
          ? _value.directionY
          : directionY // ignore: cast_nullable_to_non_nullable
              as double?,
      gravity: freezed == gravity
          ? _value.gravity
          : gravity // ignore: cast_nullable_to_non_nullable
              as double?,
      lifeStep: freezed == lifeStep
          ? _value.lifeStep
          : lifeStep // ignore: cast_nullable_to_non_nullable
              as double?,
      speed: freezed == speed
          ? _value.speed
          : speed // ignore: cast_nullable_to_non_nullable
              as int?,
      position: freezed == position
          ? _value.position
          : position // ignore: cast_nullable_to_non_nullable
              as int?,
      destination: freezed == destination
          ? _value.destination
          : destination // ignore: cast_nullable_to_non_nullable
              as int?,
      targetId: freezed == targetId
          ? _value.targetId
          : targetId // ignore: cast_nullable_to_non_nullable
              as int?,
      ownerId: freezed == ownerId
          ? _value.ownerId
          : ownerId // ignore: cast_nullable_to_non_nullable
              as int?,
      objectType: freezed == objectType
          ? _value.objectType
          : objectType // ignore: cast_nullable_to_non_nullable
              as ActiveObjectType?,
      removeBy: freezed == removeBy
          ? _value.removeBy
          : removeBy // ignore: cast_nullable_to_non_nullable
              as RemoveBy?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ActiveObjectMessageImplCopyWith<$Res>
    implements $ActiveObjectMessageCopyWith<$Res> {
  factory _$$ActiveObjectMessageImplCopyWith(_$ActiveObjectMessageImpl value,
          $Res Function(_$ActiveObjectMessageImpl) then) =
      __$$ActiveObjectMessageImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int objectId,
      EventType eventType,
      int? team,
      double? directionX,
      double? directionY,
      double? gravity,
      double? lifeStep,
      int? speed,
      int? position,
      int? destination,
      int? targetId,
      int? ownerId,
      ActiveObjectType? objectType,
      RemoveBy? removeBy});
}

/// @nodoc
class __$$ActiveObjectMessageImplCopyWithImpl<$Res>
    extends _$ActiveObjectMessageCopyWithImpl<$Res, _$ActiveObjectMessageImpl>
    implements _$$ActiveObjectMessageImplCopyWith<$Res> {
  __$$ActiveObjectMessageImplCopyWithImpl(_$ActiveObjectMessageImpl _value,
      $Res Function(_$ActiveObjectMessageImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? objectId = null,
    Object? eventType = null,
    Object? team = freezed,
    Object? directionX = freezed,
    Object? directionY = freezed,
    Object? gravity = freezed,
    Object? lifeStep = freezed,
    Object? speed = freezed,
    Object? position = freezed,
    Object? destination = freezed,
    Object? targetId = freezed,
    Object? ownerId = freezed,
    Object? objectType = freezed,
    Object? removeBy = freezed,
  }) {
    return _then(_$ActiveObjectMessageImpl(
      objectId: null == objectId
          ? _value.objectId
          : objectId // ignore: cast_nullable_to_non_nullable
              as int,
      eventType: null == eventType
          ? _value.eventType
          : eventType // ignore: cast_nullable_to_non_nullable
              as EventType,
      team: freezed == team
          ? _value.team
          : team // ignore: cast_nullable_to_non_nullable
              as int?,
      directionX: freezed == directionX
          ? _value.directionX
          : directionX // ignore: cast_nullable_to_non_nullable
              as double?,
      directionY: freezed == directionY
          ? _value.directionY
          : directionY // ignore: cast_nullable_to_non_nullable
              as double?,
      gravity: freezed == gravity
          ? _value.gravity
          : gravity // ignore: cast_nullable_to_non_nullable
              as double?,
      lifeStep: freezed == lifeStep
          ? _value.lifeStep
          : lifeStep // ignore: cast_nullable_to_non_nullable
              as double?,
      speed: freezed == speed
          ? _value.speed
          : speed // ignore: cast_nullable_to_non_nullable
              as int?,
      position: freezed == position
          ? _value.position
          : position // ignore: cast_nullable_to_non_nullable
              as int?,
      destination: freezed == destination
          ? _value.destination
          : destination // ignore: cast_nullable_to_non_nullable
              as int?,
      targetId: freezed == targetId
          ? _value.targetId
          : targetId // ignore: cast_nullable_to_non_nullable
              as int?,
      ownerId: freezed == ownerId
          ? _value.ownerId
          : ownerId // ignore: cast_nullable_to_non_nullable
              as int?,
      objectType: freezed == objectType
          ? _value.objectType
          : objectType // ignore: cast_nullable_to_non_nullable
              as ActiveObjectType?,
      removeBy: freezed == removeBy
          ? _value.removeBy
          : removeBy // ignore: cast_nullable_to_non_nullable
              as RemoveBy?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ActiveObjectMessageImpl extends _ActiveObjectMessage {
  _$ActiveObjectMessageImpl(
      {required this.objectId,
      required this.eventType,
      this.team,
      this.directionX,
      this.directionY,
      this.gravity,
      this.lifeStep,
      this.speed,
      this.position,
      this.destination,
      this.targetId,
      this.ownerId,
      this.objectType,
      this.removeBy})
      : super._();

  factory _$ActiveObjectMessageImpl.fromJson(Map<String, dynamic> json) =>
      _$$ActiveObjectMessageImplFromJson(json);

  @override
  final int objectId;
  @override
  final EventType eventType;
  @override
  final int? team;
  @override
  final double? directionX;
  @override
  final double? directionY;
  @override
  final double? gravity;
  @override
  final double? lifeStep;
  @override
  final int? speed;
  @override
  final int? position;
  @override
  final int? destination;
  @override
  final int? targetId;
  @override
  final int? ownerId;
  @override
  final ActiveObjectType? objectType;
  @override
  final RemoveBy? removeBy;

  @override
  String toString() {
    return 'ActiveObjectMessage(objectId: $objectId, eventType: $eventType, team: $team, directionX: $directionX, directionY: $directionY, gravity: $gravity, lifeStep: $lifeStep, speed: $speed, position: $position, destination: $destination, targetId: $targetId, ownerId: $ownerId, objectType: $objectType, removeBy: $removeBy)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ActiveObjectMessageImpl &&
            (identical(other.objectId, objectId) ||
                other.objectId == objectId) &&
            (identical(other.eventType, eventType) ||
                other.eventType == eventType) &&
            (identical(other.team, team) || other.team == team) &&
            (identical(other.directionX, directionX) ||
                other.directionX == directionX) &&
            (identical(other.directionY, directionY) ||
                other.directionY == directionY) &&
            (identical(other.gravity, gravity) || other.gravity == gravity) &&
            (identical(other.lifeStep, lifeStep) ||
                other.lifeStep == lifeStep) &&
            (identical(other.speed, speed) || other.speed == speed) &&
            (identical(other.position, position) ||
                other.position == position) &&
            (identical(other.destination, destination) ||
                other.destination == destination) &&
            (identical(other.targetId, targetId) ||
                other.targetId == targetId) &&
            (identical(other.ownerId, ownerId) || other.ownerId == ownerId) &&
            (identical(other.objectType, objectType) ||
                other.objectType == objectType) &&
            (identical(other.removeBy, removeBy) ||
                other.removeBy == removeBy));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      objectId,
      eventType,
      team,
      directionX,
      directionY,
      gravity,
      lifeStep,
      speed,
      position,
      destination,
      targetId,
      ownerId,
      objectType,
      removeBy);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ActiveObjectMessageImplCopyWith<_$ActiveObjectMessageImpl> get copyWith =>
      __$$ActiveObjectMessageImplCopyWithImpl<_$ActiveObjectMessageImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ActiveObjectMessageImplToJson(
      this,
    );
  }
}

abstract class _ActiveObjectMessage extends ActiveObjectMessage {
  factory _ActiveObjectMessage(
      {required final int objectId,
      required final EventType eventType,
      final int? team,
      final double? directionX,
      final double? directionY,
      final double? gravity,
      final double? lifeStep,
      final int? speed,
      final int? position,
      final int? destination,
      final int? targetId,
      final int? ownerId,
      final ActiveObjectType? objectType,
      final RemoveBy? removeBy}) = _$ActiveObjectMessageImpl;
  _ActiveObjectMessage._() : super._();

  factory _ActiveObjectMessage.fromJson(Map<String, dynamic> json) =
      _$ActiveObjectMessageImpl.fromJson;

  @override
  int get objectId;
  @override
  EventType get eventType;
  @override
  int? get team;
  @override
  double? get directionX;
  @override
  double? get directionY;
  @override
  double? get gravity;
  @override
  double? get lifeStep;
  @override
  int? get speed;
  @override
  int? get position;
  @override
  int? get destination;
  @override
  int? get targetId;
  @override
  int? get ownerId;
  @override
  ActiveObjectType? get objectType;
  @override
  RemoveBy? get removeBy;
  @override
  @JsonKey(ignore: true)
  _$$ActiveObjectMessageImplCopyWith<_$ActiveObjectMessageImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

PassiveObjectMessage _$PassiveObjectMessageFromJson(Map<String, dynamic> json) {
  return _PassiveObjectMessage.fromJson(json);
}

/// @nodoc
mixin _$PassiveObjectMessage {
  int get objectId => throw _privateConstructorUsedError;
  EventType get eventType => throw _privateConstructorUsedError;
  int? get team => throw _privateConstructorUsedError;
  int? get size => throw _privateConstructorUsedError;
  int? get position => throw _privateConstructorUsedError;
  int? get generatePosition => throw _privateConstructorUsedError;
  PassiveObjectType? get objectType => throw _privateConstructorUsedError;
  int? get acquireBy => throw _privateConstructorUsedError;
  RemoveBy? get removeBy => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PassiveObjectMessageCopyWith<PassiveObjectMessage> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PassiveObjectMessageCopyWith<$Res> {
  factory $PassiveObjectMessageCopyWith(PassiveObjectMessage value,
          $Res Function(PassiveObjectMessage) then) =
      _$PassiveObjectMessageCopyWithImpl<$Res, PassiveObjectMessage>;
  @useResult
  $Res call(
      {int objectId,
      EventType eventType,
      int? team,
      int? size,
      int? position,
      int? generatePosition,
      PassiveObjectType? objectType,
      int? acquireBy,
      RemoveBy? removeBy});
}

/// @nodoc
class _$PassiveObjectMessageCopyWithImpl<$Res,
        $Val extends PassiveObjectMessage>
    implements $PassiveObjectMessageCopyWith<$Res> {
  _$PassiveObjectMessageCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? objectId = null,
    Object? eventType = null,
    Object? team = freezed,
    Object? size = freezed,
    Object? position = freezed,
    Object? generatePosition = freezed,
    Object? objectType = freezed,
    Object? acquireBy = freezed,
    Object? removeBy = freezed,
  }) {
    return _then(_value.copyWith(
      objectId: null == objectId
          ? _value.objectId
          : objectId // ignore: cast_nullable_to_non_nullable
              as int,
      eventType: null == eventType
          ? _value.eventType
          : eventType // ignore: cast_nullable_to_non_nullable
              as EventType,
      team: freezed == team
          ? _value.team
          : team // ignore: cast_nullable_to_non_nullable
              as int?,
      size: freezed == size
          ? _value.size
          : size // ignore: cast_nullable_to_non_nullable
              as int?,
      position: freezed == position
          ? _value.position
          : position // ignore: cast_nullable_to_non_nullable
              as int?,
      generatePosition: freezed == generatePosition
          ? _value.generatePosition
          : generatePosition // ignore: cast_nullable_to_non_nullable
              as int?,
      objectType: freezed == objectType
          ? _value.objectType
          : objectType // ignore: cast_nullable_to_non_nullable
              as PassiveObjectType?,
      acquireBy: freezed == acquireBy
          ? _value.acquireBy
          : acquireBy // ignore: cast_nullable_to_non_nullable
              as int?,
      removeBy: freezed == removeBy
          ? _value.removeBy
          : removeBy // ignore: cast_nullable_to_non_nullable
              as RemoveBy?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PassiveObjectMessageImplCopyWith<$Res>
    implements $PassiveObjectMessageCopyWith<$Res> {
  factory _$$PassiveObjectMessageImplCopyWith(_$PassiveObjectMessageImpl value,
          $Res Function(_$PassiveObjectMessageImpl) then) =
      __$$PassiveObjectMessageImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int objectId,
      EventType eventType,
      int? team,
      int? size,
      int? position,
      int? generatePosition,
      PassiveObjectType? objectType,
      int? acquireBy,
      RemoveBy? removeBy});
}

/// @nodoc
class __$$PassiveObjectMessageImplCopyWithImpl<$Res>
    extends _$PassiveObjectMessageCopyWithImpl<$Res, _$PassiveObjectMessageImpl>
    implements _$$PassiveObjectMessageImplCopyWith<$Res> {
  __$$PassiveObjectMessageImplCopyWithImpl(_$PassiveObjectMessageImpl _value,
      $Res Function(_$PassiveObjectMessageImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? objectId = null,
    Object? eventType = null,
    Object? team = freezed,
    Object? size = freezed,
    Object? position = freezed,
    Object? generatePosition = freezed,
    Object? objectType = freezed,
    Object? acquireBy = freezed,
    Object? removeBy = freezed,
  }) {
    return _then(_$PassiveObjectMessageImpl(
      objectId: null == objectId
          ? _value.objectId
          : objectId // ignore: cast_nullable_to_non_nullable
              as int,
      eventType: null == eventType
          ? _value.eventType
          : eventType // ignore: cast_nullable_to_non_nullable
              as EventType,
      team: freezed == team
          ? _value.team
          : team // ignore: cast_nullable_to_non_nullable
              as int?,
      size: freezed == size
          ? _value.size
          : size // ignore: cast_nullable_to_non_nullable
              as int?,
      position: freezed == position
          ? _value.position
          : position // ignore: cast_nullable_to_non_nullable
              as int?,
      generatePosition: freezed == generatePosition
          ? _value.generatePosition
          : generatePosition // ignore: cast_nullable_to_non_nullable
              as int?,
      objectType: freezed == objectType
          ? _value.objectType
          : objectType // ignore: cast_nullable_to_non_nullable
              as PassiveObjectType?,
      acquireBy: freezed == acquireBy
          ? _value.acquireBy
          : acquireBy // ignore: cast_nullable_to_non_nullable
              as int?,
      removeBy: freezed == removeBy
          ? _value.removeBy
          : removeBy // ignore: cast_nullable_to_non_nullable
              as RemoveBy?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PassiveObjectMessageImpl extends _PassiveObjectMessage {
  _$PassiveObjectMessageImpl(
      {required this.objectId,
      required this.eventType,
      this.team,
      this.size,
      this.position,
      this.generatePosition,
      this.objectType,
      this.acquireBy,
      this.removeBy})
      : super._();

  factory _$PassiveObjectMessageImpl.fromJson(Map<String, dynamic> json) =>
      _$$PassiveObjectMessageImplFromJson(json);

  @override
  final int objectId;
  @override
  final EventType eventType;
  @override
  final int? team;
  @override
  final int? size;
  @override
  final int? position;
  @override
  final int? generatePosition;
  @override
  final PassiveObjectType? objectType;
  @override
  final int? acquireBy;
  @override
  final RemoveBy? removeBy;

  @override
  String toString() {
    return 'PassiveObjectMessage(objectId: $objectId, eventType: $eventType, team: $team, size: $size, position: $position, generatePosition: $generatePosition, objectType: $objectType, acquireBy: $acquireBy, removeBy: $removeBy)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PassiveObjectMessageImpl &&
            (identical(other.objectId, objectId) ||
                other.objectId == objectId) &&
            (identical(other.eventType, eventType) ||
                other.eventType == eventType) &&
            (identical(other.team, team) || other.team == team) &&
            (identical(other.size, size) || other.size == size) &&
            (identical(other.position, position) ||
                other.position == position) &&
            (identical(other.generatePosition, generatePosition) ||
                other.generatePosition == generatePosition) &&
            (identical(other.objectType, objectType) ||
                other.objectType == objectType) &&
            (identical(other.acquireBy, acquireBy) ||
                other.acquireBy == acquireBy) &&
            (identical(other.removeBy, removeBy) ||
                other.removeBy == removeBy));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, objectId, eventType, team, size,
      position, generatePosition, objectType, acquireBy, removeBy);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PassiveObjectMessageImplCopyWith<_$PassiveObjectMessageImpl>
      get copyWith =>
          __$$PassiveObjectMessageImplCopyWithImpl<_$PassiveObjectMessageImpl>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PassiveObjectMessageImplToJson(
      this,
    );
  }
}

abstract class _PassiveObjectMessage extends PassiveObjectMessage {
  factory _PassiveObjectMessage(
      {required final int objectId,
      required final EventType eventType,
      final int? team,
      final int? size,
      final int? position,
      final int? generatePosition,
      final PassiveObjectType? objectType,
      final int? acquireBy,
      final RemoveBy? removeBy}) = _$PassiveObjectMessageImpl;
  _PassiveObjectMessage._() : super._();

  factory _PassiveObjectMessage.fromJson(Map<String, dynamic> json) =
      _$PassiveObjectMessageImpl.fromJson;

  @override
  int get objectId;
  @override
  EventType get eventType;
  @override
  int? get team;
  @override
  int? get size;
  @override
  int? get position;
  @override
  int? get generatePosition;
  @override
  PassiveObjectType? get objectType;
  @override
  int? get acquireBy;
  @override
  RemoveBy? get removeBy;
  @override
  @JsonKey(ignore: true)
  _$$PassiveObjectMessageImplCopyWith<_$PassiveObjectMessageImpl>
      get copyWith => throw _privateConstructorUsedError;
}

TileMessage _$TileMessageFromJson(Map<String, dynamic> json) {
  return _TileMessage.fromJson(json);
}

/// @nodoc
mixin _$TileMessage {
  int get address => throw _privateConstructorUsedError;
  EventType get eventType => throw _privateConstructorUsedError;
  int? get status => throw _privateConstructorUsedError;
  int? get occupierId => throw _privateConstructorUsedError;
  RemoveBy? get removeBy => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TileMessageCopyWith<TileMessage> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TileMessageCopyWith<$Res> {
  factory $TileMessageCopyWith(
          TileMessage value, $Res Function(TileMessage) then) =
      _$TileMessageCopyWithImpl<$Res, TileMessage>;
  @useResult
  $Res call(
      {int address,
      EventType eventType,
      int? status,
      int? occupierId,
      RemoveBy? removeBy});
}

/// @nodoc
class _$TileMessageCopyWithImpl<$Res, $Val extends TileMessage>
    implements $TileMessageCopyWith<$Res> {
  _$TileMessageCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? address = null,
    Object? eventType = null,
    Object? status = freezed,
    Object? occupierId = freezed,
    Object? removeBy = freezed,
  }) {
    return _then(_value.copyWith(
      address: null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as int,
      eventType: null == eventType
          ? _value.eventType
          : eventType // ignore: cast_nullable_to_non_nullable
              as EventType,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as int?,
      occupierId: freezed == occupierId
          ? _value.occupierId
          : occupierId // ignore: cast_nullable_to_non_nullable
              as int?,
      removeBy: freezed == removeBy
          ? _value.removeBy
          : removeBy // ignore: cast_nullable_to_non_nullable
              as RemoveBy?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TileMessageImplCopyWith<$Res>
    implements $TileMessageCopyWith<$Res> {
  factory _$$TileMessageImplCopyWith(
          _$TileMessageImpl value, $Res Function(_$TileMessageImpl) then) =
      __$$TileMessageImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int address,
      EventType eventType,
      int? status,
      int? occupierId,
      RemoveBy? removeBy});
}

/// @nodoc
class __$$TileMessageImplCopyWithImpl<$Res>
    extends _$TileMessageCopyWithImpl<$Res, _$TileMessageImpl>
    implements _$$TileMessageImplCopyWith<$Res> {
  __$$TileMessageImplCopyWithImpl(
      _$TileMessageImpl _value, $Res Function(_$TileMessageImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? address = null,
    Object? eventType = null,
    Object? status = freezed,
    Object? occupierId = freezed,
    Object? removeBy = freezed,
  }) {
    return _then(_$TileMessageImpl(
      address: null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as int,
      eventType: null == eventType
          ? _value.eventType
          : eventType // ignore: cast_nullable_to_non_nullable
              as EventType,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as int?,
      occupierId: freezed == occupierId
          ? _value.occupierId
          : occupierId // ignore: cast_nullable_to_non_nullable
              as int?,
      removeBy: freezed == removeBy
          ? _value.removeBy
          : removeBy // ignore: cast_nullable_to_non_nullable
              as RemoveBy?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TileMessageImpl extends _TileMessage {
  _$TileMessageImpl(
      {required this.address,
      required this.eventType,
      this.status,
      this.occupierId,
      this.removeBy})
      : super._();

  factory _$TileMessageImpl.fromJson(Map<String, dynamic> json) =>
      _$$TileMessageImplFromJson(json);

  @override
  final int address;
  @override
  final EventType eventType;
  @override
  final int? status;
  @override
  final int? occupierId;
  @override
  final RemoveBy? removeBy;

  @override
  String toString() {
    return 'TileMessage(address: $address, eventType: $eventType, status: $status, occupierId: $occupierId, removeBy: $removeBy)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TileMessageImpl &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.eventType, eventType) ||
                other.eventType == eventType) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.occupierId, occupierId) ||
                other.occupierId == occupierId) &&
            (identical(other.removeBy, removeBy) ||
                other.removeBy == removeBy));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, address, eventType, status, occupierId, removeBy);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TileMessageImplCopyWith<_$TileMessageImpl> get copyWith =>
      __$$TileMessageImplCopyWithImpl<_$TileMessageImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TileMessageImplToJson(
      this,
    );
  }
}

abstract class _TileMessage extends TileMessage {
  factory _TileMessage(
      {required final int address,
      required final EventType eventType,
      final int? status,
      final int? occupierId,
      final RemoveBy? removeBy}) = _$TileMessageImpl;
  _TileMessage._() : super._();

  factory _TileMessage.fromJson(Map<String, dynamic> json) =
      _$TileMessageImpl.fromJson;

  @override
  int get address;
  @override
  EventType get eventType;
  @override
  int? get status;
  @override
  int? get occupierId;
  @override
  RemoveBy? get removeBy;
  @override
  @JsonKey(ignore: true)
  _$$TileMessageImplCopyWith<_$TileMessageImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
