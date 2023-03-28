// To parse this JSON data, do
//
//     final paymentResponse = paymentResponseFromJson(jsonString);

import 'dart:convert';

PaymentResponse paymentResponseFromJson(String str) => PaymentResponse.fromJson(json.decode(str));

String paymentResponseToJson(PaymentResponse data) => json.encode(data.toJson());

class PaymentResponse {
  PaymentResponse({
    this.data,
    this.error,
    this.message,
    this.code,
  });

  final String? data;
  final String? error;
  final String? message;
  final int? code;

  factory PaymentResponse.fromJson(Map<String, dynamic> json) => PaymentResponse(
    data: json["data"],
    error: json["error"],
    message: json["message"],
    code: json["code"],
  );

  Map<String, dynamic> toJson() => {
    "data": data,
    "error": error,
    "message": message,
    "code": code,
  };
}
