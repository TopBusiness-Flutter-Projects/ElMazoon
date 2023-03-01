// To parse this JSON data, do
//
//     final lessonsClassModel = lessonsClassModelFromJson(jsonString);

import 'dart:convert';

import '../../../../core/models/lessons_details_model.dart';

LessonsClassModel lessonsClassModelFromJson(String str) => LessonsClassModel.fromJson(json.decode(str));

String lessonsClassModelToJson(LessonsClassModel data) => json.encode(data.toJson());

class LessonsClassModel {
  LessonsClassModel({
    required this.data,
    required this.message,
    required this.code,
  });

  List<Lessons> data;
  String message;
  int code;

  factory LessonsClassModel.fromJson(Map<String, dynamic> json) => LessonsClassModel(
    data: List<Lessons>.from(json["data"].map((x) => Lessons.fromJson(x))),
    message: json["message"],
    code: json["code"],
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "message": message,
    "code": code,
  };
}

