part of 'fetch_bloc.dart';

@freezed
class FetchEvent with _$FetchEvent {
  const factory FetchEvent.payWithStripe({required Map<String, dynamic> data}) = _FetchPayWithStripe;
  
  const factory FetchEvent.getPaymentMethods({required String email}) = _FetchGetPaymentMethods;

  const factory FetchEvent.savePaymentMethod({
    required Map<String, dynamic> data, 
    required CardDetails cardDetails
  }) = _FetchSavePaymentMethod;

  const factory FetchEvent.payWithCard({
    required Map<String, dynamic> data,
    required CardDetails cardDetails
  }) = _FetchPayWithCard;

  const factory FetchEvent.payWithCardManual({
    required Map<String, dynamic> data,
    required CardDetails cardDetails
  }) = _FetchPayWithCardManual;

  const factory FetchEvent.payWithMethodManual({
    required Map<String, dynamic> data,
    required String paymentMethodId
  }) = _FetchPayWithMethodManual;

  const factory FetchEvent.payWithCardToken({
    required Map<String, dynamic> data,
    required CardDetails cardDetails
  }) = _FetchPayWithCardToken;

  const factory FetchEvent.payWithGoogleStripe({required Map<String, dynamic> data}) = _FetchPayWithGoogleStripe;
  const factory FetchEvent.payWithGoogle({
    required Map<String, dynamic> data,
    required Map<String, dynamic> result
  }) = _FetchPayWithGoogle;

  const factory FetchEvent.set({required FetchState state}) = _FetchSet;
}