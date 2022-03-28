import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../models/form_credit_card.dart';

class BackFormCard extends StatelessWidget {
  final FormCreditCard card;

  const BackFormCard({Key? key, required this.card}) : super(key: key);

  static final _brands = {
    'unknown': FontAwesomeIcons.creditCard,
    'visa': FontAwesomeIcons.ccVisa,
    'mastercard' : FontAwesomeIcons.ccMastercard,
    'amex': FontAwesomeIcons.ccAmex,
  };

  static const _cvvStyle = TextStyle(fontSize: 18, color: Colors.black, fontFamily: 'Halter');

  static const _cvvHint = 'XXX';
  static const _brandHint = 'unknown';

  @override
  Widget build(BuildContext context) {
    final cvv = card.cvv.isEmpty ? _cvvHint : card.hiddenCvv;
    final brand = card.brand.isEmpty ? _brandHint : card.brand;

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
      padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 0.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 50,
            color: Colors.black,
          ),

          const SizedBox(height: 15.0),
          
          Row(
            children: [
              Expanded(
                flex: 4,
                child: Container(
                  height: 40,
                  color: const Color.fromARGB(255, 34, 60, 100)),
              ),
              Expanded(
                child: Container(
                  height: 30,
                  alignment: const Alignment(-0.9, 0.8),
                  color: Colors.white,
                  child: FittedBox(child: Text(cvv, style: _cvvStyle)),
                ),
              )
            ],
          ),

          const SizedBox(height: 15.0),

          Align(
            alignment: const Alignment(0.9, 0.0),
            child: FaIcon(_brands[brand], size: 40),
          )
        ],
      ),
    );
  }
}