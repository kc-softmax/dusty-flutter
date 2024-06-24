// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

WebRTCSignalData _$WebRTCSignalDataFromJson(Map<String, dynamic> json) {
  return _WebRTCSignalData.fromJson(json);
}

/// @nodoc
mixin _$WebRTCSignalData {
  SignalingMessageType get type => throw _privateConstructorUsedError;
  String? get sdp => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $WebRTCSignalDataCopyWith<WebRTCSignalData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WebRTCSignalDataCopyWith<$Res> {
  factory $WebRTCSignalDataCopyWith(
          WebRTCSignalData value, $Res Function(WebRTCSignalData) then) =
      _$WebRTCSignalDataCopyWithImpl<$Res, WebRTCSignalData>;
  @useResult
  $Res call({SignalingMessageType type, String? sdp});
}

/// @nodoc
class _$WebRTCSignalDataCopyWithImpl<$Res, $Val extends WebRTCSignalData>
    implements $WebRTCSignalDataCopyWith<$Res> {
  _$WebRTCSignalDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? sdp = freezed,
  }) {
    return _then(_value.copyWith(
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as SignalingMessageType,
      sdp: freezed == sdp
          ? _value.sdp
          : sdp // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$WebRTCSignalDataImplCopyWith<$Res>
    implements $WebRTCSignalDataCopyWith<$Res> {
  factory _$$WebRTCSignalDataImplCopyWith(_$WebRTCSignalDataImpl value,
          $Res Function(_$WebRTCSignalDataImpl) then) =
      __$$WebRTCSignalDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({SignalingMessageType type, String? sdp});
}

/// @nodoc
class __$$WebRTCSignalDataImplCopyWithImpl<$Res>
    extends _$WebRTCSignalDataCopyWithImpl<$Res, _$WebRTCSignalDataImpl>
    implements _$$WebRTCSignalDataImplCopyWith<$Res> {
  __$$WebRTCSignalDataImplCopyWithImpl(_$WebRTCSignalDataImpl _value,
      $Res Function(_$WebRTCSignalDataImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? sdp = freezed,
  }) {
    return _then(_$WebRTCSignalDataImpl(
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as SignalingMessageType,
      sdp: freezed == sdp
          ? _value.sdp
          : sdp // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$WebRTCSignalDataImpl implements _WebRTCSignalData {
  const _$WebRTCSignalDataImpl({required this.type, this.sdp});

  factory _$WebRTCSignalDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$WebRTCSignalDataImplFromJson(json);

  @override
  final SignalingMessageType type;
  @override
  final String? sdp;

  @override
  String toString() {
    return 'WebRTCSignalData(type: $type, sdp: $sdp)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WebRTCSignalDataImpl &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.sdp, sdp) || other.sdp == sdp));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, type, sdp);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$WebRTCSignalDataImplCopyWith<_$WebRTCSignalDataImpl> get copyWith =>
      __$$WebRTCSignalDataImplCopyWithImpl<_$WebRTCSignalDataImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$WebRTCSignalDataImplToJson(
      this,
    );
  }
}

abstract class _WebRTCSignalData implements WebRTCSignalData {
  const factory _WebRTCSignalData(
      {required final SignalingMessageType type,
      final String? sdp}) = _$WebRTCSignalDataImpl;

  factory _WebRTCSignalData.fromJson(Map<String, dynamic> json) =
      _$WebRTCSignalDataImpl.fromJson;

  @override
  SignalingMessageType get type;
  @override
  String? get sdp;
  @override
  @JsonKey(ignore: true)
  _$$WebRTCSignalDataImplCopyWith<_$WebRTCSignalDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

DataChannelMessageData _$DataChannelMessageDataFromJson(
    Map<String, dynamic> json) {
  return _DataChannelMessageData.fromJson(json);
}

/// @nodoc
mixin _$DataChannelMessageData {
  @JsonKey(name: 'user_id')
  int get userId => throw _privateConstructorUsedError;
  String get text => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DataChannelMessageDataCopyWith<DataChannelMessageData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DataChannelMessageDataCopyWith<$Res> {
  factory $DataChannelMessageDataCopyWith(DataChannelMessageData value,
          $Res Function(DataChannelMessageData) then) =
      _$DataChannelMessageDataCopyWithImpl<$Res, DataChannelMessageData>;
  @useResult
  $Res call({@JsonKey(name: 'user_id') int userId, String text});
}

/// @nodoc
class _$DataChannelMessageDataCopyWithImpl<$Res,
        $Val extends DataChannelMessageData>
    implements $DataChannelMessageDataCopyWith<$Res> {
  _$DataChannelMessageDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? text = null,
  }) {
    return _then(_value.copyWith(
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as int,
      text: null == text
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DataChannelMessageDataImplCopyWith<$Res>
    implements $DataChannelMessageDataCopyWith<$Res> {
  factory _$$DataChannelMessageDataImplCopyWith(
          _$DataChannelMessageDataImpl value,
          $Res Function(_$DataChannelMessageDataImpl) then) =
      __$$DataChannelMessageDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({@JsonKey(name: 'user_id') int userId, String text});
}

/// @nodoc
class __$$DataChannelMessageDataImplCopyWithImpl<$Res>
    extends _$DataChannelMessageDataCopyWithImpl<$Res,
        _$DataChannelMessageDataImpl>
    implements _$$DataChannelMessageDataImplCopyWith<$Res> {
  __$$DataChannelMessageDataImplCopyWithImpl(
      _$DataChannelMessageDataImpl _value,
      $Res Function(_$DataChannelMessageDataImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? text = null,
  }) {
    return _then(_$DataChannelMessageDataImpl(
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as int,
      text: null == text
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DataChannelMessageDataImpl implements _DataChannelMessageData {
  const _$DataChannelMessageDataImpl(
      {@JsonKey(name: 'user_id') required this.userId, required this.text});

  factory _$DataChannelMessageDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$DataChannelMessageDataImplFromJson(json);

  @override
  @JsonKey(name: 'user_id')
  final int userId;
  @override
  final String text;

  @override
  String toString() {
    return 'DataChannelMessageData(userId: $userId, text: $text)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DataChannelMessageDataImpl &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.text, text) || other.text == text));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, userId, text);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DataChannelMessageDataImplCopyWith<_$DataChannelMessageDataImpl>
      get copyWith => __$$DataChannelMessageDataImplCopyWithImpl<
          _$DataChannelMessageDataImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DataChannelMessageDataImplToJson(
      this,
    );
  }
}

abstract class _DataChannelMessageData implements DataChannelMessageData {
  const factory _DataChannelMessageData(
      {@JsonKey(name: 'user_id') required final int userId,
      required final String text}) = _$DataChannelMessageDataImpl;

  factory _DataChannelMessageData.fromJson(Map<String, dynamic> json) =
      _$DataChannelMessageDataImpl.fromJson;

  @override
  @JsonKey(name: 'user_id')
  int get userId;
  @override
  String get text;
  @override
  @JsonKey(ignore: true)
  _$$DataChannelMessageDataImplCopyWith<_$DataChannelMessageDataImpl>
      get copyWith => throw _privateConstructorUsedError;
}
