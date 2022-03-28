import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart' show DioError;
import 'package:flutter_stripe/flutter_stripe.dart' hide PaymentMethod;
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../models/models.dart';
import '../../services/services.dart';

part 'fetch_event.dart';
part 'fetch_state.dart';

part 'fetch_bloc.freezed.dart';

class FetchBloc extends Bloc<FetchEvent, FetchState> {
  final StripeService _stripe;

  FetchBloc(this._stripe) : super(const _Initial()) {
    on<_FetchGetPaymentMethods>((event, emit) async {
      try {
        emit(const _Preparing());

        final paymentMethods = await _stripe.getPaymentMethods(event.email);

        emit(_$PaymentMethodsObtained(paymentMethods: paymentMethods));
      } on DioError catch(error){
        emit(_Error(error: AppError.dio(error: error)));
      } on StripeException catch(error) {
        emit(_Error(error: AppError.stripe(error: error)));
      } catch (error) {
        emit(_Error(error: AppOtherError(error: error)));
      }
    });

    on<_FetchPayWithStripe>((event, emit) async {
      try {
        emit(const _Preparing());
        await _stripe.preparePaymentSheet(event.data);

        emit(const _Initial());
        await _stripe.showPaymentSheet();

        emit(const _StripePaymentSuccess());
      } on DioError catch(error){
        emit(_Error(error: AppError.dio(error: error)));
      } on StripeException catch(error) {
        emit(_Error(error: AppError.stripe(error: error)));
      } catch (error) {
        emit(_Error(error: AppOtherError(error: error)));
      }
    });

    on<_FetchPayWithCard>((event, emit) async {
      try {
        emit(const _Loading());

        await _stripe.payWithCard(event.data, event.cardDetails);

        emit(const _CardPaymentSuccess());
      } on DioError catch(error){
        emit(_Error(error: AppError.dio(error: error)));
      } on StripeException catch(error) {
        emit(_Error(error: AppError.stripe(error: error)));
      } catch (error) {
        emit(_Error(error: AppOtherError(error: error)));
      }
    });

    on<_FetchPayWithCardManual>((event, emit) async {
      try {
        emit(const _Loading());

        await _stripe.payWithCardManual(event.data, event.cardDetails);

        emit(const _CardManualPaymentSuccess());
      } on DioError catch(error){
        emit(_Error(error: AppError.dio(error: error)));
      } on StripeException catch(error) {
        emit(_Error(error: AppError.stripe(error: error)));
      } catch (error) {
        emit(_Error(error: AppOtherError(error: error)));
      }
    });

    on<_FetchPayWithMethodManual>((event, emit) async {
      try {
        emit(const _Loading());

        await _stripe.payWithMethodManual(event.data, event.paymentMethodId);

        emit(const _CardManualPaymentSuccess());
      } on DioError catch(error){
        emit(_Error(error: AppError.dio(error: error)));
      } on StripeException catch(error) {
        emit(_Error(error: AppError.stripe(error: error)));
      } catch (error) {
        emit(_Error(error: AppOtherError(error: error)));
      }
    });

    on<_FetchPayWithCardToken>((event, emit) async {
      try {
        emit(const _Loading());

        await _stripe.payWithCardToken(event.data, event.cardDetails);

        emit(const _CardTokenPaymentSuccess());
      } on DioError catch(error){
        emit(_Error(error: AppError.dio(error: error)));
      } on StripeException catch(error) {
        emit(_Error(error: AppError.stripe(error: error)));
      } catch (error) {
        emit(_Error(error: AppOtherError(error: error)));
      }
    });

    on<_FetchSavePaymentMethod>((event, emit) async {
      try {
        emit(const _Loading());

        final paymentMethod = await _stripe.savePaymentMethod(event.data, event.cardDetails);
        
        emit(_PaymentMethodSaved(paymentMethod: paymentMethod));
      } on DioError catch(error){
        emit(_Error(error: AppError.dio(error: error)));
      } on StripeException catch(error) {
        emit(_Error(error: AppError.stripe(error: error)));
      } catch (error) {
        emit(_Error(error: AppOtherError(error: error)));
      }
    });

    on<_FetchPayWithGoogleStripe>((event, emit) async {
      try {
        emit(const _Preparing());
        final clientSecret = await _stripe.initGoogleStripeSheet(event.data);

        emit(const _Initial());
        await _stripe.presentGoogleStripeSheet(clientSecret);
        
        emit(const _GoogleStripePaymentSuccess());
      } on DioError catch(error){
        emit(_Error(error: AppError.dio(error: error)));
      } on StripeException catch(error) {
        print(error);
        emit(_Error(error: AppError.stripe(error: error)));
      } catch (error) {
        emit(_Error(error: AppOtherError(error: error)));
      }
    });

    on<_FetchPayWithGoogle>((event, emit) async {
      try {
        await _stripe.payWithGoogle(event.data, event.result);
        emit(const _GooglePaymentSuccess());
      } on DioError catch(error){
        emit(_Error(error: AppError.dio(error: error)));
      } on StripeException catch(error) {
        emit(_Error(error: AppError.stripe(error: error)));
      } catch (error) {
        emit(_Error(error: AppOtherError(error: error)));
      }
    });

    on<_FetchSet>((event, emit) => emit(event.state));
  }
}
