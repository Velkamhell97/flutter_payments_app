// ignore_for_file: constant_identifier_names
import 'payment_method.dart';

enum TokenizationMethod {
  android_pay, 
  apple_pay, 
  masterpass, 
  visa_checkout,
}

class CreditCard {
  final String id;
  final String object;
  final String? addressCity;
  final String? addressCountry;
  final String? addressLine1;
  final CheckResult? addressLine1Check;
  final String? addressLine2;
  final String? addressState;
  final String? addressZip;
  final CheckResult? addressZipCheck;
  final String brand;
  final String country;
  final String customer;
  final CheckResult cvcCheck;
  final String? dynamicLast4;
  final int expMonth;
  final int expYear;
  final String fingerprint;
  final Funding funding;
  final String last4;
  final Map<String, dynamic> metadata;
  final String name;
  final TokenizationMethod? tokenizationMethod;

  const CreditCard({
    required this.id,
    required this.object,
    this.addressCity,
    this.addressCountry,
    this.addressLine1,
    this.addressLine1Check,
    this.addressLine2,
    this.addressState,
    this.addressZip,
    this.addressZipCheck,
    required this.brand,
    required this.country,
    required this.customer,
    required this.cvcCheck,
    this.dynamicLast4,
    required this.expMonth,
    required this.expYear,
    required this.fingerprint,
    required this.funding,
    required this.last4,
    required this.metadata,
    required this.name,
    this.tokenizationMethod,
  });

  factory CreditCard.fromJson(Map<String, dynamic> json) => CreditCard(
    id: json["id"],
    object: json["object"],
    addressCity: json["address_city"],
    addressCountry: json["address_country"],
    addressLine1: json["address_line1"],
    addressLine1Check: json["address_line1_check"] == null ? null : CheckResult.values.byName(json["address_line1_check"]),
    addressLine2: json["address_line2"],
    addressState: json["address_state"],
    addressZip: json["address_zip"],
    addressZipCheck: json["address_zip_check"] == null ? null : CheckResult.values.byName(json["address_zip_check"]),
    brand: json["brand"],
    country: json["country"],
    customer: json["customer"],
    cvcCheck: json["cvc_check"],
    dynamicLast4: json["dynamic_last4"],
    expMonth: json["exp_month"],
    expYear: json["exp_year"],
    fingerprint: json["fingerprint"],
    funding: Funding.values.byName(json["funding"]),
    last4: json["last4"],
    metadata: json["metadata"],
    name: json["name"],
    tokenizationMethod: json["tokenization_method"] == null ? null : TokenizationMethod.values.byName(json["tokenization_method"]),
  );
}