import 'package:flutter_stripe/flutter_stripe.dart';

class FormCreditCard {
  final String number;
  final String brand;
  final String cvv;
  final String expiration;
  final String holder;

  const FormCreditCard({
    this.number = '', 
    this.brand = '', 
    this.cvv = '', 
    this.expiration = '', 
    this.holder = ''
  });

  String _hideNumber() {
    String text = number;
    // String text = number.split(RegExp(r'(?<=^(.{4})+)')).join(' ');

    if (text.length >= 10) {
      //-Forma 1: esconde los numeros intermedios (todos al tiempo)
      // final end = 5 * (text.length ~/ 5) - 1;
      // final substring = text.substring(5, end);
      // final asterisks = substring.replaceAll(RegExp(r"\d"), "*");
      //
      // print('text: $text - sub: $substring - ast: $asterisks');
      // text = text.substring(0, 5) + asterisks + text.substring(end);

      //-Forma 2: Esconde los numeros dejando siempre visible los ultimos 4
      final end = text.length - 4;
      final substring = text.substring(5, end);
      final asterisks = substring.replaceAll(RegExp(r"\d"), "*");

      text = text.substring(0, 5) + asterisks + text.substring(end);
    }

    return text;
  }

  String get hiddenNumber => _hideNumber();
  String get hiddenCvv => cvv.replaceAll(RegExp(r'\d'), '*');

  CardDetails toStripeCard() => CardDetails(
    number: number,
    expirationMonth: int.parse(expiration.split('/').first),
    expirationYear: int.parse(expiration.split('/').last),
    cvc: cvv
  );

  static const List<FormCreditCard> cards = [
    FormCreditCard(
      number: '4242424242424242', 
      brand: 'visa', 
      cvv: '213', 
      expiration: '01/25', 
      holder: 'Fernando Herrera'
    ),
    // CreditCardModel(
    //   number: '5555555555554444', 
    //   brand: 'mastercard', 
    //   cvv: '213', 
    //   expiration: '01/25', 
    //   holder: 'Melissa Flores'
    // ),
    // CreditCardModel(
    //   number: '378282246310005', 
    //   brand: 'amex', 
    //   cvv: '2134', 
    //   expiration: '01/25', 
    //   holder: 'Eduardo Rios'
    // ),
  ];
}
