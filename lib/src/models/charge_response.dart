// ignore_for_file: constant_identifier_names

import 'package:flutter_stripe/flutter_stripe.dart' show Address, BillingDetails, Card;

enum ChargeStatus {
  succeeded,
  pending,
  failed
}

class ChargeResponse {
  final String id;
  final String object;
  final int amount;
  final int amountCaptured;
  final int amountRefunded;
  final String? application; //id - expandible
  final String? applicationFee; // string - expandible
  final int? applicationFeeAmount;
  final String balanceTransaction; // id - expandible
  final BillingDetails billingDetails;
  final String calculatedStatementDescriptor;
  final bool captured;
  final int created; // timestamp
  final String currency; 
  final String? customer; // id - expandible
  final String? description;
  final bool disputed;
  final String? failureCode;
  final String? failureMessage;
  final Map<String, dynamic> fraudDetails;
  final String? invoice; //id - expandable
  final bool livemode;
  final Map<String, dynamic> metadata;
  final String? onBehalfOf; // string - expandable
  final String? order; // id - expandible
  final Outcome outcome;
  final bool paid;
  final String? paymentIntent; // id - expandible
  final String paymentMethod; // id
  final PaymentMethodDetails paymentMethodDetails;
  final String? receiptEmail;
  final String? receiptNumber;
  final String receiptUrl;
  final bool refunded;
  final Refunds refunds;
  final String? review; //id - expandable
  final Shipping? shipping;
  final String? sourceTransfer; // id - expandible
  final String? statementDescriptor;
  final String? statementDescriptorSuffix;
  final ChargeStatus status;
  final dynamic transferData; // multiples classes
  final String? transferGroup; // id
  final String source;

  const ChargeResponse({
    required this.id,
    required this.object,
    required this.amount,
    required this.amountCaptured,
    required this.amountRefunded,
    this.application,
    this.applicationFee,
    this.applicationFeeAmount,
    required this.balanceTransaction,
    required this.billingDetails,
    required this.calculatedStatementDescriptor,
    required this.captured,
    required this.created,
    required this.currency,
    this.customer,
    this.description,
    required this.disputed,
    this.failureCode,
    this.failureMessage,
    required this.fraudDetails,
    this.invoice,
    required this.livemode,
    required this.metadata,
    this.onBehalfOf,
    this.order,
    required this.outcome,
    required this.paid,
    this.paymentIntent,
    required this.paymentMethod,
    required this.paymentMethodDetails,
    this.receiptEmail,
    this.receiptNumber,
    required this.receiptUrl,
    required this.refunded,
    required this.refunds,
    this.review,
    this.shipping,
    this.sourceTransfer,
    this.statementDescriptor,
    this.statementDescriptorSuffix,
    required this.status,
    this.transferData,
    this.transferGroup,
    required this.source, // id - expandible
  });

  factory ChargeResponse.fromJson(Map<String, dynamic> json) => ChargeResponse(
    id: json["id"],
    object: json["object"],
    amount: json["amount"],
    amountCaptured: json["amount_captured"],
    amountRefunded: json["amount_refunded"],
    application: json["application"],
    applicationFee: json["application_fee"],
    applicationFeeAmount: json["application_fee_amount"],
    balanceTransaction: json["balance_transaction"],
    billingDetails: BillingDetails.fromJson(json["billing_details"]),
    calculatedStatementDescriptor: json["calculated_statement_descriptor"],
    captured: json["captured"],
    created: json["created"],
    currency: json["currency"],
    customer: json["customer"],
    description: json["description"],
    disputed: json["disputed"],
    failureCode: json["failure_code"],
    failureMessage: json["failure_message"],
    fraudDetails: json["fraud_details"],
    invoice: json["invoice"],
    livemode: json["livemode"],
    metadata: json["metadata"],
    onBehalfOf: json["on_behalf_of"],
    order: json["order"],
    outcome: Outcome.fromJson(json["outcome"]),
    paid: json["paid"],
    paymentIntent: json["payment_intent"],
    paymentMethod: json["payment_method"],
    paymentMethodDetails: PaymentMethodDetails.fromJson(json["payment_method_details"]),
    receiptEmail: json["receipt_email"],
    receiptNumber: json["receipt_number"],
    receiptUrl: json["receipt_url"],
    refunded: json["refunded"],
    refunds: Refunds.fromJson(json["refunds"]),
    review: json["review"],
    shipping: json["shipping"] == null ? null : Shipping.fromJson(json["shipping"]),
    sourceTransfer: json["source_transfer"],
    statementDescriptor: json["statement_descriptor"],
    statementDescriptorSuffix: json["statement_descriptor_suffix"],
    status: ChargeStatus.values.byName(json["status"]),
    transferData: json["transfer_data"],
    transferGroup: json["transfer_group"],
    source: json["source"],
  );
}

enum NetworkStatus {
  approved_by_network,
  declined_by_network,
  not_sent_to_network,
  reversed_after_approval
}

enum RiskLevel {
  normal,
  elevated,
  highest,
  not_assessed,
  unknown
}

enum OutcomeType {
  authorized,
  manual_review,
  issuer_declined,
  blocked,
  invalid,
}

class Outcome {
  final NetworkStatus networkStatus;
  final String? reason;
  final RiskLevel riskLevel;
  final int riskScore;
  final String? rule; //id - expandible
  final String sellerMessage;
  final OutcomeType type;

  const Outcome({
    required this.networkStatus,
    this.reason,
    required this.riskLevel,
    required this.riskScore,
    this.rule,
    required this.sellerMessage,
    required this.type,
  });

  factory Outcome.fromJson(Map<String, dynamic> json) => Outcome(
    networkStatus: NetworkStatus.values.byName(json["network_status"]),
    reason: json["reason"],
    riskLevel: RiskLevel.values.byName(json["risk_level"]),
    riskScore: json["risk_score"],
    rule: json["rule"],
    sellerMessage: json["seller_message"],
    type: OutcomeType.values.byName(json["type"]),
  );
}

class PaymentMethodDetails {
  final Card card;
  final String type;

  const PaymentMethodDetails({
    required this.card,
    required this.type,
  });

  factory PaymentMethodDetails.fromJson(Map<String, dynamic> json) => PaymentMethodDetails(
    card: Card.fromJson(json["card"]),
    type: json["type"],
  );
}

class Refunds {
  final String object;
  final List<dynamic> data;
  final bool hasMore;
  final String url;

  const Refunds({
    required this.object,
    required this.data,
    required this.hasMore,
    required this.url,
  });

  factory Refunds.fromJson(Map<String, dynamic> json) => Refunds(
    object: json["object"],
    data: List<dynamic>.from(json["data"].map((x) => x)),
    hasMore: json["has_more"],
    url: json["url"],
  );
}

class Shipping {
  final Address address;
  final String? carrier;
  final String name;
  final String? phone;
  final String? trackingNumber;

  const Shipping({
    required this.address,
    this.carrier,
    required this.name,
    this.phone,
    this.trackingNumber,
  });

  factory Shipping.fromJson(Map<String, dynamic> json) => Shipping(
    address: Address.fromJson(json["address"]),
    carrier: json["carrier"],
    name: json["name"],
    phone: json["phone"],
    trackingNumber: json["tracking_number"],
  );
}
