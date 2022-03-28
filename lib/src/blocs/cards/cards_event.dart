part of 'cards_bloc.dart';

abstract class CardsEvent extends Equatable {
  const CardsEvent();

  @override
  List<Object> get props => [];
}

class AddPaymentMethodsEvent extends CardsEvent {
  final List<PaymentMethod> paymentMethods;
  const AddPaymentMethodsEvent(this.paymentMethods);
}

class AddPaymentMethodEvent extends CardsEvent {
  final PaymentMethod paymentMethod;
  const AddPaymentMethodEvent(this.paymentMethod);
}

class PaymentMethodsErrorEvent extends CardsEvent {}

class RemovePaymentMethodEvent extends CardsEvent {
  final String id;
  const RemovePaymentMethodEvent(this.id);
}
