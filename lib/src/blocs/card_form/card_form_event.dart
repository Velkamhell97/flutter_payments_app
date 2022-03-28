part of 'card_form_bloc.dart';

abstract class CardFormEvent extends Equatable {
  const CardFormEvent();

  @override
  List<Object> get props => [];
}

class FormChangeEvent extends CardFormEvent {
  final String? number;
  final String? expiration;
  final String? cvv;
  final String? holder;

  const FormChangeEvent({this.number, this.expiration, this.cvv, this.holder}); 
}
