// To parse this JSON data, do
//
//     final subscribesModel = subscribesModelFromJson(jsonString);

import 'dart:convert';

import 'month_plan_model.dart';

class SubscribesModel {
  SubscribesModel({
    this.data,
    this.message,
    this.code,
  });

  final List<SubscribesDatum>? data;
  final String? message;
  final int? code;

  factory SubscribesModel.fromRawJson(String str) =>
      SubscribesModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SubscribesModel.fromJson(Map<String, dynamic> json) =>
      SubscribesModel(
        data: json["data"] == null
            ? []
            : List<SubscribesDatum>.from(
                json["data"]!.map((x) => SubscribesDatum.fromJson(x))),
        message: json["message"],
        code: json["code"],
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
        "message": message,
        "code": code,
      };
}

class SubscribesDatum {
  SubscribesDatum({
    this.id,
    this.price,
    this.isFree,
    this.month,
    this.monthName,
    this.mothData,
    this.createdAt,
  });

  final int? id;
  final int? price;
  final String? isFree;
  final int? month;
  final String? monthName;
  final List<MothData>? mothData;
  final DateTime? createdAt;

  factory SubscribesDatum.fromRawJson(String str) =>
      SubscribesDatum.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SubscribesDatum.fromJson(Map<String, dynamic> json) =>
      SubscribesDatum(
        id: json["id"],
        price: json["price"],
        isFree: json["is_free"],
        month: json["month"],
        monthName: json["month_name"],
        mothData: json["monthly_plan"] == null || json["monthly_plan"] == []
            ? []
            : List<MothData>.from(
                json["monthly_plan"]!.map((x) => MothData.fromJson(x))),
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "price": price,
        "is_free": isFree,
        "month": month,
        "month_name": monthName,
        // "monthly_plan": monthlyPlan,
        "created_at":
            "${createdAt!.year.toString().padLeft(4, '0')}-${createdAt!.month.toString().padLeft(2, '0')}-${createdAt!.day.toString().padLeft(2, '0')}",
      };
}
