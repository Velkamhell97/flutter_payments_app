import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/blocs.dart';
import '../models/models.dart' show PaymentMethod;
import '../widgets/widgets.dart';
import '../pages/pages.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final PageController _pageController;

  //-Por si se quisiera hacer un nestedNavigation para el persistenAppBar
  // final _navigatorKey = GlobalKey<NavigatorState>();

  @override
  void initState() {
    super.initState();

    //-Tambien se hubiera podido colocar en el constructor del fetch bloc
    context.read<FetchBloc>().add(const FetchEvent.getPaymentMethods(email: 'danielvalencia97@gmail.com'));

    _pageController = PageController(viewportFraction: 0.85);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Future<void> _navigate(PaymentMethod paymentMethod) async {
    context.read<PaymentBloc>().add(CardSelectedEvent(paymentMethod));

    Navigator.of(context).push(PageRouteBuilder(
      pageBuilder: (context, animation, _) {
        return FadeTransition(
          opacity: animation,
          child: PaymentPage(paymentMethod: paymentMethod),
        );
      },
    ));
  }

  Future<void> _payWithStripe() async {
    final payment = context.read<PaymentBloc>().state;

    context.read<FetchBloc>().add(FetchEvent.payWithStripe(data: {
      'email': 'danielvalencia97@gmail.com',
      'amount': payment.formatAmount,
      'currency': payment.currency
    }));
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return BlocListener<FetchBloc, FetchState>(
      listener: (context, state) => state.maybeWhen(
        paymentMethodsObtained: (cards) => context.read<CardsBloc>().add(AddPaymentMethodsEvent(cards)),
        error: (e) => e.maybeWhen(
          dio: (_) => context.read<CardsBloc>().add(PaymentMethodsErrorEvent()), 
          orElse: () => null
        ),
        orElse: () => null
      ),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Payment'),
          actions: [
            IconButton(
              splashRadius: 25, 
              onPressed: () => Navigator.of(context).pushNamed('add-card'), 
              icon: const Icon(Icons.add)
            ),
            IconButton(
              splashRadius: 25, 
              onPressed: _payWithStripe, 
              icon: const Icon(Icons.credit_card)
            ),
          ],
        ),

        body: Stack(
          fit: StackFit.expand,
          children: [
            BlocBuilder<CardsBloc, CardsState>(
              builder: (context, state) {
                if(state.fetching) return const LoadingOverlay();

                if(state.error) return const Center(child: Text('Error'));

                final paymentMethods = state.paymentMethods;
  
                return PageView.builder(
                  controller: _pageController,
                  physics: const BouncingScrollPhysics(),
                  itemCount: paymentMethods.length,
                  itemBuilder: (_, index) {
                    final paymentMethod = paymentMethods[index];
                    final last = index == paymentMethods.length - 1;
  
                    return Center(
                      child: Padding(
                        padding: EdgeInsets.only(right: last ? 0 : 20),
                        child: GestureDetector(
                          onTap: () => _navigate(paymentMethod),
                          child: ConstrainedBox(
                            //-Lo adapta al tamaño del widget is es mas grande
                            constraints: BoxConstraints(
                              minWidth: double.infinity,
                              minHeight: size.height * 0.27
                            ),
                            child: Hero(
                              tag: paymentMethod.id,
                              child: CreditCardWidget(
                                clickable: false,
                                frontWidget: FrontCard(paymentMethod: paymentMethod),
                                backWidget: BackCard(paymentMethod: paymentMethod),
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
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
  }
}

