import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../models/form_credit_card.dart';

class FrontFormCard extends StatelessWidget {
  final FormCreditCard card;
  final bool isFormCard;

  const FrontFormCard({Key? key, required this.card, this.isFormCard = false}) : super(key: key);

  static const _numberStyle = TextStyle(fontSize: 20, fontFamily: 'Halter');
  static const _validStyle = TextStyle(fontSize: 8, fontFamily: 'Halter');
  static const _dateStyle = TextStyle(fontSize: 18, fontFamily: 'Halter');
  static const _holderStyle = TextStyle(fontSize: 18, fontFamily: 'Halter');

  static const _numberHint = 'XXXX XXXX XXXX XXXX';
  static const _brandHint = 'unknown';
  static const _expirationHint = 'MM/YY';
  static const _holderHint = 'CARD HOLDER';

  static final _brands = {
    'unknown': FontAwesomeIcons.creditCard,
    'visa': FontAwesomeIcons.ccVisa,
    'MasterCard' : FontAwesomeIcons.ccMastercard,
    'American Express': FontAwesomeIcons.ccAmex,
  };

  @override
  Widget build(BuildContext context) {
    final number = card.number.isEmpty ? _numberHint : card.hiddenNumber;
    final brand = card.number.isEmpty ? _brandHint : card.brand;
    final expiration = card.expiration.isEmpty ? _expirationHint : card.expiration;
    final holder = card.holder.isEmpty ? _holderHint : card.holder;

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
              child: FaIcon(_brands[brand], size: 40)
            ),
      
            const SizedBox(height: 15.0),
            
            FittedBox(child: Text(number, style: _numberStyle)),
            
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
            
            FittedBox(child: Text(holder, style: _holderStyle)),
          ],
        ),
      ),
    );
  }
}