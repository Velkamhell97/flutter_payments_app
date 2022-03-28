import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../models/models.dart' show PaymentMethod;

part 'payment_event.dart';
part 'payment_state.dart';

enum PayMethod { system, card }

class PaymentBloc extends Bloc<PaymentEvent, PaymentState> {

  PaymentBloc() : super(const PaymentState()) {
    on<CardSelectedEvent>((event, emit) {
      emit(state.copyWith(method: PayMethod.card, card: event.card));
    });

    on<CardUnselectedEvent>((event, emit) {
      emit(state.copyWith(method: PayMethod.system, clear: true));
    });
  }
}
