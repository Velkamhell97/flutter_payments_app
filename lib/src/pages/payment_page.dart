import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_stripe/flutter_stripe.dart' hide PaymentMethod;
import 'package:pay/pay.dart' as pay;

import '../blocs/blocs.dart';
import '../global/global.dart';
import '../models/models.dart' show PaymentMethod;
import '../widgets/widgets.dart';

class PaymentPage extends StatelessWidget {
  final PaymentMethod paymentMethod;

  const PaymentPage({Key? key, required this.paymentMethod}) : super(key: key);

  // void _pay(BuildContext context) {
  //   final payment = context.read<PaymentBloc>();
  //   final card = paymentMethod.card
  //
  //   context.read<FetchBloc>().add(FetchEvent.payWithCard(
  //     data: {
  //       'email': 'danielvalencia97@gmail.com', 
  //       'amount': payment.state.formatAmount, 
  //       'currency': payment.state.currency
  //     },
  //     cardDetails: card.toStripeCard())
  //   );
  // }

  //El unico metodo seguro para pagar con una tarjeta existente, ya que si se paga sobreescribiendo los datos
  //o tokenizando una tarjeta, se debe almacenar el modelo de estas tarjetas con todos sus datos sensibles
  //por esta razon lo mejor es utilizar los metodos de pago que identifican las tarjetas con el id, de esta
  //manera se pueden almacenar los metodos de pago y no las tarjetas y hacer pagos con este
  void _payManual(BuildContext context) {
    final payment = context.read<PaymentBloc>();

    context.read<FetchBloc>().add(FetchEvent.payWithMethodManual(
      data: {
        'email': 'danielvalencia97@gmail.com', 
        'amount': payment.state.formatAmount, 
        'currency': payment.state.currency
      },
      paymentMethodId: paymentMethod.id
    ));
  }

  // void _payToken(BuildContext context) {
  //   final payment = context.read<PaymentBloc>();
  //
  //   context.read<FetchBloc>().add(FetchEvent.payWithCardToken(
  //     data: {
  //       'email': 'danielvalencia97@gmail.com', 
  //       'amount': payment.state.formatAmount, 
  //       'currency': payment.state.currency
  //     },
  //     cardDetails: card.toStripeCard())
  //   );
  // }

  Future<void> _payGoogleStripe(BuildContext context) async {
    final googlePaySupported = await Stripe.instance.isGooglePaySupported(const IsGooglePaySupportedParams());
  
    if(googlePaySupported){
      final payment = context.read<PaymentBloc>();
  
      context.read<FetchBloc>().add(FetchEvent.payWithGoogleStripe(
        data: {
          'email': 'danielvalencia97@gmail.com', 
          'amount': payment.state.formatAmount, 
          'currency': payment.state.currency
        },
      ));
    } else {
      Notifications.showSnackBar('You device dont support google pay');
    }
  }

  List<pay.PaymentItem> _getPaymentItems (BuildContext context) {
    final payment = context.read<PaymentBloc>();

    return [
      pay.PaymentItem(
        amount: payment.state.amount.toString(),
        // amount: '1.00',
        label: 'Total',
        status: pay.PaymentItemStatus.final_price,
      )
    ];
  }

  void _onGooglePlayResult(BuildContext context, Map<String, dynamic> result) async {
    context.read<FetchBloc>().add(FetchEvent.payWithGoogle(
      data: {'email': 'danielvalencia97@gmail.com'},
      result: result
    ));
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return BlocConsumer<FetchBloc, FetchState>(
      listener: (context, state) => state.maybeWhen(
        cardManualPaymentSuccess: () {
          return Future.delayed(const Duration(milliseconds: 300), () {
            Navigator.of(context).pushNamedAndRemoveUntil(
              'success',
              (route) => route.settings.name == 'home'
            );
          });
        },
        orElse: () => null
      ),
      builder: (context, state) {
        final loading = state.maybeWhen(
          loading: () => true,
          orElse: () => false,
        );

        return WillPopScope(
          onWillPop: () async {
            context.read<PaymentBloc>().add(CardUnselectedEvent());
            return !loading;
          },
          child: Scaffold(
            appBar: AppBar(
              title: const Text('Edit Card'),
              actions: [
                IconButton(splashRadius: 25, 
                onPressed: () {}, 
                icon: const Icon(Icons.edit))
              ],
            ),
            body: Stack(
              fit: StackFit.expand,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
                  child: Column(
                    children: [
                      ConstrainedBox(
                        //-Lo adapta al tamaño del widget si es mas grande (no pasa con el sizedBox)
                        constraints: BoxConstraints(
                          minWidth: double.infinity,
                          minHeight: size.height * 0.27
                        ),
                        child: Hero(
                          tag: paymentMethod.id,
                          child: CreditCardWidget(
                            frontWidget: FrontCard(paymentMethod: paymentMethod),
                            backWidget: BackCard(paymentMethod: paymentMethod),
                          ),
                        ),
                      ),
                      
                      const SizedBox(height: 15.0),
                      
                      FractionallySizedBox(
                        alignment: Alignment.center,
                        widthFactor: 0.5,
                        // child: LoadingButton(onPress: () => _pay(context), text: 'Pay'),
                        child: LoadingButton(onPress: () => _payManual(context), text: 'Pay Manual'),
                        // child: LoadingButton(onPress: () => _payToken(context), text: 'Pay Token'),
                      ),
                
                      const SizedBox(height: 15.0),
                
                      FractionallySizedBox( //-> Se debe probar con tarjeta real y no funciono
                        alignment: Alignment.center,
                        widthFactor: 0.5,
                        child: pay.GooglePayButton(
                          height: size.height * 0.06,
                          style: pay.GooglePayButtonStyle.black,
                          paymentConfigurationAsset: 'google_pay_payment_profile.json',
                          paymentItems: _getPaymentItems(context),
                          loadingIndicator: const Center(child: CircularProgressIndicator()),
                          onPaymentResult: (result) => _onGooglePlayResult(context, result),
                        ),
                      ),

                      const SizedBox(height: 15.0),
                
                      FractionallySizedBox(
                        alignment: Alignment.center,
                        widthFactor: 0.5,
                        child: SizedBox(
                          height: size.height * 0.06,
                          child: GooglePayButton(
                            onTap: () => _payGoogleStripe(context)
                          ),
                        ),
                      )
                    ],
                  ),
                ),

                const Positioned.fill(
                  top: null,
                  child: PucharseSheet(),
                ),

                const LoadingOverlay()
              ],
            ),
          ),
        );
      },
    );
  }
}
