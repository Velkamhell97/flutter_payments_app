import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_stripe/flutter_stripe.dart' show FailureCode;

import '../blocs/blocs.dart';

class OverlayWidget extends StatefulWidget {

  const OverlayWidget({Key? key}) : super(key: key);

  @override
  State<OverlayWidget> createState() => _OverlayWidgetState();
}

class _OverlayWidgetState extends State<OverlayWidget> {
  final ValueNotifier<bool> _dialogNotifier = ValueNotifier(false);

  static const _animationDuration = Duration(milliseconds: 400);

  void showDialog() {
    _dialogNotifier.value = true;

    Future.delayed(const Duration(seconds: 3), () {
      _dialogNotifier.value = false;
      Future.delayed(_animationDuration, () {
        context.read<FetchBloc>().add(const FetchEvent.set(state: FetchState.initial()));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      top: null,
      bottom: 30,
      child: BlocListener<FetchBloc,FetchState>(
        listener: (context, state) => state.maybeWhen(
          error: (_) => showDialog(),
          cardManualPaymentSuccess: showDialog,
          paymentMethodSaved: (_) => showDialog(),
          orElse: () => null,
        ),
        child: ValueListenableBuilder<bool>(
          valueListenable: _dialogNotifier,
          builder: (_, value, __) => _OverlayDialog(show: value),
        ),
      ),
    );
  }
}

class _OverlayDialog extends StatelessWidget {
  final bool show;

  const _OverlayDialog({Key? key, required this.show}) : super(key: key);

  static const _animationDuration = Duration(milliseconds: 400);

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: _animationDuration,
      
      transitionBuilder: (child, animation) {
        return FadeTransition(
          opacity: animation,
          child: SlideTransition(
            position: Tween(begin: const Offset(0.0, 2.0), end: const Offset(0, 0)).animate(animation),
            child: child,
          ),
        );
      },
      
      child: show ? Material(
        elevation: 3,
        color: const Color(0xff284879),
        borderRadius: BorderRadius.circular(10.0),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
          child: BlocBuilder<FetchBloc, FetchState>(
            builder: (_, state) => state.maybeWhen<Widget>(
              error: (error) {
                final errorText = error.when(
                  other: (e) => 'There was an error ${e.toString()}', 
                  dio: (e) => 'There was an fetch error: ${e.response}',
                  stripe: (e) {
                    if(e.error.code == FailureCode.Canceled) return 'Payment Canceled';
                    return 'There was an stripe error: ${e.error.message}';
                  },
                );
      
                return Text(errorText);
              },

              stripePaymentSuccess: () => const Text('Payment Stripe Sucesfully'),
              cardPaymentSuccess: () => const Text('Payment Card Sucesfully'),
              cardManualPaymentSuccess: () => const Text('Payment Card Manual Sucesfully'),
              cardTokenPaymentSuccess: () => const Text('Payment Card Token Sucesfully'),
              paymentMethodSaved: (_) => const Text('Card Saved Sucesfully'),
              
              orElse: () => const SizedBox.shrink()
            ),
          )
        ),
      ) : const SizedBox.shrink(),
    );
  }
}