import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../models/models.dart' show PaymentMethod;

class FrontCard extends StatelessWidget {
  final PaymentMethod paymentMethod;

  const FrontCard({Key? key, required this.paymentMethod}) : super(key: key);

  static const _numberStyle = TextStyle(fontSize: 20, fontFamily: 'Halter');
  static const _validStyle = TextStyle(fontSize: 8, fontFamily: 'Halter');
  static const _dateStyle = TextStyle(fontSize: 18, fontFamily: 'Halter');
  static const _holderStyle = TextStyle(fontSize: 18, fontFamily: 'Halter');

  static final _brands = {
    'unknown': FontAwesomeIcons.creditCard,
    'visa': FontAwesomeIcons.ccVisa,
    'mastercard' : FontAwesomeIcons.ccMastercard,
    'amex': FontAwesomeIcons.ccAmex,
  };

  @override
  Widget build(BuildContext context) {
    final card = paymentMethod.card!;

    final number = card.last4;
    final expiration = '${(card.expMonth).toString().padLeft(2,'0')}/${card.expYear}';
    final holder = paymentMethod.billingDetails.name ?? 'XXXXX XXXXX';

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        gradient: const LinearGradient(
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
          colors: [
            Color(0xff2B5876),
            Color(0xff4E4376)
          ]
        )
      ),
      padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
      child: Material( //- Para la transicion del hero
        type: MaterialType.transparency,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: FaIcon(_brands[card.brand], size: 40)
            ),
      
            const SizedBox(height: 15.0),
            
            Text(number, style: _numberStyle),
            
            const SizedBox(height: 15.0),
            
            Row(
              children: [
                Column(
                  children: const [
                    Text('VALID', style: _validStyle),
                    Text('THRU', style: _validStyle),
                  ],
                ),
                const SizedBox(width: 10.0),
                Text(expiration, style: _dateStyle)
              ],
            ),
      
            const SizedBox(height: 15.0),
            
            Flexible(child: FittedBox(child: Text(holder, style: _holderStyle))),
          ],
        ),
      ),
    );
  }
}