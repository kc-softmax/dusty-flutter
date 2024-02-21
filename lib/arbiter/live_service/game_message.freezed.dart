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
  List<TowerMessage>? get towers => throw _privateConstructorUsedError;
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
      List<TowerMessage>? towers,
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
    Object? towers = freezed,
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
      towers: freezed == towers
          ? _value.towers
          : towers // ignore: cast_nullable_to_non_nullable
              as List<TowerMessage>?,
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
      List<TowerMessage>? towers,
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
    Object? towers = freezed,
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
      towers: freezed == towers
          ? _value._towers
          : towers // ignore: cast_nullable_to_non_nullable
              as List<TowerMessage>?,
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
      final List<TowerMessage>? towers,
      final List<ActiveObjectMessage>? actives,
      final List<PassiveObjectMessage>? passives,
      final List<TileMessage>? tiles})
      : _dusties = dusties,
        _towers = towers,
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

  final List<TowerMessage>? _towers;
  @override
  List<TowerMessage>? get towers {
    final value = _towers;
    if (value == null) return null;
    if (_towers is EqualUnmodifiableListView) return _towers;
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
    return 'GameMessage(gameConfig: $gameConfig, dusties: $dusties, towers: $towers, actives: $actives, passives: $passives, tiles: $tiles)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GameMessageImpl &&
            (identical(other.gameConfig, gameConfig) ||
                other.gameConfig == gameConfig) &&
            const DeepCollectionEquality().equals(other._dusties, _dusties) &&
            const DeepCollectionEquality().equals(other._towers, _towers) &&
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
      const DeepCollectionEquality().hash(_towers),
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
      final List<TowerMessage>? towers,
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
  List<TowerMessage>? get towers;
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
  int get frameRate => throw _privateConstructorUsedError;
  int get punchingReloadTime => throw _privateConstructorUsedError;
  int get activeSkillReloadTime => throw _privateConstructorUsedError;
  int get specialSkillReloadTime => throw _privateConstructorUsedError;
  int get finishSkillReloadTime => throw _privateConstructorUsedError;
  int get boostSkillReloadTime => throw _privateConstructorUsedError;
  int get shieldSkillReloadTime => throw _privateConstructorUsedError;
  int get raftSkillReloadTime => throw _privateConstructorUsedError;

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
      {int frameRate,
      int punchingReloadTime,
      int activeSkillReloadTime,
      int specialSkillReloadTime,
      int finishSkillReloadTime,
      int boostSkillReloadTime,
      int shieldSkillReloadTime,
      int raftSkillReloadTime});
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
    Object? frameRate = null,
    Object? punchingReloadTime = null,
    Object? activeSkillReloadTime = null,
    Object? specialSkillReloadTime = null,
    Object? finishSkillReloadTime = null,
    Object? boostSkillReloadTime = null,
    Object? shieldSkillReloadTime = null,
    Object? raftSkillReloadTime = null,
  }) {
    return _then(_value.copyWith(
      frameRate: null == frameRate
          ? _value.frameRate
          : frameRate // ignore: cast_nullable_to_non_nullable
              as int,
      punchingReloadTime: null == punchingReloadTime
          ? _value.punchingReloadTime
          : punchingReloadTime // ignore: cast_nullable_to_non_nullable
              as int,
      activeSkillReloadTime: null == activeSkillReloadTime
          ? _value.activeSkillReloadTime
          : activeSkillReloadTime // ignore: cast_nullable_to_non_nullable
              as int,
      specialSkillReloadTime: null == specialSkillReloadTime
          ? _value.specialSkillReloadTime
          : specialSkillReloadTime // ignore: cast_nullable_to_non_nullable
              as int,
      finishSkillReloadTime: null == finishSkillReloadTime
          ? _value.finishSkillReloadTime
          : finishSkillReloadTime // ignore: cast_nullable_to_non_nullable
              as int,
      boostSkillReloadTime: null == boostSkillReloadTime
          ? _value.boostSkillReloadTime
          : boostSkillReloadTime // ignore: cast_nullable_to_non_nullable
              as int,
      shieldSkillReloadTime: null == shieldSkillReloadTime
          ? _value.shieldSkillReloadTime
          : shieldSkillReloadTime // ignore: cast_nullable_to_non_nullable
              as int,
      raftSkillReloadTime: null == raftSkillReloadTime
          ? _value.raftSkillReloadTime
          : raftSkillReloadTime // ignore: cast_nullable_to_non_nullable
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
      {int frameRate,
      int punchingReloadTime,
      int activeSkillReloadTime,
      int specialSkillReloadTime,
      int finishSkillReloadTime,
      int boostSkillReloadTime,
      int shieldSkillReloadTime,
      int raftSkillReloadTime});
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
    Object? frameRate = null,
    Object? punchingReloadTime = null,
    Object? activeSkillReloadTime = null,
    Object? specialSkillReloadTime = null,
    Object? finishSkillReloadTime = null,
    Object? boostSkillReloadTime = null,
    Object? shieldSkillReloadTime = null,
    Object? raftSkillReloadTime = null,
  }) {
    return _then(_$GameConfigImpl(
      frameRate: null == frameRate
          ? _value.frameRate
          : frameRate // ignore: cast_nullable_to_non_nullable
              as int,
      punchingReloadTime: null == punchingReloadTime
          ? _value.punchingReloadTime
          : punchingReloadTime // ignore: cast_nullable_to_non_nullable
              as int,
      activeSkillReloadTime: null == activeSkillReloadTime
          ? _value.activeSkillReloadTime
          : activeSkillReloadTime // ignore: cast_nullable_to_non_nullable
              as int,
      specialSkillReloadTime: null == specialSkillReloadTime
          ? _value.specialSkillReloadTime
          : specialSkillReloadTime // ignore: cast_nullable_to_non_nullable
              as int,
      finishSkillReloadTime: null == finishSkillReloadTime
          ? _value.finishSkillReloadTime
          : finishSkillReloadTime // ignore: cast_nullable_to_non_nullable
              as int,
      boostSkillReloadTime: null == boostSkillReloadTime
          ? _value.boostSkillReloadTime
          : boostSkillReloadTime // ignore: cast_nullable_to_non_nullable
              as int,
      shieldSkillReloadTime: null == shieldSkillReloadTime
          ? _value.shieldSkillReloadTime
          : shieldSkillReloadTime // ignore: cast_nullable_to_non_nullable
              as int,
      raftSkillReloadTime: null == raftSkillReloadTime
          ? _value.raftSkillReloadTime
          : raftSkillReloadTime // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$GameConfigImpl implements _GameConfig {
  const _$GameConfigImpl(
      {required this.frameRate,
      required this.punchingReloadTime,
      required this.activeSkillReloadTime,
      required this.specialSkillReloadTime,
      required this.finishSkillReloadTime,
      required this.boostSkillReloadTime,
      required this.shieldSkillReloadTime,
      required this.raftSkillReloadTime});

  factory _$GameConfigImpl.fromJson(Map<String, dynamic> json) =>
      _$$GameConfigImplFromJson(json);

  @override
  final int frameRate;
  @override
  final int punchingReloadTime;
  @override
  final int activeSkillReloadTime;
  @override
  final int specialSkillReloadTime;
  @override
  final int finishSkillReloadTime;
  @override
  final int boostSkillReloadTime;
  @override
  final int shieldSkillReloadTime;
  @override
  final int raftSkillReloadTime;

  @override
  String toString() {
    return 'GameConfig(frameRate: $frameRate, punchingReloadTime: $punchingReloadTime, activeSkillReloadTime: $activeSkillReloadTime, specialSkillReloadTime: $specialSkillReloadTime, finishSkillReloadTime: $finishSkillReloadTime, boostSkillReloadTime: $boostSkillReloadTime, shieldSkillReloadTime: $shieldSkillReloadTime, raftSkillReloadTime: $raftSkillReloadTime)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GameConfigImpl &&
            (identical(other.frameRate, frameRate) ||
                other.frameRate == frameRate) &&
            (identical(other.punchingReloadTime, punchingReloadTime) ||
                other.punchingReloadTime == punchingReloadTime) &&
            (identical(other.activeSkillReloadTime, activeSkillReloadTime) ||
                other.activeSkillReloadTime == activeSkillReloadTime) &&
            (identical(other.specialSkillReloadTime, specialSkillReloadTime) ||
                other.specialSkillReloadTime == specialSkillReloadTime) &&
            (identical(other.finishSkillReloadTime, finishSkillReloadTime) ||
                other.finishSkillReloadTime == finishSkillReloadTime) &&
            (identical(other.boostSkillReloadTime, boostSkillReloadTime) ||
                other.boostSkillReloadTime == boostSkillReloadTime) &&
            (identical(other.shieldSkillReloadTime, shieldSkillReloadTime) ||
                other.shieldSkillReloadTime == shieldSkillReloadTime) &&
            (identical(other.raftSkillReloadTime, raftSkillReloadTime) ||
                other.raftSkillReloadTime == raftSkillReloadTime));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      frameRate,
      punchingReloadTime,
      activeSkillReloadTime,
      specialSkillReloadTime,
      finishSkillReloadTime,
      boostSkillReloadTime,
      shieldSkillReloadTime,
      raftSkillReloadTime);

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
      {required final int frameRate,
      required final int punchingReloadTime,
      required final int activeSkillReloadTime,
      required final int specialSkillReloadTime,
      required final int finishSkillReloadTime,
      required final int boostSkillReloadTime,
      required final int shieldSkillReloadTime,
      required final int raftSkillReloadTime}) = _$GameConfigImpl;

  factory _GameConfig.fromJson(Map<String, dynamic> json) =
      _$GameConfigImpl.fromJson;

  @override
  int get frameRate;
  @override
  int get punchingReloadTime;
  @override
  int get activeSkillReloadTime;
  @override
  int get specialSkillReloadTime;
  @override
  int get finishSkillReloadTime;
  @override
  int get boostSkillReloadTime;
  @override
  int get shieldSkillReloadTime;
  @override
  int get raftSkillReloadTime;
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
  int? get team => throw _privateConstructorUsedError;
  int? get status => throw _privateConstructorUsedError;
  int? get position => throw _privateConstructorUsedError;
  int? get target => throw _privateConstructorUsedError;
  int? get defence => throw _privateConstructorUsedError;
  int? get deathInfo => throw _privateConstructorUsedError;

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
      int? team,
      int? status,
      int? position,
      int? target,
      int? defence,
      int? deathInfo});
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
    Object? target = freezed,
    Object? defence = freezed,
    Object? deathInfo = freezed,
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
              as int?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as int?,
      position: freezed == position
          ? _value.position
          : position // ignore: cast_nullable_to_non_nullable
              as int?,
      target: freezed == target
          ? _value.target
          : target // ignore: cast_nullable_to_non_nullable
              as int?,
      defence: freezed == defence
          ? _value.defence
          : defence // ignore: cast_nullable_to_non_nullable
              as int?,
      deathInfo: freezed == deathInfo
          ? _value.deathInfo
          : deathInfo // ignore: cast_nullable_to_non_nullable
              as int?,
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
      int? team,
      int? status,
      int? position,
      int? target,
      int? defence,
      int? deathInfo});
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
    Object? target = freezed,
    Object? defence = freezed,
    Object? deathInfo = freezed,
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
              as int?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as int?,
      position: freezed == position
          ? _value.position
          : position // ignore: cast_nullable_to_non_nullable
              as int?,
      target: freezed == target
          ? _value.target
          : target // ignore: cast_nullable_to_non_nullable
              as int?,
      defence: freezed == defence
          ? _value.defence
          : defence // ignore: cast_nullable_to_non_nullable
              as int?,
      deathInfo: freezed == deathInfo
          ? _value.deathInfo
          : deathInfo // ignore: cast_nullable_to_non_nullable
              as int?,
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
      this.target,
      this.defence,
      this.deathInfo})
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
  final int? team;
  @override
  final int? status;
  @override
  final int? position;
  @override
  final int? target;
  @override
  final int? defence;
  @override
  final int? deathInfo;

  @override
  String toString() {
    return 'DustyMessage(dustyId: $dustyId, eventType: $eventType, name: $name, team: $team, status: $status, position: $position, target: $target, defence: $defence, deathInfo: $deathInfo)';
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
            (identical(other.target, target) || other.target == target) &&
            (identical(other.defence, defence) || other.defence == defence) &&
            (identical(other.deathInfo, deathInfo) ||
                other.deathInfo == deathInfo));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, dustyId, eventType, name, team,
      status, position, target, defence, deathInfo);

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
      final int? team,
      final int? status,
      final int? position,
      final int? target,
      final int? defence,
      final int? deathInfo}) = _$DustyMessageImpl;
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
  int? get team;
  @override
  int? get status;
  @override
  int? get position;
  @override
  int? get target;
  @override
  int? get defence;
  @override
  int? get deathInfo;
  @override
  @JsonKey(ignore: true)
  _$$DustyMessageImplCopyWith<_$DustyMessageImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

TowerMessage _$TowerMessageFromJson(Map<String, dynamic> json) {
  return _TowerMessage.fromJson(json);
}

/// @nodoc
mixin _$TowerMessage {
  int get towerId => throw _privateConstructorUsedError;
  EventType get eventType => throw _privateConstructorUsedError;
  int? get team => throw _privateConstructorUsedError;
  int? get shape => throw _privateConstructorUsedError;
  int? get target => throw _privateConstructorUsedError;
  RemoveType? get removeType => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TowerMessageCopyWith<TowerMessage> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TowerMessageCopyWith<$Res> {
  factory $TowerMessageCopyWith(
          TowerMessage value, $Res Function(TowerMessage) then) =
      _$TowerMessageCopyWithImpl<$Res, TowerMessage>;
  @useResult
  $Res call(
      {int towerId,
      EventType eventType,
      int? team,
      int? shape,
      int? target,
      RemoveType? removeType});
}

/// @nodoc
class _$TowerMessageCopyWithImpl<$Res, $Val extends TowerMessage>
    implements $TowerMessageCopyWith<$Res> {
  _$TowerMessageCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? towerId = null,
    Object? eventType = null,
    Object? team = freezed,
    Object? shape = freezed,
    Object? target = freezed,
    Object? removeType = freezed,
  }) {
    return _then(_value.copyWith(
      towerId: null == towerId
          ? _value.towerId
          : towerId // ignore: cast_nullable_to_non_nullable
              as int,
      eventType: null == eventType
          ? _value.eventType
          : eventType // ignore: cast_nullable_to_non_nullable
              as EventType,
      team: freezed == team
          ? _value.team
          : team // ignore: cast_nullable_to_non_nullable
              as int?,
      shape: freezed == shape
          ? _value.shape
          : shape // ignore: cast_nullable_to_non_nullable
              as int?,
      target: freezed == target
          ? _value.target
          : target // ignore: cast_nullable_to_non_nullable
              as int?,
      removeType: freezed == removeType
          ? _value.removeType
          : removeType // ignore: cast_nullable_to_non_nullable
              as RemoveType?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TowerMessageImplCopyWith<$Res>
    implements $TowerMessageCopyWith<$Res> {
  factory _$$TowerMessageImplCopyWith(
          _$TowerMessageImpl value, $Res Function(_$TowerMessageImpl) then) =
      __$$TowerMessageImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int towerId,
      EventType eventType,
      int? team,
      int? shape,
      int? target,
      RemoveType? removeType});
}

/// @nodoc
class __$$TowerMessageImplCopyWithImpl<$Res>
    extends _$TowerMessageCopyWithImpl<$Res, _$TowerMessageImpl>
    implements _$$TowerMessageImplCopyWith<$Res> {
  __$$TowerMessageImplCopyWithImpl(
      _$TowerMessageImpl _value, $Res Function(_$TowerMessageImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? towerId = null,
    Object? eventType = null,
    Object? team = freezed,
    Object? shape = freezed,
    Object? target = freezed,
    Object? removeType = freezed,
  }) {
    return _then(_$TowerMessageImpl(
      towerId: null == towerId
          ? _value.towerId
          : towerId // ignore: cast_nullable_to_non_nullable
              as int,
      eventType: null == eventType
          ? _value.eventType
          : eventType // ignore: cast_nullable_to_non_nullable
              as EventType,
      team: freezed == team
          ? _value.team
          : team // ignore: cast_nullable_to_non_nullable
              as int?,
      shape: freezed == shape
          ? _value.shape
          : shape // ignore: cast_nullable_to_non_nullable
              as int?,
      target: freezed == target
          ? _value.target
          : target // ignore: cast_nullable_to_non_nullable
              as int?,
      removeType: freezed == removeType
          ? _value.removeType
          : removeType // ignore: cast_nullable_to_non_nullable
              as RemoveType?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TowerMessageImpl extends _TowerMessage {
  _$TowerMessageImpl(
      {required this.towerId,
      required this.eventType,
      this.team,
      this.shape,
      this.target,
      this.removeType})
      : super._();

  factory _$TowerMessageImpl.fromJson(Map<String, dynamic> json) =>
      _$$TowerMessageImplFromJson(json);

  @override
  final int towerId;
  @override
  final EventType eventType;
  @override
  final int? team;
  @override
  final int? shape;
  @override
  final int? target;
  @override
  final RemoveType? removeType;

  @override
  String toString() {
    return 'TowerMessage(towerId: $towerId, eventType: $eventType, team: $team, shape: $shape, target: $target, removeType: $removeType)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TowerMessageImpl &&
            (identical(other.towerId, towerId) || other.towerId == towerId) &&
            (identical(other.eventType, eventType) ||
                other.eventType == eventType) &&
            (identical(other.team, team) || other.team == team) &&
            (identical(other.shape, shape) || other.shape == shape) &&
            (identical(other.target, target) || other.target == target) &&
            (identical(other.removeType, removeType) ||
                other.removeType == removeType));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, towerId, eventType, team, shape, target, removeType);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TowerMessageImplCopyWith<_$TowerMessageImpl> get copyWith =>
      __$$TowerMessageImplCopyWithImpl<_$TowerMessageImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TowerMessageImplToJson(
      this,
    );
  }
}

abstract class _TowerMessage extends TowerMessage {
  factory _TowerMessage(
      {required final int towerId,
      required final EventType eventType,
      final int? team,
      final int? shape,
      final int? target,
      final RemoveType? removeType}) = _$TowerMessageImpl;
  _TowerMessage._() : super._();

  factory _TowerMessage.fromJson(Map<String, dynamic> json) =
      _$TowerMessageImpl.fromJson;

  @override
  int get towerId;
  @override
  EventType get eventType;
  @override
  int? get team;
  @override
  int? get shape;
  @override
  int? get target;
  @override
  RemoveType? get removeType;
  @override
  @JsonKey(ignore: true)
  _$$TowerMessageImplCopyWith<_$TowerMessageImpl> get copyWith =>
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
  int? get status => throw _privateConstructorUsedError;
  int? get position => throw _privateConstructorUsedError;
  int? get target => throw _privateConstructorUsedError;
  ActiveObjectType? get objectType => throw _privateConstructorUsedError;
  RemoveType? get removeType => throw _privateConstructorUsedError;

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
      int? status,
      int? position,
      int? target,
      ActiveObjectType? objectType,
      RemoveType? removeType});
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
    Object? status = freezed,
    Object? position = freezed,
    Object? target = freezed,
    Object? objectType = freezed,
    Object? removeType = freezed,
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
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as int?,
      position: freezed == position
          ? _value.position
          : position // ignore: cast_nullable_to_non_nullable
              as int?,
      target: freezed == target
          ? _value.target
          : target // ignore: cast_nullable_to_non_nullable
              as int?,
      objectType: freezed == objectType
          ? _value.objectType
          : objectType // ignore: cast_nullable_to_non_nullable
              as ActiveObjectType?,
      removeType: freezed == removeType
          ? _value.removeType
          : removeType // ignore: cast_nullable_to_non_nullable
              as RemoveType?,
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
      int? status,
      int? position,
      int? target,
      ActiveObjectType? objectType,
      RemoveType? removeType});
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
    Object? status = freezed,
    Object? position = freezed,
    Object? target = freezed,
    Object? objectType = freezed,
    Object? removeType = freezed,
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
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as int?,
      position: freezed == position
          ? _value.position
          : position // ignore: cast_nullable_to_non_nullable
              as int?,
      target: freezed == target
          ? _value.target
          : target // ignore: cast_nullable_to_non_nullable
              as int?,
      objectType: freezed == objectType
          ? _value.objectType
          : objectType // ignore: cast_nullable_to_non_nullable
              as ActiveObjectType?,
      removeType: freezed == removeType
          ? _value.removeType
          : removeType // ignore: cast_nullable_to_non_nullable
              as RemoveType?,
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
      this.status,
      this.position,
      this.target,
      this.objectType,
      this.removeType})
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
  final int? status;
  @override
  final int? position;
  @override
  final int? target;
  @override
  final ActiveObjectType? objectType;
  @override
  final RemoveType? removeType;

  @override
  String toString() {
    return 'ActiveObjectMessage(objectId: $objectId, eventType: $eventType, team: $team, directionX: $directionX, directionY: $directionY, status: $status, position: $position, target: $target, objectType: $objectType, removeType: $removeType)';
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
            (identical(other.status, status) || other.status == status) &&
            (identical(other.position, position) ||
                other.position == position) &&
            (identical(other.target, target) || other.target == target) &&
            (identical(other.objectType, objectType) ||
                other.objectType == objectType) &&
            (identical(other.removeType, removeType) ||
                other.removeType == removeType));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, objectId, eventType, team,
      directionX, directionY, status, position, target, objectType, removeType);

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
      final int? status,
      final int? position,
      final int? target,
      final ActiveObjectType? objectType,
      final RemoveType? removeType}) = _$ActiveObjectMessageImpl;
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
  int? get status;
  @override
  int? get position;
  @override
  int? get target;
  @override
  ActiveObjectType? get objectType;
  @override
  RemoveType? get removeType;
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
  int? get objectType => throw _privateConstructorUsedError;
  int? get removeType => throw _privateConstructorUsedError;

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
      int? objectType,
      int? removeType});
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
    Object? objectType = freezed,
    Object? removeType = freezed,
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
      objectType: freezed == objectType
          ? _value.objectType
          : objectType // ignore: cast_nullable_to_non_nullable
              as int?,
      removeType: freezed == removeType
          ? _value.removeType
          : removeType // ignore: cast_nullable_to_non_nullable
              as int?,
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
      int? objectType,
      int? removeType});
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
    Object? objectType = freezed,
    Object? removeType = freezed,
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
      objectType: freezed == objectType
          ? _value.objectType
          : objectType // ignore: cast_nullable_to_non_nullable
              as int?,
      removeType: freezed == removeType
          ? _value.removeType
          : removeType // ignore: cast_nullable_to_non_nullable
              as int?,
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
      this.objectType,
      this.removeType})
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
  final int? objectType;
  @override
  final int? removeType;

  @override
  String toString() {
    return 'PassiveObjectMessage(objectId: $objectId, eventType: $eventType, team: $team, size: $size, position: $position, objectType: $objectType, removeType: $removeType)';
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
            (identical(other.objectType, objectType) ||
                other.objectType == objectType) &&
            (identical(other.removeType, removeType) ||
                other.removeType == removeType));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, objectId, eventType, team, size,
      position, objectType, removeType);

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
      final int? objectType,
      final int? removeType}) = _$PassiveObjectMessageImpl;
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
  int? get objectType;
  @override
  int? get removeType;
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
  int? get team => throw _privateConstructorUsedError;
  int? get activatorId => throw _privateConstructorUsedError;

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
  $Res call({int address, EventType eventType, int? team, int? activatorId});
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
    Object? team = freezed,
    Object? activatorId = freezed,
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
      team: freezed == team
          ? _value.team
          : team // ignore: cast_nullable_to_non_nullable
              as int?,
      activatorId: freezed == activatorId
          ? _value.activatorId
          : activatorId // ignore: cast_nullable_to_non_nullable
              as int?,
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
  $Res call({int address, EventType eventType, int? team, int? activatorId});
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
    Object? team = freezed,
    Object? activatorId = freezed,
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
      team: freezed == team
          ? _value.team
          : team // ignore: cast_nullable_to_non_nullable
              as int?,
      activatorId: freezed == activatorId
          ? _value.activatorId
          : activatorId // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TileMessageImpl extends _TileMessage {
  _$TileMessageImpl(
      {required this.address,
      required this.eventType,
      this.team,
      this.activatorId})
      : super._();

  factory _$TileMessageImpl.fromJson(Map<String, dynamic> json) =>
      _$$TileMessageImplFromJson(json);

  @override
  final int address;
  @override
  final EventType eventType;
  @override
  final int? team;
  @override
  final int? activatorId;

  @override
  String toString() {
    return 'TileMessage(address: $address, eventType: $eventType, team: $team, activatorId: $activatorId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TileMessageImpl &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.eventType, eventType) ||
                other.eventType == eventType) &&
            (identical(other.team, team) || other.team == team) &&
            (identical(other.activatorId, activatorId) ||
                other.activatorId == activatorId));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, address, eventType, team, activatorId);

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
      final int? team,
      final int? activatorId}) = _$TileMessageImpl;
  _TileMessage._() : super._();

  factory _TileMessage.fromJson(Map<String, dynamic> json) =
      _$TileMessageImpl.fromJson;

  @override
  int get address;
  @override
  EventType get eventType;
  @override
  int? get team;
  @override
  int? get activatorId;
  @override
  @JsonKey(ignore: true)
  _$$TileMessageImplCopyWith<_$TileMessageImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
