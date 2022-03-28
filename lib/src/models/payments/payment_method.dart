import 'package:flutter_stripe/flutter_stripe.dart' show BillingDetails;

class PaymentMethod {
  final String id;
  final String object;
  final BillingDetails billingDetails;
  PaymentCard? card;
  final int created; //timestamp
  final String customer;
  final bool livemode;
  final Map<String, dynamic> metadata;
  final String type;

  PaymentMethod({
    required this.id,
    required this.object,
    required this.billingDetails,
    this.card,
    required this.created,
    required this.customer,
    required this.livemode,
    required this.metadata,
    required this.type,
  });

  factory PaymentMethod.fromJson(Map<String, dynamic> json) => PaymentMethod(
    id: json["id"],
    object: json["object"],
    billingDetails: BillingDetails.fromJson(json["billing_details"]),
    card: json["card"] == null ? null : PaymentCard.fromJson(json["card"]),
    created: json["created"],
    customer: json["customer"],
    livemode: json["livemode"],
    metadata: json["metadata"],
    type: json["type"],
  );
}

enum Funding {
  credit, 
  debit, 
  prepaid,
  unknown,
}

class PaymentCard {
  final String brand;
  final Checks checks;
  final String country;
  final int expMonth;
  final int expYear;
  final String fingerprint;
  final Funding funding;
  final dynamic generatedFrom; //classes
  final dynamic installments; // classes
  final String last4;
  final String? mandate;
  final String? network;
  final Networks networks;
  final dynamic threeDSecure; // classes
  final ThreeDSecureUsage threeDSecureUsage;
  final dynamic wallet; //classes

  const PaymentCard({
    required this.brand,
    required this.checks,
    required this.country,
    required this.expMonth,
    required this.expYear,
    required this.fingerprint,
    required this.funding,
    this.generatedFrom,
    this.installments,
    required this.last4,
    this.mandate,
    this.network,
    required this.networks,
    this.threeDSecure,
    required this.threeDSecureUsage,
    this.wallet,
  });

  factory PaymentCard.fromJson(Map<String, dynamic> json) => PaymentCard(
    brand: json["brand"],
    checks: Checks.fromJson(json["checks"]),
    country: json["country"],
    expMonth: json["exp_month"],
    expYear: json["exp_year"],
    fingerprint: json["fingerprint"],
    funding: Funding.values.byName(json["funding"]),
    generatedFrom: json["generated_from"],
    installments: json["installments"],
    last4: json["last4"],
    mandate: json["mandate"],
    network: json["network"],
    networks: Networks.fromJson(json["networks"]),
    threeDSecure: json["threeDSecure"],
    threeDSecureUsage: ThreeDSecureUsage.fromJson(json["three_d_secure_usage"]),
    wallet: json["wallet"],
  );
}

enum CheckResult {
  pass, 
  fail,
  unavailable, 
  unchecked,
}

class Checks {
  CheckResult? addressLine1Check;
  CheckResult? addressPostalCodeCheck;
  CheckResult cvcCheck;

  Checks({
    this.addressLine1Check,
    this.addressPostalCodeCheck,
    required this.cvcCheck,
  });

  factory Checks.fromJson(Map<String, dynamic> json) => Checks(
    addressLine1Check: json["address_line1_check"] == null ? null : CheckResult.values.byName(json["address_line1_check"]),
    addressPostalCodeCheck: json["address_postal_code_check"] == null ? null : CheckResult.values.byName(json["address_postal_code_check"]),
    cvcCheck: CheckResult.values.byName(json["cvc_check"]),
  );
}

class Networks {
  final List<String> available;
  final String? preferred;

  Networks({
    required this.available,
    this.preferred,
  });

  factory Networks.fromJson(Map<String, dynamic> json) => Networks(
    available: List<String>.from(json["available"].map((x) => x)),
    preferred: json["preferred"],
  );
}

class ThreeDSecureUsage {
  bool supported;

  ThreeDSecureUsage({
    required this.supported,
  });

  factory ThreeDSecureUsage.fromJson(Map<String, dynamic> json) => ThreeDSecureUsage(
    supported: json["supported"],
  );
}

