part of 'payment_bloc.dart';

abstract class PaymentEvent extends Equatable {
  const PaymentEvent();

  @override
  List<Object> get props => [];
}

class CardSelectedEvent extends PaymentEvent {
  final PaymentMethod? card;
  const CardSelectedEvent(this.card);
}

class CardUnselectedEvent extends PaymentEvent {}