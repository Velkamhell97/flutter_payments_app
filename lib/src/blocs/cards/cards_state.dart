part of 'cards_bloc.dart';

class CardsState extends Equatable {
  final bool fetching;
  final List<PaymentMethod> paymentMethods;
  final bool error;

  const CardsState({this.fetching = true, this.paymentMethods = const [], this.error = false});

  CardsState copyWith({bool? fetching, List<PaymentMethod>? paymentMethods, bool? error}) => CardsState(
    fetching: fetching ?? this.fetching,
    paymentMethods: paymentMethods ?? this.paymentMethods,
    error: error ?? this.error
  );
  
  @override
  List<Object> get props => [fetching, paymentMethods, error];
}

