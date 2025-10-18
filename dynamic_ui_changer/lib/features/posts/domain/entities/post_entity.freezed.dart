// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'post_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

PostEntity _$PostEntityFromJson(Map<String, dynamic> json) {
  return _PostEntity.fromJson(json);
}

/// @nodoc
mixin _$PostEntity {
  int get id => throw _privateConstructorUsedError;
  int get userId => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get body => throw _privateConstructorUsedError;

  /// Serializes this PostEntity to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PostEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PostEntityCopyWith<PostEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PostEntityCopyWith<$Res> {
  factory $PostEntityCopyWith(
    PostEntity value,
    $Res Function(PostEntity) then,
  ) = _$PostEntityCopyWithImpl<$Res, PostEntity>;
  @useResult
  $Res call({int id, int userId, String title, String body});
}

/// @nodoc
class _$PostEntityCopyWithImpl<$Res, $Val extends PostEntity>
    implements $PostEntityCopyWith<$Res> {
  _$PostEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PostEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? title = null,
    Object? body = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as int,
            userId: null == userId
                ? _value.userId
                : userId // ignore: cast_nullable_to_non_nullable
                      as int,
            title: null == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                      as String,
            body: null == body
                ? _value.body
                : body // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$PostEntityImplCopyWith<$Res>
    implements $PostEntityCopyWith<$Res> {
  factory _$$PostEntityImplCopyWith(
    _$PostEntityImpl value,
    $Res Function(_$PostEntityImpl) then,
  ) = __$$PostEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int id, int userId, String title, String body});
}

/// @nodoc
class __$$PostEntityImplCopyWithImpl<$Res>
    extends _$PostEntityCopyWithImpl<$Res, _$PostEntityImpl>
    implements _$$PostEntityImplCopyWith<$Res> {
  __$$PostEntityImplCopyWithImpl(
    _$PostEntityImpl _value,
    $Res Function(_$PostEntityImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PostEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? title = null,
    Object? body = null,
  }) {
    return _then(
      _$PostEntityImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        userId: null == userId
            ? _value.userId
            : userId // ignore: cast_nullable_to_non_nullable
                  as int,
        title: null == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        body: null == body
            ? _value.body
            : body // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$PostEntityImpl implements _PostEntity {
  const _$PostEntityImpl({
    required this.id,
    required this.userId,
    required this.title,
    required this.body,
  });

  factory _$PostEntityImpl.fromJson(Map<String, dynamic> json) =>
      _$$PostEntityImplFromJson(json);

  @override
  final int id;
  @override
  final int userId;
  @override
  final String title;
  @override
  final String body;

  @override
  String toString() {
    return 'PostEntity(id: $id, userId: $userId, title: $title, body: $body)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PostEntityImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.body, body) || other.body == body));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, userId, title, body);

  /// Create a copy of PostEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PostEntityImplCopyWith<_$PostEntityImpl> get copyWith =>
      __$$PostEntityImplCopyWithImpl<_$PostEntityImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PostEntityImplToJson(this);
  }
}

abstract class _PostEntity implements PostEntity {
  const factory _PostEntity({
    required final int id,
    required final int userId,
    required final String title,
    required final String body,
  }) = _$PostEntityImpl;

  factory _PostEntity.fromJson(Map<String, dynamic> json) =
      _$PostEntityImpl.fromJson;

  @override
  int get id;
  @override
  int get userId;
  @override
  String get title;
  @override
  String get body;

  /// Create a copy of PostEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PostEntityImplCopyWith<_$PostEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
