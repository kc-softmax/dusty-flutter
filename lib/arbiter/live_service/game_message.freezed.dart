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
  bool get prepare => throw _privateConstructorUsedError;
  GameConfig get gameConfig => throw _privateConstructorUsedError;
  List<DustyMessage> get dusties => throw _privateConstructorUsedError;
  List<ActiveObjectMessage> get activeObjects =>
      throw _privateConstructorUsedError;
  List<PassiveObjectMessage> get passiveObjects =>
      throw _privateConstructorUsedError;
  List<TileMessage> get tiles => throw _privateConstructorUsedError;

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
      {bool prepare,
      GameConfig gameConfig,
      List<DustyMessage> dusties,
      List<ActiveObjectMessage> activeObjects,
      List<PassiveObjectMessage> passiveObjects,
      List<TileMessage> tiles});

  $GameConfigCopyWith<$Res> get gameConfig;
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
    Object? prepare = null,
    Object? gameConfig = null,
    Object? dusties = null,
    Object? activeObjects = null,
    Object? passiveObjects = null,
    Object? tiles = null,
  }) {
    return _then(_value.copyWith(
      prepare: null == prepare
          ? _value.prepare
          : prepare // ignore: cast_nullable_to_non_nullable
              as bool,
      gameConfig: null == gameConfig
          ? _value.gameConfig
          : gameConfig // ignore: cast_nullable_to_non_nullable
              as GameConfig,
      dusties: null == dusties
          ? _value.dusties
          : dusties // ignore: cast_nullable_to_non_nullable
              as List<DustyMessage>,
      activeObjects: null == activeObjects
          ? _value.activeObjects
          : activeObjects // ignore: cast_nullable_to_non_nullable
              as List<ActiveObjectMessage>,
      passiveObjects: null == passiveObjects
          ? _value.passiveObjects
          : passiveObjects // ignore: cast_nullable_to_non_nullable
              as List<PassiveObjectMessage>,
      tiles: null == tiles
          ? _value.tiles
          : tiles // ignore: cast_nullable_to_non_nullable
              as List<TileMessage>,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $GameConfigCopyWith<$Res> get gameConfig {
    return $GameConfigCopyWith<$Res>(_value.gameConfig, (value) {
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
      {bool prepare,
      GameConfig gameConfig,
      List<DustyMessage> dusties,
      List<ActiveObjectMessage> activeObjects,
      List<PassiveObjectMessage> passiveObjects,
      List<TileMessage> tiles});

  @override
  $GameConfigCopyWith<$Res> get gameConfig;
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
    Object? prepare = null,
    Object? gameConfig = null,
    Object? dusties = null,
    Object? activeObjects = null,
    Object? passiveObjects = null,
    Object? tiles = null,
  }) {
    return _then(_$GameMessageImpl(
      prepare: null == prepare
          ? _value.prepare
          : prepare // ignore: cast_nullable_to_non_nullable
              as bool,
      gameConfig: null == gameConfig
          ? _value.gameConfig
          : gameConfig // ignore: cast_nullable_to_non_nullable
              as GameConfig,
      dusties: null == dusties
          ? _value._dusties
          : dusties // ignore: cast_nullable_to_non_nullable
              as List<DustyMessage>,
      activeObjects: null == activeObjects
          ? _value._activeObjects
          : activeObjects // ignore: cast_nullable_to_non_nullable
              as List<ActiveObjectMessage>,
      passiveObjects: null == passiveObjects
          ? _value._passiveObjects
          : passiveObjects // ignore: cast_nullable_to_non_nullable
              as List<PassiveObjectMessage>,
      tiles: null == tiles
          ? _value._tiles
          : tiles // ignore: cast_nullable_to_non_nullable
              as List<TileMessage>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$GameMessageImpl implements _GameMessage {
  const _$GameMessageImpl(
      {required this.prepare,
      required this.gameConfig,
      required final List<DustyMessage> dusties,
      required final List<ActiveObjectMessage> activeObjects,
      required final List<PassiveObjectMessage> passiveObjects,
      required final List<TileMessage> tiles})
      : _dusties = dusties,
        _activeObjects = activeObjects,
        _passiveObjects = passiveObjects,
        _tiles = tiles;

  factory _$GameMessageImpl.fromJson(Map<String, dynamic> json) =>
      _$$GameMessageImplFromJson(json);

  @override
  final bool prepare;
  @override
  final GameConfig gameConfig;
  final List<DustyMessage> _dusties;
  @override
  List<DustyMessage> get dusties {
    if (_dusties is EqualUnmodifiableListView) return _dusties;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_dusties);
  }

  final List<ActiveObjectMessage> _activeObjects;
  @override
  List<ActiveObjectMessage> get activeObjects {
    if (_activeObjects is EqualUnmodifiableListView) return _activeObjects;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_activeObjects);
  }

  final List<PassiveObjectMessage> _passiveObjects;
  @override
  List<PassiveObjectMessage> get passiveObjects {
    if (_passiveObjects is EqualUnmodifiableListView) return _passiveObjects;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_passiveObjects);
  }

  final List<TileMessage> _tiles;
  @override
  List<TileMessage> get tiles {
    if (_tiles is EqualUnmodifiableListView) return _tiles;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tiles);
  }

  @override
  String toString() {
    return 'GameMessage(prepare: $prepare, gameConfig: $gameConfig, dusties: $dusties, activeObjects: $activeObjects, passiveObjects: $passiveObjects, tiles: $tiles)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GameMessageImpl &&
            (identical(other.prepare, prepare) || other.prepare == prepare) &&
            (identical(other.gameConfig, gameConfig) ||
                other.gameConfig == gameConfig) &&
            const DeepCollectionEquality().equals(other._dusties, _dusties) &&
            const DeepCollectionEquality()
                .equals(other._activeObjects, _activeObjects) &&
            const DeepCollectionEquality()
                .equals(other._passiveObjects, _passiveObjects) &&
            const DeepCollectionEquality().equals(other._tiles, _tiles));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      prepare,
      gameConfig,
      const DeepCollectionEquality().hash(_dusties),
      const DeepCollectionEquality().hash(_activeObjects),
      const DeepCollectionEquality().hash(_passiveObjects),
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
      {required final bool prepare,
      required final GameConfig gameConfig,
      required final List<DustyMessage> dusties,
      required final List<ActiveObjectMessage> activeObjects,
      required final List<PassiveObjectMessage> passiveObjects,
      required final List<TileMessage> tiles}) = _$GameMessageImpl;

  factory _GameMessage.fromJson(Map<String, dynamic> json) =
      _$GameMessageImpl.fromJson;

  @override
  bool get prepare;
  @override
  GameConfig get gameConfig;
  @override
  List<DustyMessage> get dusties;
  @override
  List<ActiveObjectMessage> get activeObjects;
  @override
  List<PassiveObjectMessage> get passiveObjects;
  @override
  List<TileMessage> get tiles;
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
  int get id => throw _privateConstructorUsedError;

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
  $Res call({int id});
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
    Object? id = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
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
  $Res call({int id});
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
    Object? id = null,
  }) {
    return _then(_$DustyMessageImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DustyMessageImpl implements _DustyMessage {
  const _$DustyMessageImpl({required this.id});

  factory _$DustyMessageImpl.fromJson(Map<String, dynamic> json) =>
      _$$DustyMessageImplFromJson(json);

  @override
  final int id;

  @override
  String toString() {
    return 'DustyMessage(id: $id)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DustyMessageImpl &&
            (identical(other.id, id) || other.id == id));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id);

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

abstract class _DustyMessage implements DustyMessage {
  const factory _DustyMessage({required final int id}) = _$DustyMessageImpl;

  factory _DustyMessage.fromJson(Map<String, dynamic> json) =
      _$DustyMessageImpl.fromJson;

  @override
  int get id;
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
  int get id => throw _privateConstructorUsedError;

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
  $Res call({int id});
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
    Object? id = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
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
  $Res call({int id});
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
    Object? id = null,
  }) {
    return _then(_$TowerMessageImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TowerMessageImpl implements _TowerMessage {
  const _$TowerMessageImpl({required this.id});

  factory _$TowerMessageImpl.fromJson(Map<String, dynamic> json) =>
      _$$TowerMessageImplFromJson(json);

  @override
  final int id;

  @override
  String toString() {
    return 'TowerMessage(id: $id)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TowerMessageImpl &&
            (identical(other.id, id) || other.id == id));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id);

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

abstract class _TowerMessage implements TowerMessage {
  const factory _TowerMessage({required final int id}) = _$TowerMessageImpl;

  factory _TowerMessage.fromJson(Map<String, dynamic> json) =
      _$TowerMessageImpl.fromJson;

  @override
  int get id;
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
  int get id => throw _privateConstructorUsedError;

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
  $Res call({int id});
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
    Object? id = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
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
  $Res call({int id});
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
    Object? id = null,
  }) {
    return _then(_$ActiveObjectMessageImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ActiveObjectMessageImpl implements _ActiveObjectMessage {
  const _$ActiveObjectMessageImpl({required this.id});

  factory _$ActiveObjectMessageImpl.fromJson(Map<String, dynamic> json) =>
      _$$ActiveObjectMessageImplFromJson(json);

  @override
  final int id;

  @override
  String toString() {
    return 'ActiveObjectMessage(id: $id)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ActiveObjectMessageImpl &&
            (identical(other.id, id) || other.id == id));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id);

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

abstract class _ActiveObjectMessage implements ActiveObjectMessage {
  const factory _ActiveObjectMessage({required final int id}) =
      _$ActiveObjectMessageImpl;

  factory _ActiveObjectMessage.fromJson(Map<String, dynamic> json) =
      _$ActiveObjectMessageImpl.fromJson;

  @override
  int get id;
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
  int get id => throw _privateConstructorUsedError;

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
  $Res call({int id});
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
    Object? id = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
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
  $Res call({int id});
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
    Object? id = null,
  }) {
    return _then(_$PassiveObjectMessageImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PassiveObjectMessageImpl implements _PassiveObjectMessage {
  const _$PassiveObjectMessageImpl({required this.id});

  factory _$PassiveObjectMessageImpl.fromJson(Map<String, dynamic> json) =>
      _$$PassiveObjectMessageImplFromJson(json);

  @override
  final int id;

  @override
  String toString() {
    return 'PassiveObjectMessage(id: $id)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PassiveObjectMessageImpl &&
            (identical(other.id, id) || other.id == id));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id);

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

abstract class _PassiveObjectMessage implements PassiveObjectMessage {
  const factory _PassiveObjectMessage({required final int id}) =
      _$PassiveObjectMessageImpl;

  factory _PassiveObjectMessage.fromJson(Map<String, dynamic> json) =
      _$PassiveObjectMessageImpl.fromJson;

  @override
  int get id;
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
  $Res call({int address});
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
  }) {
    return _then(_value.copyWith(
      address: null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as int,
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
  $Res call({int address});
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
  }) {
    return _then(_$TileMessageImpl(
      address: null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TileMessageImpl implements _TileMessage {
  const _$TileMessageImpl({required this.address});

  factory _$TileMessageImpl.fromJson(Map<String, dynamic> json) =>
      _$$TileMessageImplFromJson(json);

  @override
  final int address;

  @override
  String toString() {
    return 'TileMessage(address: $address)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TileMessageImpl &&
            (identical(other.address, address) || other.address == address));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, address);

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

abstract class _TileMessage implements TileMessage {
  const factory _TileMessage({required final int address}) = _$TileMessageImpl;

  factory _TileMessage.fromJson(Map<String, dynamic> json) =
      _$TileMessageImpl.fromJson;

  @override
  int get address;
  @override
  @JsonKey(ignore: true)
  _$$TileMessageImplCopyWith<_$TileMessageImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
