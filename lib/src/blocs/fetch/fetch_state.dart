part of 'fetch_bloc.dart';

@freezed
class FetchState with _$FetchState {
  const factory FetchState.initial() = _Initial;

  const factory FetchState.loading() = _Loading;
  const factory FetchState.preparing() = _Preparing;
  
  const factory FetchState.error({required AppError error}) = _Error;

  const factory FetchState.paymentMethodsObtained({
    required List<PaymentMethod> paymentMethods
  }) = PaymentMethodsObtained;

  const factory FetchState.paymentMethodSaved({
    required PaymentMethod paymentMethod
  }) = _PaymentMethodSaved;
  
  const factory FetchState.cardPaymentSuccess() = _CardPaymentSuccess;
  const factory FetchState.cardManualPaymentSuccess() = _CardManualPaymentSuccess;
  const factory FetchState.cardTokenPaymentSuccess() = _CardTokenPaymentSuccess;

  const factory FetchState.stripePaymentSuccess() = _StripePaymentSuccess;
  const factory FetchState.googleStripePaymentSuccess() = _GoogleStripePaymentSuccess;
  const factory FetchState.googlePaymentSuccess() = _GooglePaymentSuccess;
}
