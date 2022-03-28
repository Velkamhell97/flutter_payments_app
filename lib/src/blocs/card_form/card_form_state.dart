part of 'card_form_bloc.dart';

//-Seria mucho mas practico hacer esto con un provider
class CardFormState extends Equatable {
  final String number;
  final String brand;
  final String expiration;
  final String cvv;
  final String holder;

  const CardFormState({
    this.number = '', 
    this.brand = '',
    this.expiration = '',
    this.cvv = '', 
    this.holder = '',
  });

  CardDetails toStripeCard() => CardDetails(
    number: number.split(' ').join(''),
    expirationMonth: int.parse(expiration.split('/').first),
    expirationYear: int.parse(expiration.split('/').last),
    cvc: cvv
  );

  factory CardFormState.fromModel(FormCreditCard? card){
    if(card == null){
      return const CardFormState();
    }

    return  CardFormState(
      number: card.number,
      brand: card.brand,
      cvv: card.expiration,
      expiration: card.expiration,
      holder: card.holder
    );
  }

  FormCreditCard toModelCard() => FormCreditCard(
    number: number,
    brand: brand,
    expiration: expiration,
    cvv: cvv,
    holder: holder
  );
  
  CardFormState copyWith({String? number, String? expiration, String? cvv, String? holder}){
    return CardFormState(
      number: number ?? this.number,
      brand: number == null ? brand : detectCCType(number).name,
      expiration: expiration ?? this.expiration,
      cvv: cvv ?? this.cvv,
      holder: holder ?? this.holder,
    );
  }
  
  @override
  List<Object> get props => [number, expiration, cvv, holder];
}

