// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'game_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

StateData _$StateDataFromJson(Map<String, dynamic> json) {
  return _StateData.fromJson(json);
}

/// @nodoc
mixin _$StateData {
  ObjectState? get state => throw _privateConstructorUsedError;
  int? get target => throw _privateConstructorUsedError;
  dynamic get value => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $StateDataCopyWith<StateData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StateDataCopyWith<$Res> {
  factory $StateDataCopyWith(StateData value, $Res Function(StateData) then) =
      _$StateDataCopyWithImpl<$Res, StateData>;
  @useResult
  $Res call({ObjectState? state, int? target, dynamic value});
}

/// @nodoc
class _$StateDataCopyWithImpl<$Res, $Val extends StateData>
    implements $StateDataCopyWith<$Res> {
  _$StateDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? state = freezed,
    Object? target = freezed,
    Object? value = freezed,
  }) {
    return _then(_value.copyWith(
      state: freezed == state
          ? _value.state
          : state // ignore: cast_nullable_to_non_nullable
              as ObjectState?,
      target: freezed == target
          ? _value.target
          : target // ignore: cast_nullable_to_non_nullable
              as int?,
      value: freezed == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$StateDataImplCopyWith<$Res>
    implements $StateDataCopyWith<$Res> {
  factory _$$StateDataImplCopyWith(
          _$StateDataImpl value, $Res Function(_$StateDataImpl) then) =
      __$$StateDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({ObjectState? state, int? target, dynamic value});
}

/// @nodoc
class __$$StateDataImplCopyWithImpl<$Res>
    extends _$StateDataCopyWithImpl<$Res, _$StateDataImpl>
    implements _$$StateDataImplCopyWith<$Res> {
  __$$StateDataImplCopyWithImpl(
      _$StateDataImpl _value, $Res Function(_$StateDataImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? state = freezed,
    Object? target = freezed,
    Object? value = freezed,
  }) {
    return _then(_$StateDataImpl(
      state: freezed == state
          ? _value.state
          : state // ignore: cast_nullable_to_non_nullable
              as ObjectState?,
      target: freezed == target
          ? _value.target
          : target // ignore: cast_nullable_to_non_nullable
              as int?,
      value: freezed == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$StateDataImpl implements _StateData {
  const _$StateDataImpl({this.state, this.target, this.value});

  factory _$StateDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$StateDataImplFromJson(json);

  @override
  final ObjectState? state;
  @override
  final int? target;
  @override
  final dynamic value;

  @override
  String toString() {
    return 'StateData(state: $state, target: $target, value: $value)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StateDataImpl &&
            (identical(other.state, state) || other.state == state) &&
            (identical(other.target, target) || other.target == target) &&
            const DeepCollectionEquality().equals(other.value, value));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, state, target, const DeepCollectionEquality().hash(value));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$StateDataImplCopyWith<_$StateDataImpl> get copyWith =>
      __$$StateDataImplCopyWithImpl<_$StateDataImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$StateDataImplToJson(
      this,
    );
  }
}

abstract class _StateData implements StateData {
  const factory _StateData(
      {final ObjectState? state,
      final int? target,
      final dynamic value}) = _$StateDataImpl;

  factory _StateData.fromJson(Map<String, dynamic> json) =
      _$StateDataImpl.fromJson;

  @override
  ObjectState? get state;
  @override
  int? get target;
  @override
  dynamic get value;
  @override
  @JsonKey(ignore: true)
  _$$StateDataImplCopyWith<_$StateDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

GameEvent _$GameEventFromJson(Map<String, dynamic> json) {
  return _GameEvent.fromJson(json);
}

/// @nodoc
mixin _$GameEvent {
  List<DustyEvent>? get dusties => throw _privateConstructorUsedError;
  List<ActiveObjectEvent>? get activeObjects =>
      throw _privateConstructorUsedError;
  List<PassiveObjectEvent>? get passiveObjects =>
      throw _privateConstructorUsedError;
  SystemEvent? get systemEvent => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $GameEventCopyWith<GameEvent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GameEventCopyWith<$Res> {
  factory $GameEventCopyWith(GameEvent value, $Res Function(GameEvent) then) =
      _$GameEventCopyWithImpl<$Res, GameEvent>;
  @useResult
  $Res call(
      {List<DustyEvent>? dusties,
      List<ActiveObjectEvent>? activeObjects,
      List<PassiveObjectEvent>? passiveObjects,
      SystemEvent? systemEvent});

  $SystemEventCopyWith<$Res>? get systemEvent;
}

/// @nodoc
class _$GameEventCopyWithImpl<$Res, $Val extends GameEvent>
    implements $GameEventCopyWith<$Res> {
  _$GameEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? dusties = freezed,
    Object? activeObjects = freezed,
    Object? passiveObjects = freezed,
    Object? systemEvent = freezed,
  }) {
    return _then(_value.copyWith(
      dusties: freezed == dusties
          ? _value.dusties
          : dusties // ignore: cast_nullable_to_non_nullable
              as List<DustyEvent>?,
      activeObjects: freezed == activeObjects
          ? _value.activeObjects
          : activeObjects // ignore: cast_nullable_to_non_nullable
              as List<ActiveObjectEvent>?,
      passiveObjects: freezed == passiveObjects
          ? _value.passiveObjects
          : passiveObjects // ignore: cast_nullable_to_non_nullable
              as List<PassiveObjectEvent>?,
      systemEvent: freezed == systemEvent
          ? _value.systemEvent
          : systemEvent // ignore: cast_nullable_to_non_nullable
              as SystemEvent?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $SystemEventCopyWith<$Res>? get systemEvent {
    if (_value.systemEvent == null) {
      return null;
    }

    return $SystemEventCopyWith<$Res>(_value.systemEvent!, (value) {
      return _then(_value.copyWith(systemEvent: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$GameEventImplCopyWith<$Res>
    implements $GameEventCopyWith<$Res> {
  factory _$$GameEventImplCopyWith(
          _$GameEventImpl value, $Res Function(_$GameEventImpl) then) =
      __$$GameEventImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<DustyEvent>? dusties,
      List<ActiveObjectEvent>? activeObjects,
      List<PassiveObjectEvent>? passiveObjects,
      SystemEvent? systemEvent});

  @override
  $SystemEventCopyWith<$Res>? get systemEvent;
}

/// @nodoc
class __$$GameEventImplCopyWithImpl<$Res>
    extends _$GameEventCopyWithImpl<$Res, _$GameEventImpl>
    implements _$$GameEventImplCopyWith<$Res> {
  __$$GameEventImplCopyWithImpl(
      _$GameEventImpl _value, $Res Function(_$GameEventImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? dusties = freezed,
    Object? activeObjects = freezed,
    Object? passiveObjects = freezed,
    Object? systemEvent = freezed,
  }) {
    return _then(_$GameEventImpl(
      dusties: freezed == dusties
          ? _value._dusties
          : dusties // ignore: cast_nullable_to_non_nullable
              as List<DustyEvent>?,
      activeObjects: freezed == activeObjects
          ? _value._activeObjects
          : activeObjects // ignore: cast_nullable_to_non_nullable
              as List<ActiveObjectEvent>?,
      passiveObjects: freezed == passiveObjects
          ? _value._passiveObjects
          : passiveObjects // ignore: cast_nullable_to_non_nullable
              as List<PassiveObjectEvent>?,
      systemEvent: freezed == systemEvent
          ? _value.systemEvent
          : systemEvent // ignore: cast_nullable_to_non_nullable
              as SystemEvent?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$GameEventImpl implements _GameEvent {
  const _$GameEventImpl(
      {final List<DustyEvent>? dusties,
      final List<ActiveObjectEvent>? activeObjects,
      final List<PassiveObjectEvent>? passiveObjects,
      this.systemEvent})
      : _dusties = dusties,
        _activeObjects = activeObjects,
        _passiveObjects = passiveObjects;

  factory _$GameEventImpl.fromJson(Map<String, dynamic> json) =>
      _$$GameEventImplFromJson(json);

  final List<DustyEvent>? _dusties;
  @override
  List<DustyEvent>? get dusties {
    final value = _dusties;
    if (value == null) return null;
    if (_dusties is EqualUnmodifiableListView) return _dusties;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<ActiveObjectEvent>? _activeObjects;
  @override
  List<ActiveObjectEvent>? get activeObjects {
    final value = _activeObjects;
    if (value == null) return null;
    if (_activeObjects is EqualUnmodifiableListView) return _activeObjects;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<PassiveObjectEvent>? _passiveObjects;
  @override
  List<PassiveObjectEvent>? get passiveObjects {
    final value = _passiveObjects;
    if (value == null) return null;
    if (_passiveObjects is EqualUnmodifiableListView) return _passiveObjects;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final SystemEvent? systemEvent;

  @override
  String toString() {
    return 'GameEvent(dusties: $dusties, activeObjects: $activeObjects, passiveObjects: $passiveObjects, systemEvent: $systemEvent)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GameEventImpl &&
            const DeepCollectionEquality().equals(other._dusties, _dusties) &&
            const DeepCollectionEquality()
                .equals(other._activeObjects, _activeObjects) &&
            const DeepCollectionEquality()
                .equals(other._passiveObjects, _passiveObjects) &&
            (identical(other.systemEvent, systemEvent) ||
                other.systemEvent == systemEvent));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_dusties),
      const DeepCollectionEquality().hash(_activeObjects),
      const DeepCollectionEquality().hash(_passiveObjects),
      systemEvent);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$GameEventImplCopyWith<_$GameEventImpl> get copyWith =>
      __$$GameEventImplCopyWithImpl<_$GameEventImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GameEventImplToJson(
      this,
    );
  }
}

abstract class _GameEvent implements GameEvent {
  const factory _GameEvent(
      {final List<DustyEvent>? dusties,
      final List<ActiveObjectEvent>? activeObjects,
      final List<PassiveObjectEvent>? passiveObjects,
      final SystemEvent? systemEvent}) = _$GameEventImpl;

  factory _GameEvent.fromJson(Map<String, dynamic> json) =
      _$GameEventImpl.fromJson;

  @override
  List<DustyEvent>? get dusties;
  @override
  List<ActiveObjectEvent>? get activeObjects;
  @override
  List<PassiveObjectEvent>? get passiveObjects;
  @override
  SystemEvent? get systemEvent;
  @override
  @JsonKey(ignore: true)
  _$$GameEventImplCopyWith<_$GameEventImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

SystemEvent _$SystemEventFromJson(Map<String, dynamic> json) {
  return _SystemEvent.fromJson(json);
}

/// @nodoc
mixin _$SystemEvent {
  int? get followId => throw _privateConstructorUsedError;
  int? get remainTime => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SystemEventCopyWith<SystemEvent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SystemEventCopyWith<$Res> {
  factory $SystemEventCopyWith(
          SystemEvent value, $Res Function(SystemEvent) then) =
      _$SystemEventCopyWithImpl<$Res, SystemEvent>;
  @useResult
  $Res call({int? followId, int? remainTime});
}

/// @nodoc
class _$SystemEventCopyWithImpl<$Res, $Val extends SystemEvent>
    implements $SystemEventCopyWith<$Res> {
  _$SystemEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? followId = freezed,
    Object? remainTime = freezed,
  }) {
    return _then(_value.copyWith(
      followId: freezed == followId
          ? _value.followId
          : followId // ignore: cast_nullable_to_non_nullable
              as int?,
      remainTime: freezed == remainTime
          ? _value.remainTime
          : remainTime // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SystemEventImplCopyWith<$Res>
    implements $SystemEventCopyWith<$Res> {
  factory _$$SystemEventImplCopyWith(
          _$SystemEventImpl value, $Res Function(_$SystemEventImpl) then) =
      __$$SystemEventImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int? followId, int? remainTime});
}

/// @nodoc
class __$$SystemEventImplCopyWithImpl<$Res>
    extends _$SystemEventCopyWithImpl<$Res, _$SystemEventImpl>
    implements _$$SystemEventImplCopyWith<$Res> {
  __$$SystemEventImplCopyWithImpl(
      _$SystemEventImpl _value, $Res Function(_$SystemEventImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? followId = freezed,
    Object? remainTime = freezed,
  }) {
    return _then(_$SystemEventImpl(
      followId: freezed == followId
          ? _value.followId
          : followId // ignore: cast_nullable_to_non_nullable
              as int?,
      remainTime: freezed == remainTime
          ? _value.remainTime
          : remainTime // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SystemEventImpl implements _SystemEvent {
  const _$SystemEventImpl({this.followId, this.remainTime});

  factory _$SystemEventImpl.fromJson(Map<String, dynamic> json) =>
      _$$SystemEventImplFromJson(json);

  @override
  final int? followId;
  @override
  final int? remainTime;

  @override
  String toString() {
    return 'SystemEvent(followId: $followId, remainTime: $remainTime)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SystemEventImpl &&
            (identical(other.followId, followId) ||
                other.followId == followId) &&
            (identical(other.remainTime, remainTime) ||
                other.remainTime == remainTime));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, followId, remainTime);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SystemEventImplCopyWith<_$SystemEventImpl> get copyWith =>
      __$$SystemEventImplCopyWithImpl<_$SystemEventImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SystemEventImplToJson(
      this,
    );
  }
}

abstract class _SystemEvent implements SystemEvent {
  const factory _SystemEvent({final int? followId, final int? remainTime}) =
      _$SystemEventImpl;

  factory _SystemEvent.fromJson(Map<String, dynamic> json) =
      _$SystemEventImpl.fromJson;

  @override
  int? get followId;
  @override
  int? get remainTime;
  @override
  @JsonKey(ignore: true)
  _$$SystemEventImplCopyWith<_$SystemEventImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

DustyEvent _$DustyEventFromJson(Map<String, dynamic> json) {
  return _DustyEvent.fromJson(json);
}

/// @nodoc
mixin _$DustyEvent {
  int get objectId => throw _privateConstructorUsedError;
  EventType get eventType => throw _privateConstructorUsedError;
  List<StateData>? get states => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;
  bool? get isPlayer => throw _privateConstructorUsedError;
  Team? get team => throw _privateConstructorUsedError;
  int? get status => throw _privateConstructorUsedError;
  int? get position => throw _privateConstructorUsedError;
  int? get targetId => throw _privateConstructorUsedError;
  int? get killerId => throw _privateConstructorUsedError;
  int? get quantity => throw _privateConstructorUsedError;
  int? get defence => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DustyEventCopyWith<DustyEvent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DustyEventCopyWith<$Res> {
  factory $DustyEventCopyWith(
          DustyEvent value, $Res Function(DustyEvent) then) =
      _$DustyEventCopyWithImpl<$Res, DustyEvent>;
  @useResult
  $Res call(
      {int objectId,
      EventType eventType,
      List<StateData>? states,
      String? name,
      bool? isPlayer,
      Team? team,
      int? status,
      int? position,
      int? targetId,
      int? killerId,
      int? quantity,
      int? defence});
}

/// @nodoc
class _$DustyEventCopyWithImpl<$Res, $Val extends DustyEvent>
    implements $DustyEventCopyWith<$Res> {
  _$DustyEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? objectId = null,
    Object? eventType = null,
    Object? states = freezed,
    Object? name = freezed,
    Object? isPlayer = freezed,
    Object? team = freezed,
    Object? status = freezed,
    Object? position = freezed,
    Object? targetId = freezed,
    Object? killerId = freezed,
    Object? quantity = freezed,
    Object? defence = freezed,
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
      states: freezed == states
          ? _value.states
          : states // ignore: cast_nullable_to_non_nullable
              as List<StateData>?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      isPlayer: freezed == isPlayer
          ? _value.isPlayer
          : isPlayer // ignore: cast_nullable_to_non_nullable
              as bool?,
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
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DustyEventImplCopyWith<$Res>
    implements $DustyEventCopyWith<$Res> {
  factory _$$DustyEventImplCopyWith(
          _$DustyEventImpl value, $Res Function(_$DustyEventImpl) then) =
      __$$DustyEventImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int objectId,
      EventType eventType,
      List<StateData>? states,
      String? name,
      bool? isPlayer,
      Team? team,
      int? status,
      int? position,
      int? targetId,
      int? killerId,
      int? quantity,
      int? defence});
}

/// @nodoc
class __$$DustyEventImplCopyWithImpl<$Res>
    extends _$DustyEventCopyWithImpl<$Res, _$DustyEventImpl>
    implements _$$DustyEventImplCopyWith<$Res> {
  __$$DustyEventImplCopyWithImpl(
      _$DustyEventImpl _value, $Res Function(_$DustyEventImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? objectId = null,
    Object? eventType = null,
    Object? states = freezed,
    Object? name = freezed,
    Object? isPlayer = freezed,
    Object? team = freezed,
    Object? status = freezed,
    Object? position = freezed,
    Object? targetId = freezed,
    Object? killerId = freezed,
    Object? quantity = freezed,
    Object? defence = freezed,
  }) {
    return _then(_$DustyEventImpl(
      objectId: null == objectId
          ? _value.objectId
          : objectId // ignore: cast_nullable_to_non_nullable
              as int,
      eventType: null == eventType
          ? _value.eventType
          : eventType // ignore: cast_nullable_to_non_nullable
              as EventType,
      states: freezed == states
          ? _value._states
          : states // ignore: cast_nullable_to_non_nullable
              as List<StateData>?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      isPlayer: freezed == isPlayer
          ? _value.isPlayer
          : isPlayer // ignore: cast_nullable_to_non_nullable
              as bool?,
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
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DustyEventImpl extends _DustyEvent {
  _$DustyEventImpl(
      {required this.objectId,
      required this.eventType,
      final List<StateData>? states,
      this.name,
      this.isPlayer,
      this.team,
      this.status,
      this.position,
      this.targetId,
      this.killerId,
      this.quantity,
      this.defence})
      : _states = states,
        super._();

  factory _$DustyEventImpl.fromJson(Map<String, dynamic> json) =>
      _$$DustyEventImplFromJson(json);

  @override
  final int objectId;
  @override
  final EventType eventType;
  final List<StateData>? _states;
  @override
  List<StateData>? get states {
    final value = _states;
    if (value == null) return null;
    if (_states is EqualUnmodifiableListView) return _states;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final String? name;
  @override
  final bool? isPlayer;
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
  String toString() {
    return 'DustyEvent(objectId: $objectId, eventType: $eventType, states: $states, name: $name, isPlayer: $isPlayer, team: $team, status: $status, position: $position, targetId: $targetId, killerId: $killerId, quantity: $quantity, defence: $defence)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DustyEventImpl &&
            (identical(other.objectId, objectId) ||
                other.objectId == objectId) &&
            (identical(other.eventType, eventType) ||
                other.eventType == eventType) &&
            const DeepCollectionEquality().equals(other._states, _states) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.isPlayer, isPlayer) ||
                other.isPlayer == isPlayer) &&
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
            (identical(other.defence, defence) || other.defence == defence));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      objectId,
      eventType,
      const DeepCollectionEquality().hash(_states),
      name,
      isPlayer,
      team,
      status,
      position,
      targetId,
      killerId,
      quantity,
      defence);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DustyEventImplCopyWith<_$DustyEventImpl> get copyWith =>
      __$$DustyEventImplCopyWithImpl<_$DustyEventImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DustyEventImplToJson(
      this,
    );
  }
}

abstract class _DustyEvent extends DustyEvent {
  factory _DustyEvent(
      {required final int objectId,
      required final EventType eventType,
      final List<StateData>? states,
      final String? name,
      final bool? isPlayer,
      final Team? team,
      final int? status,
      final int? position,
      final int? targetId,
      final int? killerId,
      final int? quantity,
      final int? defence}) = _$DustyEventImpl;
  _DustyEvent._() : super._();

  factory _DustyEvent.fromJson(Map<String, dynamic> json) =
      _$DustyEventImpl.fromJson;

  @override
  int get objectId;
  @override
  EventType get eventType;
  @override
  List<StateData>? get states;
  @override
  String? get name;
  @override
  bool? get isPlayer;
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
  @JsonKey(ignore: true)
  _$$DustyEventImplCopyWith<_$DustyEventImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ActiveObjectEvent _$ActiveObjectEventFromJson(Map<String, dynamic> json) {
  return _ActiveObjectEvent.fromJson(json);
}

/// @nodoc
mixin _$ActiveObjectEvent {
  int get objectId => throw _privateConstructorUsedError;
  EventType get eventType => throw _privateConstructorUsedError;
  List<StateData>? get states => throw _privateConstructorUsedError;
  int? get angle => throw _privateConstructorUsedError;
  int? get nextPosition => throw _privateConstructorUsedError;
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

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ActiveObjectEventCopyWith<ActiveObjectEvent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ActiveObjectEventCopyWith<$Res> {
  factory $ActiveObjectEventCopyWith(
          ActiveObjectEvent value, $Res Function(ActiveObjectEvent) then) =
      _$ActiveObjectEventCopyWithImpl<$Res, ActiveObjectEvent>;
  @useResult
  $Res call(
      {int objectId,
      EventType eventType,
      List<StateData>? states,
      int? angle,
      int? nextPosition,
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
      ActiveObjectType? objectType});
}

/// @nodoc
class _$ActiveObjectEventCopyWithImpl<$Res, $Val extends ActiveObjectEvent>
    implements $ActiveObjectEventCopyWith<$Res> {
  _$ActiveObjectEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? objectId = null,
    Object? eventType = null,
    Object? states = freezed,
    Object? angle = freezed,
    Object? nextPosition = freezed,
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
      states: freezed == states
          ? _value.states
          : states // ignore: cast_nullable_to_non_nullable
              as List<StateData>?,
      angle: freezed == angle
          ? _value.angle
          : angle // ignore: cast_nullable_to_non_nullable
              as int?,
      nextPosition: freezed == nextPosition
          ? _value.nextPosition
          : nextPosition // ignore: cast_nullable_to_non_nullable
              as int?,
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
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ActiveObjectEventImplCopyWith<$Res>
    implements $ActiveObjectEventCopyWith<$Res> {
  factory _$$ActiveObjectEventImplCopyWith(_$ActiveObjectEventImpl value,
          $Res Function(_$ActiveObjectEventImpl) then) =
      __$$ActiveObjectEventImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int objectId,
      EventType eventType,
      List<StateData>? states,
      int? angle,
      int? nextPosition,
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
      ActiveObjectType? objectType});
}

/// @nodoc
class __$$ActiveObjectEventImplCopyWithImpl<$Res>
    extends _$ActiveObjectEventCopyWithImpl<$Res, _$ActiveObjectEventImpl>
    implements _$$ActiveObjectEventImplCopyWith<$Res> {
  __$$ActiveObjectEventImplCopyWithImpl(_$ActiveObjectEventImpl _value,
      $Res Function(_$ActiveObjectEventImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? objectId = null,
    Object? eventType = null,
    Object? states = freezed,
    Object? angle = freezed,
    Object? nextPosition = freezed,
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
  }) {
    return _then(_$ActiveObjectEventImpl(
      objectId: null == objectId
          ? _value.objectId
          : objectId // ignore: cast_nullable_to_non_nullable
              as int,
      eventType: null == eventType
          ? _value.eventType
          : eventType // ignore: cast_nullable_to_non_nullable
              as EventType,
      states: freezed == states
          ? _value._states
          : states // ignore: cast_nullable_to_non_nullable
              as List<StateData>?,
      angle: freezed == angle
          ? _value.angle
          : angle // ignore: cast_nullable_to_non_nullable
              as int?,
      nextPosition: freezed == nextPosition
          ? _value.nextPosition
          : nextPosition // ignore: cast_nullable_to_non_nullable
              as int?,
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
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ActiveObjectEventImpl extends _ActiveObjectEvent {
  _$ActiveObjectEventImpl(
      {required this.objectId,
      required this.eventType,
      final List<StateData>? states,
      this.angle,
      this.nextPosition,
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
      this.objectType})
      : _states = states,
        super._();

  factory _$ActiveObjectEventImpl.fromJson(Map<String, dynamic> json) =>
      _$$ActiveObjectEventImplFromJson(json);

  @override
  final int objectId;
  @override
  final EventType eventType;
  final List<StateData>? _states;
  @override
  List<StateData>? get states {
    final value = _states;
    if (value == null) return null;
    if (_states is EqualUnmodifiableListView) return _states;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final int? angle;
  @override
  final int? nextPosition;
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
  String toString() {
    return 'ActiveObjectEvent(objectId: $objectId, eventType: $eventType, states: $states, angle: $angle, nextPosition: $nextPosition, team: $team, directionX: $directionX, directionY: $directionY, gravity: $gravity, lifeStep: $lifeStep, speed: $speed, position: $position, destination: $destination, targetId: $targetId, ownerId: $ownerId, objectType: $objectType)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ActiveObjectEventImpl &&
            (identical(other.objectId, objectId) ||
                other.objectId == objectId) &&
            (identical(other.eventType, eventType) ||
                other.eventType == eventType) &&
            const DeepCollectionEquality().equals(other._states, _states) &&
            (identical(other.angle, angle) || other.angle == angle) &&
            (identical(other.nextPosition, nextPosition) ||
                other.nextPosition == nextPosition) &&
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
                other.objectType == objectType));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      objectId,
      eventType,
      const DeepCollectionEquality().hash(_states),
      angle,
      nextPosition,
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
      objectType);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ActiveObjectEventImplCopyWith<_$ActiveObjectEventImpl> get copyWith =>
      __$$ActiveObjectEventImplCopyWithImpl<_$ActiveObjectEventImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ActiveObjectEventImplToJson(
      this,
    );
  }
}

abstract class _ActiveObjectEvent extends ActiveObjectEvent {
  factory _ActiveObjectEvent(
      {required final int objectId,
      required final EventType eventType,
      final List<StateData>? states,
      final int? angle,
      final int? nextPosition,
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
      final ActiveObjectType? objectType}) = _$ActiveObjectEventImpl;
  _ActiveObjectEvent._() : super._();

  factory _ActiveObjectEvent.fromJson(Map<String, dynamic> json) =
      _$ActiveObjectEventImpl.fromJson;

  @override
  int get objectId;
  @override
  EventType get eventType;
  @override
  List<StateData>? get states;
  @override
  int? get angle;
  @override
  int? get nextPosition;
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
  @JsonKey(ignore: true)
  _$$ActiveObjectEventImplCopyWith<_$ActiveObjectEventImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

PassiveObjectEvent _$PassiveObjectEventFromJson(Map<String, dynamic> json) {
  return _PassiveObjectEvent.fromJson(json);
}

/// @nodoc
mixin _$PassiveObjectEvent {
  int get objectId => throw _privateConstructorUsedError;
  EventType get eventType => throw _privateConstructorUsedError;
  List<StateData>? get states => throw _privateConstructorUsedError;
  int? get position => throw _privateConstructorUsedError;
  PassiveObjectType? get objectType => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PassiveObjectEventCopyWith<PassiveObjectEvent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PassiveObjectEventCopyWith<$Res> {
  factory $PassiveObjectEventCopyWith(
          PassiveObjectEvent value, $Res Function(PassiveObjectEvent) then) =
      _$PassiveObjectEventCopyWithImpl<$Res, PassiveObjectEvent>;
  @useResult
  $Res call(
      {int objectId,
      EventType eventType,
      List<StateData>? states,
      int? position,
      PassiveObjectType? objectType});
}

/// @nodoc
class _$PassiveObjectEventCopyWithImpl<$Res, $Val extends PassiveObjectEvent>
    implements $PassiveObjectEventCopyWith<$Res> {
  _$PassiveObjectEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? objectId = null,
    Object? eventType = null,
    Object? states = freezed,
    Object? position = freezed,
    Object? objectType = freezed,
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
      states: freezed == states
          ? _value.states
          : states // ignore: cast_nullable_to_non_nullable
              as List<StateData>?,
      position: freezed == position
          ? _value.position
          : position // ignore: cast_nullable_to_non_nullable
              as int?,
      objectType: freezed == objectType
          ? _value.objectType
          : objectType // ignore: cast_nullable_to_non_nullable
              as PassiveObjectType?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PassiveObjectEventImplCopyWith<$Res>
    implements $PassiveObjectEventCopyWith<$Res> {
  factory _$$PassiveObjectEventImplCopyWith(_$PassiveObjectEventImpl value,
          $Res Function(_$PassiveObjectEventImpl) then) =
      __$$PassiveObjectEventImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int objectId,
      EventType eventType,
      List<StateData>? states,
      int? position,
      PassiveObjectType? objectType});
}

/// @nodoc
class __$$PassiveObjectEventImplCopyWithImpl<$Res>
    extends _$PassiveObjectEventCopyWithImpl<$Res, _$PassiveObjectEventImpl>
    implements _$$PassiveObjectEventImplCopyWith<$Res> {
  __$$PassiveObjectEventImplCopyWithImpl(_$PassiveObjectEventImpl _value,
      $Res Function(_$PassiveObjectEventImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? objectId = null,
    Object? eventType = null,
    Object? states = freezed,
    Object? position = freezed,
    Object? objectType = freezed,
  }) {
    return _then(_$PassiveObjectEventImpl(
      objectId: null == objectId
          ? _value.objectId
          : objectId // ignore: cast_nullable_to_non_nullable
              as int,
      eventType: null == eventType
          ? _value.eventType
          : eventType // ignore: cast_nullable_to_non_nullable
              as EventType,
      states: freezed == states
          ? _value._states
          : states // ignore: cast_nullable_to_non_nullable
              as List<StateData>?,
      position: freezed == position
          ? _value.position
          : position // ignore: cast_nullable_to_non_nullable
              as int?,
      objectType: freezed == objectType
          ? _value.objectType
          : objectType // ignore: cast_nullable_to_non_nullable
              as PassiveObjectType?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PassiveObjectEventImpl extends _PassiveObjectEvent {
  _$PassiveObjectEventImpl(
      {required this.objectId,
      required this.eventType,
      final List<StateData>? states,
      this.position,
      this.objectType})
      : _states = states,
        super._();

  factory _$PassiveObjectEventImpl.fromJson(Map<String, dynamic> json) =>
      _$$PassiveObjectEventImplFromJson(json);

  @override
  final int objectId;
  @override
  final EventType eventType;
  final List<StateData>? _states;
  @override
  List<StateData>? get states {
    final value = _states;
    if (value == null) return null;
    if (_states is EqualUnmodifiableListView) return _states;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final int? position;
  @override
  final PassiveObjectType? objectType;

  @override
  String toString() {
    return 'PassiveObjectEvent(objectId: $objectId, eventType: $eventType, states: $states, position: $position, objectType: $objectType)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PassiveObjectEventImpl &&
            (identical(other.objectId, objectId) ||
                other.objectId == objectId) &&
            (identical(other.eventType, eventType) ||
                other.eventType == eventType) &&
            const DeepCollectionEquality().equals(other._states, _states) &&
            (identical(other.position, position) ||
                other.position == position) &&
            (identical(other.objectType, objectType) ||
                other.objectType == objectType));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, objectId, eventType,
      const DeepCollectionEquality().hash(_states), position, objectType);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PassiveObjectEventImplCopyWith<_$PassiveObjectEventImpl> get copyWith =>
      __$$PassiveObjectEventImplCopyWithImpl<_$PassiveObjectEventImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PassiveObjectEventImplToJson(
      this,
    );
  }
}

abstract class _PassiveObjectEvent extends PassiveObjectEvent {
  factory _PassiveObjectEvent(
      {required final int objectId,
      required final EventType eventType,
      final List<StateData>? states,
      final int? position,
      final PassiveObjectType? objectType}) = _$PassiveObjectEventImpl;
  _PassiveObjectEvent._() : super._();

  factory _PassiveObjectEvent.fromJson(Map<String, dynamic> json) =
      _$PassiveObjectEventImpl.fromJson;

  @override
  int get objectId;
  @override
  EventType get eventType;
  @override
  List<StateData>? get states;
  @override
  int? get position;
  @override
  PassiveObjectType? get objectType;
  @override
  @JsonKey(ignore: true)
  _$$PassiveObjectEventImplCopyWith<_$PassiveObjectEventImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
