import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:io';

import '../blocs/blocs.dart';
import '../global/global.dart';


class PucharseSheet extends StatelessWidget {
  const PucharseSheet({Key? key}) : super(key: key);

  static const _style1 = TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18);
  static const _style2 = TextStyle(color: Colors.black);

  static final _icon = {
    PayMethod.system: Platform.isAndroid ? FontAwesomeIcons.google : FontAwesomeIcons.apple,
    PayMethod.card: FontAwesomeIcons.creditCard
  };

  static final _text = {
    PayMethod.system: 'Pay', 
    PayMethod.card: 'Card'
  };

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PaymentBloc, PaymentState>(
      builder: (context, state) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white, 
            borderRadius: BorderRadius.vertical(top: Radius.circular(30.0))
          ),
          padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text('Total', style: _style1),
                  Text('250.55 USD', style: _style2),
                ],
              ),
              
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: Colors.black,
                    fixedSize: const Size.fromWidth(120),
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    shape: const StadiumBorder()),
                onPressed: () => Notifications.showLoadingDialog(),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FaIcon(_icon[state.method]), 
                    const SizedBox(width: 10.0), 
                    Text(_text[state.method]!)
                  ],
                ))
            ],
          ),
        );
      },
    );
  }
}
