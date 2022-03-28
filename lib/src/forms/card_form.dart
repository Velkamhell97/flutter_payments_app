import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/widgets.dart';
import '../blocs/blocs.dart';

class CardForm extends StatefulWidget {
  const CardForm({Key? key}) : super(key: key);

  @override
  State<CardForm> createState() => _CardFormState();
}

class _CardFormState extends State<CardForm> {
  late final CardFormBloc form;

  // final _dateController = TextEditingController();
  final _cvvFocus = FocusNode();

  @override
  void initState() {
    super.initState();

    form = BlocProvider.of<CardFormBloc>(context);
    _cvvFocus.addListener(() => form.cardKey.currentState!.flip());
  }

  @override
  void dispose() {
    // _dateController.dispose();
    _cvvFocus.dispose();

    super.dispose();
  }

  // Future<void> _showPicker() async { //-No se hizo con un picker
  //   //-Sirvio mas el otro paquete
  //   // return await showMonthYearPicker(
  //   //   context: context, 
  //   //   initialDate: DateTime.now(), 
  //   //   firstDate: DateTime.now(), 
  //   //   lastDate: DateTime(DateTime.now().year + 10)
  //   // );
  //
  //   final expiration = await showMonthPicker(
  //     context: context, 
  //     initialDate: DateTime.now(), 
  //     firstDate: DateTime.now(), 
  //     lastDate: DateTime(DateTime.now().year + 10)
  //   );
  //
  //   if(expiration != null){
  //     final month = expiration.month.toString().padLeft(2,'0');
  //     final year = expiration.year.toString().substring(2);
  //
  //     _dateController.text = "$month/$year";
  //     form.add(FormChangeEvent(expiration: _dateController.text));
  //   }
  // }

  static final _countries = ['Colombia', 'Venezuela', 'Mexico', 'Argentina'];

  Future<void> _saveCard() async {
    final validate = await form.validate();

    if(validate){
      context.read<FetchBloc>().add(FetchEvent.savePaymentMethod(
        data: {
          'email' : 'danielvalencia97@gmail.com', 
          'holder': form.state.holder
        }, 
        cardDetails: form.state.toStripeCard()
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: form.formKey,
      child: Column(
        children: [

          const SizedBox(height: 15.0),

          //---------------------------------
          // Number Textfield
          //---------------------------------
          TextFormField(
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: 'Card Number',
              counterText: ""
            ),
            maxLength: 19,
            inputFormatters: [CardNumberFormatter()],
            onChanged: (value)  {
              form.add(FormChangeEvent(number: value));
              if(value.length == 19) FocusScope.of(context).nextFocus();
            },
            validator: (v) => (v ?? '').length >= 14 ? null  : 'Invalid Credit Card',
          ),

          const SizedBox(height: 15.0),

          //---------------------------------
          // Expirate date & CVV Textfield
          //---------------------------------
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Expire Date',
                    counterText: ""
                  ),
                  inputFormatters: [ExpirationDateFormatter()],
                  maxLength: 5,
                  onChanged: (value) {
                    form.add(FormChangeEvent(expiration: value));
                    if(value.length == 5) FocusScope.of(context).nextFocus();
                  },
                  validator: (v) {
                    if((v ?? '').isEmpty) return "Invalid expiration date";

                    final month = int.parse(v!.split('/')[0]) ;
                    final year = int.parse(v.split('/')[1]);

                    final actualYear = DateTime.now().year;

                    if(month > 12) return "The mont must be a number between 0 and 12";
                    if(actualYear <= year) return "The year must be higher that present year";

                    return null;
                  },
                ),
              ),

              const SizedBox(width: 15.0),
              
              Expanded(
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  focusNode: _cvvFocus,
                  decoration: const InputDecoration(
                    labelText: 'CVV',
                    counterText: "" //-Oculta el texto, pero queda el espacio
                  ),
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  maxLength: 3,
                  onChanged: (value) {
                    form.add(FormChangeEvent(cvv: value));
                    if(value.length == 3) FocusScope.of(context).nextFocus();
                  },
                  validator: (v) => (v ?? '').length == 3 ? null  : 'Invalid CVV',
                ),
              )
            ],
          ),
          
          const SizedBox(height: 15.0),

          //---------------------------------
          // Holder Textfield
          //---------------------------------
          TextFormField(
            keyboardType: TextInputType.name,
            textCapitalization: TextCapitalization.characters,
            decoration: const InputDecoration(labelText: 'Holder Name'),
            onChanged: (value) => form.add(FormChangeEvent(holder: value.toUpperCase())),
            validator: (v) => (v ?? '').length >= 5 ? null  : 'Enter valid holder name'
          ),

          const SizedBox(height: 15.0),
          
          //---------------------------------
          // Country Textfield
          //---------------------------------
          //-Solo ilustrativo, se podria usar un overlay para que salga debajo del input, ademas de esto
          //-cuenta con la ventaja de poder implementar un loading
          DropdownButtonFormField<String>(
            isDense: true,
            hint: const Text('Country'),
            items: _countries.map((c) {
              return DropdownMenuItem<String>(child: Text(c), value: c);
            }).toList(), 
            onChanged: (value) {}
          ),        

          const SizedBox(height: 20.0),

          //---------------------------------
          // Save Button
          //---------------------------------
          FractionallySizedBox(
            alignment: Alignment.center,
            widthFactor: 0.5,
            child: LoadingButton(onPress: _saveCard, text: 'Save Card',),
          )
        ],
      ),
    );
  }
}

class CardNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    final cur = newValue.text; //current
    final acc = oldValue.text; //accum

    if(cur.isEmpty){ //-validacion de empty
      return newValue.copyWith(text: cur);
    }

    if(int.tryParse(cur.replaceAll(' ', '')) == null){ //validacion de digits
      return newValue.copyWith(
        text: acc,
        selection: TextSelection.collapsed(offset: acc.length)
      );
    }

    String text = '';
    
    if(cur.length > acc.length){
      final space = (cur.length % 5 == 0) ? ' ' : '';
      text = acc + space + cur.characters.last;
    } else {
      final index = cur.isNotEmpty && cur.characters.last == ' ' ? 1 : 0;
      text = cur.substring(0, cur.length - index);
    }

    // String text = cur.split(RegExp(r'(?<=^(.{4})+)')).join(' '); //no funciono

    return newValue.copyWith(
      text: text,
      selection: TextSelection.collapsed(offset: text.length)
    );
  }
}

class ExpirationDateFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    final cur = newValue.text; //current
    final acc = oldValue.text; //accum

    if(cur.isEmpty){ //-validacion de empty
      return newValue.copyWith(text: cur);
    }

    if(int.tryParse(cur.replaceAll('/', '')) == null){ //validacion de digits
      return newValue.copyWith(
        text: acc,
        selection: TextSelection.collapsed(offset: acc.length)
      );
    }

    String text = cur;

    if(cur.length > acc.length){
      if(cur.length == 1 && cur[0].contains(RegExp(r'[2-9]'))){
        text = '0' + cur[0];
      }

      if(text.length == 2) {
        text = text + '/';
      }
    } else {
      final index = cur.isNotEmpty && cur.characters.last == ' ' ? 1 : 0;
      text = cur.substring(0, cur.length - index);

      if(text.length == 2){
        text = '';
      }
    }

    return newValue.copyWith(
      text: text,
      selection: TextSelection.collapsed(offset: text.length)
    );
  }
}

/** //bloquea cada 4 digitos
 *  final cur = newValue.text; //current
    final acc = oldValue.text; //accum

    // final factor1 = cur.length ~/ 4;
    // final factor2 = acc.length ~/ 4;

    final factor1 = ((cur.length ~/ 4) - 1).clamp(0, 10);
    final factor2 = ((acc.length ~/ 4) - 1).clamp(0, 10);

    final module = (4 * (factor1 + 1)) + factor1;

    print('text new: $cur - text old: $acc');
    print('factor new: $factor1 - factor old: $factor2');
    print('length new: ${cur.length} - length old: ${acc.length}');

    final space = ((cur.length) % module == 0) ? ' ' : '';
    final text = cur + space;

    return newValue.copyWith(
      text: text,
      selection: TextSelection.collapsed(offset: text.length)
    );
 */