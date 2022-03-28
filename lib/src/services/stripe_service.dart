import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_stripe/flutter_stripe.dart' hide SetupIntent, PaymentIntent, PaymentMethod;

import '../global/global.dart';
import '../models/models.dart';


class StripeService {
  final String _apiHost = Environment.apiUrl;

  static const _paymentMethodsRoute = '/api/payments/stripe/payment-methods';

  static const _paymentIntentRoute = '/api/payments/stripe/payment-intent';
  static const _manualIntentRoute = '/api/payments/stripe/manual-intent';
  // static const _confirmationIntentNoWebhookRoute = '/api/payments/stripe/charge-card-off-session';

  static const _seuptIntentRoute = '/api/payments/stripe/setup-intent';
  static const _applyChargeRoute = '/api/payments/stripe/apply-charge';

  final dio = Dio();

  /************************ Shared Payment Methods  ************************/

  /// Obtiene un payment intent ademas de otras propiedades
  /// 
  /// Aqui se utiliza el objeto PaymentIntent del paquete de stripe tambien se hizo un modelo propio
  /// para poder recibir mas propiedades
  Future<PaymentIntent> _createPaymentIntent(Map<String, dynamic> data) async {
    final endpoint = _apiHost + _paymentIntentRoute;
    
    final resp = await dio.post(endpoint, data: data);
    final paymentIntent = PaymentIntent.fromJson(resp.data);

    return paymentIntent;
  }

  /// Obtiene igualmente un PaymentIntent pero esta vez se procesa diferente en el backed
  /// 
  /// Aqui se le pasa data diferente a el de arriba y se validan diferentes casos en el backed
  Future<PaymentIntent> _createManualIntent(Map<String, dynamic> data) async {
    final endpoint = _apiHost + _manualIntentRoute;

    final resp = await dio.post(endpoint, data: data);
    final paymentIntent = PaymentIntent.fromJson(resp.data);

    return paymentIntent;
  }

  /// En caso de que un intent tenga un status de require action aqui se intenta la confirmacion
  Future<void> _handleCardAction(String clientSecret) async {
    //6. Si require accion se hace una peticion para saber que accion se requiere en especifico
    final paymentIntent = await Stripe.instance.handleCardAction(clientSecret);
  
    print(paymentIntent.status);

    //7. Se ejecuta una accion dependiendo
    if(paymentIntent.status == PaymentIntentsStatus.RequiresConfirmation){
      final confirmationIntent = await _createManualIntent({'paymentIntentId': paymentIntent.id});
      
      print(confirmationIntent.status);
      //check errors
    }
  }

  /// Aplica un cargo a una tarjeta tokenizada
  /// 
  /// Aqui recibimos en la data la tarjeta tokenizada y en el servidor hacemos el recargo 
  /// tambien alli se puede crear una tarjeta con el token (no muy recomendable)
  Future<Charge> _applyCharge(Map<String, dynamic> data) async {
    final endpoint = _apiHost + _applyChargeRoute;

    final resp = await dio.post(endpoint, data: data);
    final charge = Charge.fromJson(resp.data);

    return charge;
  }

  // Future<PaymentIntentResponse> _createConfirmationIntentNoWebhook(Map<String, dynamic> data) async {
  //   final endpoint = _apiHost + _confirmationIntentNoWebhookRoute;
  //
  //   final resp = await dio.post(endpoint, data: data);
  //   final paymentIntentResponse = PaymentIntentResponse.fromJson(resp.data);
  //
  //   return paymentIntentResponse;
  // }

  /************************ Get Methods  ************************/

  /// Obtiene la lista de los metodos de pago de un usuario
  /// 
  /// A pesar de que deberia ser un metodo get es necesario enviar el email por el body (post)
  /// ya que no tenemos un id para enviarlo por los params (get)
  Future<List<PaymentMethod>> getPaymentMethods(String email, [String? paymentMethodId]) async {
    final endpoint = _apiHost + _paymentMethodsRoute;

    final data = {
      'email': email,
      'paymentMethodId': paymentMethodId
    };

    //podemos tambien enviar un el tipo de metodo de pago para filtrar por defecto son tarjetas
    final json = (await dio.post(endpoint, data: data)).data;
    final paymentMethods = List<PaymentMethod>.from(json["data"].map((card) => PaymentMethod.fromJson(card)));

    return paymentMethods;
  }

  /************************ Stripe Sheet Payment  ************************/

  /// Prepara el Stripe Payment Sheet
  /// 
  /// Las tarjetas guardadas por este medio no cuentan con el holder, se tendria que enviar 
  /// un nombre por el parametro data
  Future<void> preparePaymentSheet(Map<String, dynamic> data) async {
    // 1. Crear el payment intent
    final paymentIntent = await _createPaymentIntent(data);

    // 2. Crear los datos del billing o factura
    final billingDetails =  BillingDetails(
      name: 'Test user',
      email: data['email'],
      phone: '+48888000888',
      address: const Address(
        city: 'Houston',
        country: 'US',
        line1: '1459  Circle Drive',
        line2: '',
        state: 'Texas',
        postalCode: '77063',
      ),
    );

    // 3. Prepara el sheet
    await Stripe.instance.initPaymentSheet(
      paymentSheetParameters: SetupPaymentSheetParameters(
        // Main params
        paymentIntentClientSecret: paymentIntent.clientSecret,
        merchantDisplayName: 'Flutter Stripe App',
        // Customer Params
        customerId: paymentIntent.customer,
        customerEphemeralKeySecret: paymentIntent.ephemeralKey,
        // Extra params
        // applePay: false,
        googlePay: true, //Muestra la opcion de pagar con google
        style: ThemeMode.dark,
        billingDetails: billingDetails,
        testEnv: true,
        merchantCountryCode: 'CO'
      )
    );
  }
  
  /// Muestra el Payment Sheet previamente configurado
  Future<void> showPaymentSheet() async {
    //-4. Mostrar el paymentSheet
    await Stripe.instance.presentPaymentSheet();
  }

  /************************ Saved Payment Method  ************************/

  /// crea un Setup Intent
  /// 
  /// Aqui al igual que el PaymentIntent se utiliza la clase del paquete pero tambien se tiene
  /// las pruebas con una clase personalizada
  Future<SetupIntent> _createSetupIntent(Map<String, dynamic> data) async {
    final endpoint = _apiHost + _seuptIntentRoute;

    final resp = await dio.post(endpoint, data: data);
    final setupIntent = SetupIntent.fromJson(resp.data);

    return setupIntent;
  }

  /// Graba un metodo de pago de un usuario
  /// 
  /// Recordar que stripe maneja principalmente metodos de pago, si se quisieran guardar tarjetas 
  /// se tendrian que tokenizan y luego guardar en el servidor y despues aplicar un cargo si se
  /// quieren utilizar, por eso es mejor trabajar directamente con los metodos de pago
  /// tambien se puede utilizar widgets de stripe para recolectar datos o sobreescribirlos con un widget propio
  /// manteniendo la seguridad e integridad de los datos
  Future<PaymentMethod> savePaymentMethod(Map<String, dynamic> data, CardDetails card) async {
    // 1. Obtener el setupIntent
    final setupIntent = await _createSetupIntent(data);

    // 2. Crear datos da facuracion para esta tarjeta
    final billingDetails =  BillingDetails(
      name: data["holder"],
      email: data['email'],
      phone: '+48888000888',
      address: const Address(
        city: 'Houston',
        country: 'US',
        line1: '1459  Circle Drive',
        line2: '',
        state: 'Texas',
        postalCode: '77063',
      ),
    );

    // 3. Cambiar los datos de la tarjeta del widget de stripe por el nuestro (debe ser seguro)
    await Stripe.instance.dangerouslyUpdateCardDetails(card);

    // 4. Confirmar el guardado del metodo de pago
    final setupIntentResult = await Stripe.instance.confirmSetupIntent(
      setupIntent.clientSecret,
      PaymentMethodParams.card(
        billingDetails: billingDetails,
        // setupFutureUsage: PaymentIntentsFutureUsage.OffSession,
      ),
    );

    // if(setupIntentResult.status != "succeeded") --> handle error

    //5. Obtengo el payment method creado para agregarlo a la lista (ya solo se devuelve el id)
    final paymentMethod = await getPaymentMethods(data["email"], setupIntentResult.paymentMethodId);

    return paymentMethod[0];
  }

  /************************ Cards Payments (stripe / manual)  ************************/

  /// Realiza un pago con tarjeta y webhooks
  /// 
  /// Si se utiliza un widget de stripe ya precargara los datos del formulario, si e utiliza un
  /// Widget propio se debe sobreescribir estos datos (manteniendo la seguridad)
  /// Por este medio si existe posibilidad de agregar el holder name (mismo name del billing)
  /// Se sigue un proceso seguro de creacion del intento y posterior confirmacion (webhook)
  /// se crea un nuevo objeto de la tarjeta puede determinarse si se utilzara en un futuro o no
  /// Lo ideal seria que se utilizara con tarjetas nuevas pero se puede con una guardada no guardando
  /// la tarjeta para futuros pagos
  Future<void> payWithCard(Map<String, dynamic> data,  CardDetails card) async {
    // 1. Crear el paymentInten
    final paymentIntent =  await _createPaymentIntent(data);

    // 2. Llenar los datos de la factura
    final billingDetails =  BillingDetails(
      name: data["holder"],
      email: data['email'],
      phone: '+48888000888',
      address: const Address(
        city: 'Houston',
        country: 'US',
        line1: '1459  Circle Drive',
        line2: '',
        state: 'Texas',
        postalCode: '77063',
      ),
    );

    // 3. Reemplazar el widget de card de stripe por nuestros datos (debe ser seguro)
    await Stripe.instance.dangerouslyUpdateCardDetails(card);

    // 4. Confirmar el pago del intent generado previamente
    final confirmationIntent = await Stripe.instance.confirmPayment(
      paymentIntent.clientSecret,
      PaymentMethodParams.card(
        billingDetails: billingDetails,
        // setupFutureUsage: PaymentIntentsFutureUsage.OnSession,
      ),
    );

    print(confirmationIntent.status);
  }
  
  /// Realiza un pago con tarjeta sin webhooks
  /// 
  /// Similar al pago anterior, pero esta vez el proceso es diferente ya que el intento de pago se confirma
  /// inmediatamente, no hay confirmacion, para ello se deben enviar datos de la tarjeta (stripe o manual)
  /// como no se hace confirmacion se evalua el estado para ver si se require alguna accion adicional
  /// Este pago tambien crea un nuevo objeto de tarjeta, por lo que seria para tarjetas nuevas principalmente
  /// pero se puede un nuevo objeto y no guardarlo como futuro uso si se desea usar una vieja
  /// para estos casos se tendria que tener la tarjeta guardada en una clase propia (donde este toda la info)
  /// esto no es muy seguro y por eso se debe utilizar principalmente para nuevas tarjetas
  /// o utilizar la mejor opcion con el uso del payment method de stripe que es el metodo de abajo
  Future<void> payWithCardManual(Map<String, dynamic> data, CardDetails card) async {
    // 1. creamos los datos de facturacion asociados a la tarjeta
    final billingDetails =  BillingDetails(
      name: data["holder"],
      email: data['email'],
      phone: '+48888000888',
      address: const Address(
        city: 'Houston',
        country: 'US',
        line1: '1459  Circle Drive',
        line2: '',
        state: 'Texas',
        postalCode: '77063',
      ),
    );

    // 2. Reemplazamos los datos de la tarjeta del widget de stripe por el nuestro (debe ser seguro)
    await Stripe.instance.dangerouslyUpdateCardDetails(card);

    // 3. Creamos un metodo de pago (payment_method id)
    final paymentMethod =  await Stripe.instance.createPaymentMethod(
      PaymentMethodParams.card(
        billingDetails: billingDetails,
        // setupFutureUsage: PaymentIntentsFutureUsage.OffSession,
      )
    );

    // 4. Con el llamado manual confirmamos el pago en la misma peticion del paymentIntent
    final paymentIntent = await _createManualIntent({
      ...data, //va el currency, el amount y el email
      'useStripeSdk': true,
      'paymentMethodId' : paymentMethod.id
    });

    print(paymentIntent.status);

    // 5. Si devuelve que require accion debemos hacer otro intent de confirmacion
    if(paymentIntent.status == PaymentIntentsStatus.RequiresAction){
      print('requires action');
      await _handleCardAction(paymentIntent.clientSecret);
    } 
  }

  /// Realiza un pago con un metodo de pago sin webhooks
  /// 
  /// Similar al pago anterior, pero mucho mas seguro para utilizarlo con tarjetas utilzadas
  /// se almacena el id del metodo de pago y se hace el pago manual, asi no se almacenan datos
  /// importantes de las tarjetas
  Future<void> payWithMethodManual(Map<String, dynamic> data, String paymentMethodId) async {
    // 1. Enviamos la peticion con el method id
    final paymentIntent = await _createManualIntent({
      ...data, //va el currency, el amount y el email
      'useStripeSdk': true,
      'paymentMethodId' : paymentMethodId
    });

    print(paymentIntent.status);

    // 2. Si devuelve que require accion debemos hacer otro intent de confirmacion
    if(paymentIntent.status == PaymentIntentsStatus.RequiresAction){
      print('requires action');
      await _handleCardAction(paymentIntent.clientSecret);
    }
  }

  /************************ Token Payments  ************************/

  /// Tokeniza una tarjeta y envia este token al servidor para aplicar un cargo
  /// 
  /// Tener en cuenta que con la tokenizacion es la unica forma que se pueden crear tarjetas y vincular
  /// a un usuario, pero esto ya nos daria problemas porque son diferentes objetos a los metodos de pago
  /// por ello esque un token se usa principalmente para pagos de un solo uso en donde no se guarda el metodo
  Future<void> payWithCardToken(Map<String, dynamic> data, CardDetails card) async {
    // 1. Recolectar algo de informacion de facturacion
    const address = Address(
      city: 'Houston',
      country: 'US',
      line1: '1459  Circle Drive',
      line2: '',
      state: 'Texas',
      postalCode: '77063',
    );

    // 2. Cambiar los datos de la tarjeta del widget de stripe por el nuestro (debe ser seguro)
    await Stripe.instance.dangerouslyUpdateCardDetails(card);

    // 3. Tokenizar la tarjeta para enviar el token al server
    final tokenData = await Stripe.instance.createToken(
      const CreateTokenParams.card(params: CardTokenParams(address: address))
    );

    // 4. Enviar el token generado al servidor y esperar si el recargo es exitoso o no
    final chargeResponse = await _applyCharge({...data, 'paymentToken': tokenData.id});

    print(chargeResponse.status);
  }

  /************************ Wallet Payments  ************************/

  /// Pagar con google y el modulo de stripe
  /// 
  /// Este utiliza la aplicacion de google pay que no esta disponible en todos los paises por lo que 
  /// no se pudo probar este metodo, la ventaja esque queda vinculado como un metodo de pago de stripe
  /// y se pueden hacer varias cosas con esto
  Future<String> initGoogleStripeSheet(Map<String, dynamic> data) async {
    // 1. Crear el intento de pago
    final paymentIntent = await _createPaymentIntent(data);

    // 2. Preparar el sheet de google pay
    await Stripe.instance.initGooglePay(const GooglePayInitParams(
      testEnv: true,
      merchantName: 'Flutter Apps',
      countryCode: 'CO',
    ));

    return paymentIntent.clientSecret;
  }

  Future<void> presentGoogleStripeSheet(String clientSecret) async {
    // 3. Presentar el sheet de google pay
    return await Stripe.instance.presentGooglePay(PresentGooglePayParams(clientSecret: clientSecret));
  }

  Future<void> payWithGoogle(Map<String, dynamic> data, Map<String, dynamic> googleResult) async {
    // 1. Obtenemos el paymentIntent luego de obtener los resultados del boton de google
    final paymentIntent = await _createPaymentIntent(data);

    print(googleResult);

    // 2. Extraemos el token de los resultados para tokenizar un metodo de pago
    final token = googleResult["paymentMethodData"]["tokenizationData"]["token"];
    final tokenJson = Map.castFrom(json.decode(token));

    // 3. Creamos el metodo de pago (en forma de tarjeta)
    final params = PaymentMethodParams.cardFromToken(token: tokenJson["id"]);

    // 4. Confirmamos el pago con el metodo creado previamente
    await Stripe.instance.confirmPayment(paymentIntent.clientSecret, params);

    print("Payment Successfully");
  }
}