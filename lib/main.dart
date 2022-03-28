import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

import 'src/blocs/blocs.dart';
import 'src/themes/themes.dart';
import 'src/pages/pages.dart';
import 'src/services/services.dart';
import 'src/global/global.dart';
import 'src/widgets/widgets.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: Environment.getFileName(Env.DEV));

  Stripe.publishableKey = dotenv.env['STRIPE_PUBLISHABLE_KEY']!;
  await Stripe.instance.applySettings();

  timeDilation = 1.0;

  runApp(const AppState());
}

class AppState extends StatelessWidget {
  const AppState({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => StripeService(),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => PaymentBloc()),
          BlocProvider(create: (_) => CardsBloc()),
          BlocProvider(create: (context) => FetchBloc(context.read<StripeService>()) )
        ],
        child: const MyApp()
      )
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      navigatorKey: Notifications.navigatorKey,
      scaffoldMessengerKey: Notifications.messengerKey,
      debugShowCheckedModeBanner: false,
      theme: appTheme,
      localizationsDelegates: const [
        GlobalWidgetsLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
      ],
      builder: (context, child) {
        return Stack(
          children: [
            child!,
            const OverlayWidget()
          ],
        );
      },
      initialRoute: 'home',
      routes: {
        'home': (_) => const HomePage(),
        'add-card': (_) => const AddCardPage(),
        'success': (_) => const SuccessPage()
      },
    );
  }
}

