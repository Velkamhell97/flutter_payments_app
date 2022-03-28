import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../models/models.dart' show PaymentMethod;

part 'cards_event.dart';
part 'cards_state.dart';

class CardsBloc extends Bloc<CardsEvent, CardsState> {
  CardsBloc() : super(const CardsState()) {
    on<AddPaymentMethodsEvent>((event, emit) {
      emit(state.copyWith(fetching: false, paymentMethods: event.paymentMethods, error: false));
    });

    on<AddPaymentMethodEvent>((event, emit) {
      final paymentMethods = [event.paymentMethod, ...state.paymentMethods];
      emit(state.copyWith(paymentMethods: paymentMethods, error: false));
    });

    on<RemovePaymentMethodEvent>((event, emit) {
      state.paymentMethods.removeWhere((paymentMethod) => paymentMethod.id == event.id);
      emit(state.copyWith(paymentMethods: state.paymentMethods, error: false));
    });

    on<PaymentMethodsErrorEvent>((event, emit) {
      emit(state.copyWith(error: true));
    });
  }
}
