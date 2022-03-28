// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'app_error.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$AppErrorTearOff {
  const _$AppErrorTearOff();

  AppOtherError other({required Object error}) {
    return AppOtherError(
      error: error,
    );
  }

  AppDioError dio({required DioError error}) {
    return AppDioError(
      error: error,
    );
  }

  AppStripeError stripe({required StripeException error}) {
    return AppStripeError(
      error: error,
    );
  }
}

/// @nodoc
const $AppError = _$AppErrorTearOff();

/// @nodoc
mixin _$AppError {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Object error) other,
    required TResult Function(DioError error) dio,
    required TResult Function(StripeException error) stripe,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(Object error)? other,
    TResult Function(DioError error)? dio,
    TResult Function(StripeException error)? stripe,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Object error)? other,
    TResult Function(DioError error)? dio,
    TResult Function(StripeException error)? stripe,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AppOtherError value) other,
    required TResult Function(AppDioError value) dio,
    required TResult Function(AppStripeError value) stripe,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(AppOtherError value)? other,
    TResult Function(AppDioError value)? dio,
    TResult Function(AppStripeError value)? stripe,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AppOtherError value)? other,
    TResult Function(AppDioError value)? dio,
    TResult Function(AppStripeError value)? stripe,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AppErrorCopyWith<$Res> {
  factory $AppErrorCopyWith(AppError value, $Res Function(AppError) then) =
      _$AppErrorCopyWithImpl<$Res>;
}

/// @nodoc
class _$AppErrorCopyWithImpl<$Res> implements $AppErrorCopyWith<$Res> {
  _$AppErrorCopyWithImpl(this._value, this._then);

  final AppError _value;
  // ignore: unused_field
  final $Res Function(AppError) _then;
}

/// @nodoc
abstract class $AppOtherErrorCopyWith<$Res> {
  factory $AppOtherErrorCopyWith(
          AppOtherError value, $Res Function(AppOtherError) then) =
      _$AppOtherErrorCopyWithImpl<$Res>;
  $Res call({Object error});
}

/// @nodoc
class _$AppOtherErrorCopyWithImpl<$Res> extends _$AppErrorCopyWithImpl<$Res>
    implements $AppOtherErrorCopyWith<$Res> {
  _$AppOtherErrorCopyWithImpl(
      AppOtherError _value, $Res Function(AppOtherError) _then)
      : super(_value, (v) => _then(v as AppOtherError));

  @override
  AppOtherError get _value => super._value as AppOtherError;

  @override
  $Res call({
    Object? error = freezed,
  }) {
    return _then(AppOtherError(
      error: error == freezed
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as Object,
    ));
  }
}

/// @nodoc

class _$AppOtherError implements AppOtherError {
  const _$AppOtherError({required this.error});

  @override
  final Object error;

  @override
  String toString() {
    return 'AppError.other(error: $error)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is AppOtherError &&
            const DeepCollectionEquality().equals(other.error, error));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(error));

  @JsonKey(ignore: true)
  @override
  $AppOtherErrorCopyWith<AppOtherError> get copyWith =>
      _$AppOtherErrorCopyWithImpl<AppOtherError>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Object error) other,
    required TResult Function(DioError error) dio,
    required TResult Function(StripeException error) stripe,
  }) {
    return other(error);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(Object error)? other,
    TResult Function(DioError error)? dio,
    TResult Function(StripeException error)? stripe,
  }) {
    return other?.call(error);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Object error)? other,
    TResult Function(DioError error)? dio,
    TResult Function(StripeException error)? stripe,
    required TResult orElse(),
  }) {
    if (other != null) {
      return other(error);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AppOtherError value) other,
    required TResult Function(AppDioError value) dio,
    required TResult Function(AppStripeError value) stripe,
  }) {
    return other(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(AppOtherError value)? other,
    TResult Function(AppDioError value)? dio,
    TResult Function(AppStripeError value)? stripe,
  }) {
    return other?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AppOtherError value)? other,
    TResult Function(AppDioError value)? dio,
    TResult Function(AppStripeError value)? stripe,
    required TResult orElse(),
  }) {
    if (other != null) {
      return other(this);
    }
    return orElse();
  }
}

abstract class AppOtherError implements AppError {
  const factory AppOtherError({required Object error}) = _$AppOtherError;

  Object get error;
  @JsonKey(ignore: true)
  $AppOtherErrorCopyWith<AppOtherError> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AppDioErrorCopyWith<$Res> {
  factory $AppDioErrorCopyWith(
          AppDioError value, $Res Function(AppDioError) then) =
      _$AppDioErrorCopyWithImpl<$Res>;
  $Res call({DioError error});
}

/// @nodoc
class _$AppDioErrorCopyWithImpl<$Res> extends _$AppErrorCopyWithImpl<$Res>
    implements $AppDioErrorCopyWith<$Res> {
  _$AppDioErrorCopyWithImpl(
      AppDioError _value, $Res Function(AppDioError) _then)
      : super(_value, (v) => _then(v as AppDioError));

  @override
  AppDioError get _value => super._value as AppDioError;

  @override
  $Res call({
    Object? error = freezed,
  }) {
    return _then(AppDioError(
      error: error == freezed
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as DioError,
    ));
  }
}

/// @nodoc

class _$AppDioError implements AppDioError {
  const _$AppDioError({required this.error});

  @override
  final DioError error;

  @override
  String toString() {
    return 'AppError.dio(error: $error)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is AppDioError &&
            const DeepCollectionEquality().equals(other.error, error));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(error));

  @JsonKey(ignore: true)
  @override
  $AppDioErrorCopyWith<AppDioError> get copyWith =>
      _$AppDioErrorCopyWithImpl<AppDioError>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Object error) other,
    required TResult Function(DioError error) dio,
    required TResult Function(StripeException error) stripe,
  }) {
    return dio(error);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(Object error)? other,
    TResult Function(DioError error)? dio,
    TResult Function(StripeException error)? stripe,
  }) {
    return dio?.call(error);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Object error)? other,
    TResult Function(DioError error)? dio,
    TResult Function(StripeException error)? stripe,
    required TResult orElse(),
  }) {
    if (dio != null) {
      return dio(error);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AppOtherError value) other,
    required TResult Function(AppDioError value) dio,
    required TResult Function(AppStripeError value) stripe,
  }) {
    return dio(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(AppOtherError value)? other,
    TResult Function(AppDioError value)? dio,
    TResult Function(AppStripeError value)? stripe,
  }) {
    return dio?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AppOtherError value)? other,
    TResult Function(AppDioError value)? dio,
    TResult Function(AppStripeError value)? stripe,
    required TResult orElse(),
  }) {
    if (dio != null) {
      return dio(this);
    }
    return orElse();
  }
}

abstract class AppDioError implements AppError {
  const factory AppDioError({required DioError error}) = _$AppDioError;

  DioError get error;
  @JsonKey(ignore: true)
  $AppDioErrorCopyWith<AppDioError> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AppStripeErrorCopyWith<$Res> {
  factory $AppStripeErrorCopyWith(
          AppStripeError value, $Res Function(AppStripeError) then) =
      _$AppStripeErrorCopyWithImpl<$Res>;
  $Res call({StripeException error});

  $StripeExceptionCopyWith<$Res> get error;
}

/// @nodoc
class _$AppStripeErrorCopyWithImpl<$Res> extends _$AppErrorCopyWithImpl<$Res>
    implements $AppStripeErrorCopyWith<$Res> {
  _$AppStripeErrorCopyWithImpl(
      AppStripeError _value, $Res Function(AppStripeError) _then)
      : super(_value, (v) => _then(v as AppStripeError));

  @override
  AppStripeError get _value => super._value as AppStripeError;

  @override
  $Res call({
    Object? error = freezed,
  }) {
    return _then(AppStripeError(
      error: error == freezed
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as StripeException,
    ));
  }

  @override
  $StripeExceptionCopyWith<$Res> get error {
    return $StripeExceptionCopyWith<$Res>(_value.error, (value) {
      return _then(_value.copyWith(error: value));
    });
  }
}

/// @nodoc

class _$AppStripeError implements AppStripeError {
  const _$AppStripeError({required this.error});

  @override
  final StripeException error;

  @override
  String toString() {
    return 'AppError.stripe(error: $error)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is AppStripeError &&
            const DeepCollectionEquality().equals(other.error, error));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(error));

  @JsonKey(ignore: true)
  @override
  $AppStripeErrorCopyWith<AppStripeError> get copyWith =>
      _$AppStripeErrorCopyWithImpl<AppStripeError>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Object error) other,
    required TResult Function(DioError error) dio,
    required TResult Function(StripeException error) stripe,
  }) {
    return stripe(error);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(Object error)? other,
    TResult Function(DioError error)? dio,
    TResult Function(StripeException error)? stripe,
  }) {
    return stripe?.call(error);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Object error)? other,
    TResult Function(DioError error)? dio,
    TResult Function(StripeException error)? stripe,
    required TResult orElse(),
  }) {
    if (stripe != null) {
      return stripe(error);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AppOtherError value) other,
    required TResult Function(AppDioError value) dio,
    required TResult Function(AppStripeError value) stripe,
  }) {
    return stripe(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(AppOtherError value)? other,
    TResult Function(AppDioError value)? dio,
    TResult Function(AppStripeError value)? stripe,
  }) {
    return stripe?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AppOtherError value)? other,
    TResult Function(AppDioError value)? dio,
    TResult Function(AppStripeError value)? stripe,
    required TResult orElse(),
  }) {
    if (stripe != null) {
      return stripe(this);
    }
    return orElse();
  }
}

abstract class AppStripeError implements AppError {
  const factory AppStripeError({required StripeException error}) =
      _$AppStripeError;

  StripeException get error;
  @JsonKey(ignore: true)
  $AppStripeErrorCopyWith<AppStripeError> get copyWith =>
      throw _privateConstructorUsedError;
}
