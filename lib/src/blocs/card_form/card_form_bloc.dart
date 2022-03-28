import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:credit_card_type_detector/credit_card_type_detector.dart';
import 'package:flutter_stripe/flutter_stripe.dart' show CardDetails;

import '../../models/models.dart';
import '../../widgets/widgets.dart';

part 'card_form_event.dart';
part 'card_form_state.dart';

class CardFormBloc extends Bloc<CardFormEvent, CardFormState> {
  // ignore: unused_field
  final FormCreditCard? _card; //Solo se necesita para inicializar
  
  final cardKey = GlobalKey<CreditCardWidgetState>();
  final formKey = GlobalKey<FormState>();

  CardFormBloc([this._card]) : super(CardFormState.fromModel(_card)) {
    on<FormChangeEvent>((event, emit) {
      emit(state.copyWith(
        number: event.number,
        expiration: event.expiration,
        cvv: event.cvv,
        holder: event.holder
      ));
    });
  }

  Future<bool> validate() async {
    return formKey.currentState!.validate();
  }
}
