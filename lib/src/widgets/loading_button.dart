import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/blocs.dart';

class LoadingButton extends StatelessWidget {
  final VoidCallback onPress;
  final String text;

  const LoadingButton({Key? key, required this.onPress, required this.text}) : super(key: key);

  static const _buttonStyle = TextStyle(fontSize: 16, fontWeight: FontWeight.bold);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FetchBloc, FetchState>(
      builder: (context, state) {
        final loading = state.maybeWhen(
          loading: () => true,
          orElse: () => false,
        );

        return ElevatedButton(
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            primary: const Color(0xff284879),
          ),
          onPressed: loading ? null : onPress,
          child: SizedBox(
            height: 30,
            child: AnimatedSwitcher( //-por alguna razon centra el texto
              duration: const Duration(milliseconds: 400),
              child: state.maybeWhen(
                initial: () => Text(text, style: _buttonStyle),
                paymentMethodSaved: (_) => const Icon(Icons.check_circle_outline_outlined, size: 30,),
                cardPaymentSuccess: () => const Icon(Icons.check_circle_outline_outlined, size: 30),
                cardManualPaymentSuccess: () => const Icon(Icons.check_circle_outline_outlined, size: 30),
                loading: () => const SizedBox.square(
                  dimension: 30.0,
                  child: CircularProgressIndicator(color: Colors.white, strokeWidth: 3)
                ),
                orElse: () => Text(text, style: _buttonStyle)
              )
            ),
          ),
        );
      },
    );
  }
}