// To parse this JSON data, do
//
//     final sendPayModel = sendPayModelFromJson(jsonString);

import 'dart:convert';

SendPayModel sendPayModelFromJson(String str) => SendPayModel.fromJson(json.decode(str));

String sendPayModelToJson(SendPayModel data) => json.encode(data.toJson());

class SendPayModel {
  SendPayModel({
    this.subscribesIds,
    this.fullName,
    this.cardNumber,
    this.month,
    this.year,
    this.cvv,
    this.amount,
    this.paymentMethod,
  });

  final List<int>? subscribesIds;
  final String? fullName;
  final String? cardNumber;
  final String? month;
  final String? year;
  final String? cvv;
  final String? amount;
  final String? paymentMethod;

  factory SendPayModel.fromJson(Map<String, dynamic> json) => SendPayModel(
    subscribesIds: json["subscribes_ids"] == null ? [] : List<int>.from(json["subscribes_ids"]!.map((x) => x)),
    fullName: json["fullName"],
    cardNumber: json["cardNumber"],
    month: json["month"],
    year: json["year"],
    cvv: json["cvv"],
    amount: json["amount"],
    paymentMethod: json["payment_method"],
  );

  Map<String, dynamic> toJson() => {
    "subscribes_ids": subscribesIds == null ? [] : List<dynamic>.from(subscribesIds!.map((x) => x)),
    "fullName": fullName,
    "cardNumber": cardNumber,
    "month": month,
    "year": year,
    "cvv": cvv,
    "amount": amount,
    "payment_method": paymentMethod,
  };
}
