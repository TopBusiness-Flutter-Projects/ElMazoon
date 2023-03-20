// To parse this JSON data, do
//
//     final examHeroModel = examHeroModelFromJson(jsonString);

import 'dart:convert';

class ExamHeroModel {
  ExamHeroModel({
    this.data,
    this.message,
    this.code,
  });

  final ExamHeroData? data;
  final String? message;
  final int? code;

  factory ExamHeroModel.fromRawJson(String str) =>
      ExamHeroModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ExamHeroModel.fromJson(Map<String, dynamic> json) => ExamHeroModel(
        data: json["data"] == null ? null : ExamHeroData.fromJson(json["data"]),
        message: json["message"],
        code: json["code"],
      );

  Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
        "message": message,
        "code": code,
      };
}

class ExamHeroData {
  ExamHeroData({
    this.day,
    this.week,
    this.month,
  });

  final List<HeroData>? day;
  final List<HeroData>? week;
  final List<HeroData>? month;

  factory ExamHeroData.fromRawJson(String str) =>
      ExamHeroData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ExamHeroData.fromJson(Map<String, dynamic> json) => ExamHeroData(
        day: json["day"] == null
            ? []
            : List<HeroData>.from(
                json["day"]!.map((x) => HeroData.fromJson(x))),
        week: json["week"] == null
            ? []
            : List<HeroData>.from(
                json["week"]!.map((x) => HeroData.fromJson(x))),
        month: json["month"] == null
            ? []
            : List<HeroData>.from(
                json["month"]!.map((x) => HeroData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "day":
            day == null ? [] : List<dynamic>.from(day!.map((x) => x.toJson())),
        "week": week == null
            ? []
            : List<dynamic>.from(week!.map((x) => x.toJson())),
        "month": month == null
            ? []
            : List<dynamic>.from(month!.map((x) => x.toJson())),
      };
}

class HeroData {
  HeroData({
    this.id,
    this.name,
    this.country,
    this.ordered,
    this.image,
    this.percentage,
    this.isOrdered = false,
  });

  final int? id;
  final String? name;
  final String? country;
  final int? ordered;
  final String? image;
  final String? percentage;
   bool? isOrdered;

  factory HeroData.fromRawJson(String str) =>
      HeroData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory HeroData.fromJson(Map<String, dynamic> json) => HeroData(
        id: json["id"],
        name: json["name"],
        country: json["country"],
        ordered: json["ordered"],
        image: json["image"],
        percentage: json["percentage"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "country": country,
        "ordered": ordered,
        "image": image,
        "percentage": percentage,
      };
}
