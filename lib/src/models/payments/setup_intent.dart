// ignore_for_file: constant_identifier_names

import 'payment_intent.dart';

enum Usage {
  on_session,
  off_session
}

class SetupIntent {
  final String id;
  final String object;
  final String? application; // id - expandible
  final CancelationReason? cancellationReason; //string
  final String clientSecret; 
  final int created; //timestamp
  final String customer; // id - expandible
  final String? description;
  final dynamic lastSetupError; // multiples classes
  final String? latestAttempt; // string - expandible
  final bool livemode;
  final String? mandate; // id - expandible
  final Map<String, dynamic> metadata;
  final dynamic nextAction; // multiples classes
  final String? onBehalfOf; // string - expandible
  final String? paymentMethod; //id - expandible
  final PaymentMethodOptions paymentMethodOptions;
  final List<String> paymentMethodTypes;
  final String? singleUseMandate; // id - expandible
  final IntentStatus status;
  final Usage usage;

  const SetupIntent({
    required this.id,
    required this.object,
    this.application,
    this.cancellationReason,
    required this.clientSecret,
    required this.created,
    required this.customer,
    this.description,
    this.lastSetupError,
    this.latestAttempt,
    required this.livemode,
    this.mandate,
    required this.metadata,
    this.nextAction,
    this.onBehalfOf,
    this.paymentMethod,
    required this.paymentMethodOptions,
    required this.paymentMethodTypes,
    this.singleUseMandate,
    required this.status,
    required this.usage,
  });

  factory SetupIntent.fromJson(Map<String, dynamic> json) => SetupIntent(
    id: json["id"],
    object: json["object"],
    application: json["application"],
    cancellationReason: json["cancellation_reason"] == null ? null : CancelationReason.values.byName(json["cancellation_reason"]),
    clientSecret: json["client_secret"],
    created: json["created"],
    customer: json["customer"],
    description: json["description"],
    lastSetupError: json["last_setup_error"],
    latestAttempt: json["latest_attempt"],
    livemode: json["livemode"],
    mandate: json["mandate"],
    metadata: json["metadata"],
    nextAction: json["next_action"],
    onBehalfOf: json["on_behalf_of"],
    paymentMethod: json["payment_method"],
    paymentMethodOptions: PaymentMethodOptions.fromJson(json["payment_method_options"]),
    paymentMethodTypes: List<String>.from(json["payment_method_types"].map((x) => x)),
    singleUseMandate: json["single_use_mandate"],
    status: IntentStatus.values.byName(json["status"]),
    usage: Usage.values.byName(json["usage"]),
  );
}