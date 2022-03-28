part of 'payment_bloc.dart';

//-Cuando se utiliza este tipo de logica generlmente se inicializan todas las variables para tener un estado inicial
class PaymentState extends Equatable {
  final double amount;
  final String currency;
  final PayMethod method;
  final PaymentMethod? card;

  const PaymentState({
    this.amount = 250.55, 
    this.currency = 'usd', 
    this.method = PayMethod.system, 
    this.card
  });

  int get formatAmount => (amount * 100).floor();

  PaymentState copyWith({
    double? amount, 
    String? currency, 
    PayMethod? method, 
    PaymentMethod? card, 
    bool clear = false
  }) => PaymentState(
    amount: amount ?? this.amount,
    currency: currency ?? this.currency,
    method: method ?? this.method,
    card: clear ? null : card ?? this.card
  );
  
  @override
  List<Object?> get props => [amount, currency, method, card];
}

