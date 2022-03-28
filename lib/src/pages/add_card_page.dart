import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/blocs.dart';
import '../forms/forms.dart';
import '../widgets/widgets.dart';

class AddCardPage extends StatelessWidget {
  const AddCardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return BlocConsumer<FetchBloc, FetchState>(
      listener: (context, state) => state.maybeWhen(
        // return Notifications.showSnackBar('Card Saved Successfully!');
        paymentMethodSaved: (card) {
          context.read<CardsBloc>().add(AddPaymentMethodEvent(card));
          return Future.delayed(const Duration(milliseconds: 200), () => Navigator.of(context).maybePop());
        },
        orElse: () => null
      ),
      builder: (context, state) {
        final loading = state.maybeWhen(
          loading: () => true,
          orElse: () => false,
        );

        return WillPopScope(
          onWillPop: () async => !loading,
          child: Scaffold(
            appBar: AppBar(
              title: const Text('Add Card'),
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: loading ? null : () => Navigator.of(context).maybePop(),
              ),
            ),

            body: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
              child: BlocProvider<CardFormBloc>(
                create: (_) => CardFormBloc(),
                child: BlocBuilder<CardFormBloc, CardFormState>(
                  builder: (context, state) {
                    return Column(
                      children: [
                        ConstrainedBox(
                          constraints: BoxConstraints(
                            minWidth: double.infinity,
                            minHeight: size.height * 0.27
                          ),
                          child: CreditCardWidget(
                            key: context.read<CardFormBloc>().cardKey,
                            clickable: false,
                            frontWidget: FrontFormCard(card: state.toModelCard()),
                            backWidget: BackFormCard(card: state.toModelCard()),
                          ),
                        ),
      
                        const SizedBox(height: 20.0),
      
                        const CardForm() //-No se redibuja por ser const, tampoco se necesita (solo el boton)
                      ],
                    );
                  },
                ),
              ),
            ),
          ),
        );
      }, 
    );
  }
}