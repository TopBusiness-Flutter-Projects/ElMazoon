// To parse this JSON data, do
//
//     final onBoardingModel = onBoardingModelFromJson(jsonString);

import 'dart:convert';

OnBoardingModel onBoardingModelFromJson(String str) => OnBoardingModel.fromJson(json.decode(str));

String onBoardingModelToJson(OnBoardingModel data) => json.encode(data.toJson());

class OnBoardingModel {
  OnBoardingModel({
    this.data,
    this.message,
    this.code,
  });

  final List<OnBoardingDatum>? data;
  final String? message;
  final int? code;

  factory OnBoardingModel.fromJson(Map<String, dynamic> json) => OnBoardingModel(
    data: json["data"] == null ? [] : List<OnBoardingDatum>.from(json["data"]!.map((x) => OnBoardingDatum.fromJson(x))),
    message: json["message"],
    code: json["code"],
  );

  Map<String, dynamic> toJson() => {
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    "message": message,
    "code": code,
  };
}

class OnBoardingDatum {
  OnBoardingDatum({
    this.id,
    this.title,
    this.description,
    this.image,
    this.createdAt,
    this.updatedAt,
  });

  final int? id;
  final String? title;
  final String? description;
  final String? image;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory OnBoardingDatum.fromJson(Map<String, dynamic> json) => OnBoardingDatum(
    id: json["id"],
    title: json["title"],
    description: json["description"],
    image: json["image"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "description": description,
    "image": image,
    "created_at": "${createdAt!.year.toString().padLeft(4, '0')}-${createdAt!.month.toString().padLeft(2, '0')}-${createdAt!.day.toString().padLeft(2, '0')}",
    "updated_at": "${updatedAt!.year.toString().padLeft(4, '0')}-${updatedAt!.month.toString().padLeft(2, '0')}-${updatedAt!.day.toString().padLeft(2, '0')}",
  };
}
