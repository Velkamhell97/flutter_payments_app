import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/blocs.dart';

class LoadingOverlay extends StatelessWidget {
  const LoadingOverlay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FetchBloc, FetchState>(//Loading del PaymentSheet
      builder: (context, state) => state.maybeWhen(
        preparing: () => const DecoratedBox(
          decoration: BoxDecoration(color: Colors.black38),
          child: Center(child: CircularProgressIndicator(color: Colors.white)),
        ),

        orElse: () => const SizedBox.shrink()
      ),
    );
  }
}