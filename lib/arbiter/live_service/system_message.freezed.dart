// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'system_message.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

GamePlayerRecord _$GamePlayerRecordFromJson(Map<String, dynamic> json) {
  return _GamePlayerRecord.fromJson(json);
}

/// @nodoc
mixin _$GamePlayerRecord {
  int get userId => throw _privateConstructorUsedError;
  String get userName => throw _privateConstructorUsedError;
  Team get team => throw _privateConstructorUsedError;
  int get kill => throw _privateConstructorUsedError;
  int get death => throw _privateConstructorUsedError;
  int get territory => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $GamePlayerRecordCopyWith<GamePlayerRecord> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GamePlayerRecordCopyWith<$Res> {
  factory $GamePlayerRecordCopyWith(
          GamePlayerRecord value, $Res Function(GamePlayerRecord) then) =
      _$GamePlayerRecordCopyWithImpl<$Res, GamePlayerRecord>;
  @useResult
  $Res call(
      {int userId,
      String userName,
      Team team,
      int kill,
      int death,
      int territory});
}

/// @nodoc
class _$GamePlayerRecordCopyWithImpl<$Res, $Val extends GamePlayerRecord>
    implements $GamePlayerRecordCopyWith<$Res> {
  _$GamePlayerRecordCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? userName = null,
    Object? team = null,
    Object? kill = null,
    Object? death = null,
    Object? territory = null,
  }) {
    return _then(_value.copyWith(
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as int,
      userName: null == userName
          ? _value.userName
          : userName // ignore: cast_nullable_to_non_nullable
              as String,
      team: null == team
          ? _value.team
          : team // ignore: cast_nullable_to_non_nullable
              as Team,
      kill: null == kill
          ? _value.kill
          : kill // ignore: cast_nullable_to_non_nullable
              as int,
      death: null == death
          ? _value.death
          : death // ignore: cast_nullable_to_non_nullable
              as int,
      territory: null == territory
          ? _value.territory
          : territory // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$GamePlayerRecordImplCopyWith<$Res>
    implements $GamePlayerRecordCopyWith<$Res> {
  factory _$$GamePlayerRecordImplCopyWith(_$GamePlayerRecordImpl value,
          $Res Function(_$GamePlayerRecordImpl) then) =
      __$$GamePlayerRecordImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int userId,
      String userName,
      Team team,
      int kill,
      int death,
      int territory});
}

/// @nodoc
class __$$GamePlayerRecordImplCopyWithImpl<$Res>
    extends _$GamePlayerRecordCopyWithImpl<$Res, _$GamePlayerRecordImpl>
    implements _$$GamePlayerRecordImplCopyWith<$Res> {
  __$$GamePlayerRecordImplCopyWithImpl(_$GamePlayerRecordImpl _value,
      $Res Function(_$GamePlayerRecordImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? userName = null,
    Object? team = null,
    Object? kill = null,
    Object? death = null,
    Object? territory = null,
  }) {
    return _then(_$GamePlayerRecordImpl(
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as int,
      userName: null == userName
          ? _value.userName
          : userName // ignore: cast_nullable_to_non_nullable
              as String,
      team: null == team
          ? _value.team
          : team // ignore: cast_nullable_to_non_nullable
              as Team,
      kill: null == kill
          ? _value.kill
          : kill // ignore: cast_nullable_to_non_nullable
              as int,
      death: null == death
          ? _value.death
          : death // ignore: cast_nullable_to_non_nullable
              as int,
      territory: null == territory
          ? _value.territory
          : territory // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$GamePlayerRecordImpl implements _GamePlayerRecord {
  const _$GamePlayerRecordImpl(
      {required this.userId,
      required this.userName,
      required this.team,
      required this.kill,
      required this.death,
      required this.territory});

  factory _$GamePlayerRecordImpl.fromJson(Map<String, dynamic> json) =>
      _$$GamePlayerRecordImplFromJson(json);

  @override
  final int userId;
  @override
  final String userName;
  @override
  final Team team;
  @override
  final int kill;
  @override
  final int death;
  @override
  final int territory;

  @override
  String toString() {
    return 'GamePlayerRecord(userId: $userId, userName: $userName, team: $team, kill: $kill, death: $death, territory: $territory)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GamePlayerRecordImpl &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.userName, userName) ||
                other.userName == userName) &&
            (identical(other.team, team) || other.team == team) &&
            (identical(other.kill, kill) || other.kill == kill) &&
            (identical(other.death, death) || other.death == death) &&
            (identical(other.territory, territory) ||
                other.territory == territory));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, userId, userName, team, kill, death, territory);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$GamePlayerRecordImplCopyWith<_$GamePlayerRecordImpl> get copyWith =>
      __$$GamePlayerRecordImplCopyWithImpl<_$GamePlayerRecordImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GamePlayerRecordImplToJson(
      this,
    );
  }
}

abstract class _GamePlayerRecord implements GamePlayerRecord {
  const factory _GamePlayerRecord(
      {required final int userId,
      required final String userName,
      required final Team team,
      required final int kill,
      required final int death,
      required final int territory}) = _$GamePlayerRecordImpl;

  factory _GamePlayerRecord.fromJson(Map<String, dynamic> json) =
      _$GamePlayerRecordImpl.fromJson;

  @override
  int get userId;
  @override
  String get userName;
  @override
  Team get team;
  @override
  int get kill;
  @override
  int get death;
  @override
  int get territory;
  @override
  @JsonKey(ignore: true)
  _$$GamePlayerRecordImplCopyWith<_$GamePlayerRecordImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
