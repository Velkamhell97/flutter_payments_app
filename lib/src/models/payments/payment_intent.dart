// ignore_for_file: constant_identifier_names

enum CaptureMethod {
  automatic,
  manual
}

enum ConfirmationMethod {
  automatic,
  manual
}

enum CancelationReason {
  duplicate,
  fraudulent,
  requested_by_customer,
  abandoned,
  failed_invoice,
  void_invoice,
  automatic
}

enum IntentStatus {
  requires_payment_method,
  requires_confirmation,
  requires_action,
  processing,
  requires_capture,
  canceled,
  succeeded
}

enum SetupFutureUseage {
  on_session,
  off_session
}

class PaymentIntent {
  final String id;
  final String object;
  final int amount;
  final int amountCapturable;
  final int amountReceived;
  final String? application; //id - expandible
  final int? applicationFeeAmount; //amount
  final dynamic automaticPaymentMethods; // class
  final int? canceledAt; //timestamp
  final CancelationReason? cancellationReason; //string
  final CaptureMethod captureMethod;
  final Charges charges;
  final String clientSecret; //id
  final ConfirmationMethod confirmationMethod;
  final int created; //timestamp
  final String currency;
  final String customer; //id - expandible
  final String? description; 
  final String? ephemeralKey; // id
  final String? invoice; //id - expandable
  final dynamic lastPaymentError; // multiples classes
  final bool livemode;
  final Map<String, dynamic> metadata;
  final dynamic nextAction; // multiples classes
  final String? onBehalfOf; // string - expandable
  final String? paymentMethod; //id - expandible
  final PaymentMethodOptions paymentMethodOptions;
  final List<String> paymentMethodTypes;
  final dynamic processing; // multiples classes
  final String? receiptEmail;
  final String? review; //id - expandable
  final SetupFutureUseage? setupFutureUsage; 
  final dynamic shipping; // multiples classes
  final dynamic source; // multiples classes 
  final String? statementDescriptor; //string
  final String? statementDescriptorSuffix; //string
  final IntentStatus status;
  final dynamic transferData; // multiples classes
  final String? transferGroup; // id

  PaymentIntent({
    required this.id,
    required this.object,
    required this.amount,
    required this.amountCapturable,
    required this.amountReceived,
    this.application,
    this.applicationFeeAmount,
    this.automaticPaymentMethods,
    this.canceledAt,
    this.cancellationReason,
    required this.captureMethod,
    required this.charges,
    required this.clientSecret,
    required this.confirmationMethod,
    required this.created,
    required this.currency,
    required this.customer,
    this.description,
    this.ephemeralKey,
    this.invoice,
    this.lastPaymentError,
    required this.livemode,
    required this.metadata,
    this.nextAction,
    this.onBehalfOf,
    this.paymentMethod,
    required this.paymentMethodOptions,
    required this.paymentMethodTypes,
    this.processing,
    this.receiptEmail,
    this.review,
    this.setupFutureUsage,
    this.shipping,
    this.source,
    this.statementDescriptor,
    this.statementDescriptorSuffix,
    required this.status,
    this.transferData,
    this.transferGroup,
  });

  factory PaymentIntent.fromJson(Map<String, dynamic> json) => PaymentIntent(
    id: json["id"],
    object: json["object"],
    amount: json["amount"],
    amountCapturable: json["amount_capturable"],
    amountReceived: json["amount_received"],
    application: json["application"],
    applicationFeeAmount: json["application_fee_amount"],
    automaticPaymentMethods: json["automatic_payment_methods"],
    canceledAt: json["canceled_at"],
    cancellationReason: json["cancellation_reason"] == null ? null : CancelationReason.values.byName(json["cancellation_reason"]),
    captureMethod: CaptureMethod.values.byName(json["capture_method"]),
    charges: Charges.fromJson(json["charges"]),
    clientSecret: json["client_secret"],
    confirmationMethod: ConfirmationMethod.values.byName(json["confirmation_method"]),
    created: json["created"],
    currency: json["currency"],
    customer: json["customer"],
    description: json["description"],
    invoice: json["invoice"],
    lastPaymentError: json["last_payment_error"],
    livemode: json["livemode"],
    metadata: json["metadata"],
    nextAction: json["next_action"],
    onBehalfOf: json["on_behalf_of"],
    paymentMethod: json["payment_method"],
    paymentMethodOptions: PaymentMethodOptions.fromJson(json["payment_method_options"]),
    paymentMethodTypes: List<String>.from(json["payment_method_types"].map((x) => x)),
    processing: json["processing"],
    receiptEmail: json["receipt_email"],
    review: json["review"],
    setupFutureUsage: json["setup_future_usage"] == null ? null : SetupFutureUseage.values.byName(json["setup_future_usage"]),
    shipping: json["shipping"],
    source: json["source"],
    statementDescriptor: json["statement_descriptor"],
    statementDescriptorSuffix: json["statement_descriptor_suffix"],
    status: IntentStatus.values.byName(json["status"]),
    transferData: json["transfer_data"],
    transferGroup: json["transfer_group"],
    ephemeralKey: json["ephemeralKey"],
  );
}

class Charges {
  final String object;
  final List<dynamic> data;
  final bool hasMore;
  final int totalCount;
  final String url;

  Charges({
    required this.object,
    required this.data,
    required this.hasMore,
    required this.totalCount,
    required this.url,
  });

  factory Charges.fromJson(Map<String, dynamic> json) => Charges(
    object: json["object"],
    data: List<dynamic>.from(json["data"].map((x) => x)),
    hasMore: json["has_more"],
    totalCount: json["total_count"],
    url: json["url"],
  );
}

class AutomaticPaymentMethods {
  final bool enabled;

  AutomaticPaymentMethods({required this.enabled});

  factory AutomaticPaymentMethods.fromJson(Map<String, dynamic> json) => AutomaticPaymentMethods(
    enabled: json["enabled"],
  );
}

class PaymentMethodOptions {
  final IntentCard? card;

  const PaymentMethodOptions({this.card});

  factory PaymentMethodOptions.fromJson(Map<String, dynamic> json) => PaymentMethodOptions(
    card: json["card"] == null ? null : IntentCard.fromJson(json["card"]),
  );
}

enum CardCaptureMethod {
  manual
}

enum CardSetupFutureUsage {
  on_session,
  off_session,
  none
}

enum RequestThreeDSecure {
  automatic,
  any
}

//-Es un ejemplo de un tipo de respuesta, generalmente no utilizado en el lado del cliente
//-asi como este existen varios metodos de pago con sus propiedades
class IntentCard {
  final CardCaptureMethod? captureMethod;
  final String? cvcToken;
  final dynamic installments; //object
  final dynamic mandateOptions; //object
  final String? network; //
  final RequestThreeDSecure requestThreeDSecure;
  final CardSetupFutureUsage? setupFutureUsage;

  const IntentCard({
    this.captureMethod,
    this.cvcToken,
    this.installments,
    this.mandateOptions,
    this.network,
    required this.requestThreeDSecure,
    this.setupFutureUsage
  });

  factory IntentCard.fromJson(Map<String, dynamic> json) => IntentCard(
    captureMethod: json["capture_method"] == null ? null : CardCaptureMethod.values.byName(json["capture_method"]),
    cvcToken: json["cvc_token"],
    installments: json["installments"],
    mandateOptions: json["mandate_options"],
    network: json["network"],
    requestThreeDSecure: RequestThreeDSecure.values.byName(json["request_three_d_secure"]),
    setupFutureUsage: json["setup_future_usage"] == null ? null : CardSetupFutureUsage.values.byName(json["setup_future_usage"])
  );
}
