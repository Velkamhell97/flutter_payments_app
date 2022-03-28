import 'package:dio/dio.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_error.freezed.dart';

@freezed
class AppError with _$AppError {
  const factory AppError.other({required Object error}) = AppOtherError;
  const factory AppError.dio({required DioError error}) = AppDioError;
  const factory AppError.stripe({required StripeException error}) = AppStripeError;
}