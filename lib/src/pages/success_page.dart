import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SuccessPage extends StatelessWidget {
  const SuccessPage({Key? key}) : super(key: key);

  static const _style = TextStyle(fontSize: 20);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment Successful'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const[
            FaIcon(FontAwesomeIcons.star, color: Colors.white54, size: 100),
            SizedBox(height: 20.0),
            Text('Payment Successful', style: _style)
          ],
        ),
      ),
    );
  }
}