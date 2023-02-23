// To parse this JSON data, do
//
//     final lessonsClassModel = lessonsClassModelFromJson(jsonString);

import 'dart:convert';

LessonsClassModel lessonsClassModelFromJson(String str) => LessonsClassModel.fromJson(json.decode(str));

String lessonsClassModelToJson(LessonsClassModel data) => json.encode(data.toJson());

class LessonsClassModel {
  LessonsClassModel({
    required this.data,
    required this.message,
    required this.code,
  });

  List<LessonsClassDatum> data;
  String message;
  int code;

  factory LessonsClassModel.fromJson(Map<String, dynamic> json) => LessonsClassModel(
    data: List<LessonsClassDatum>.from(json["data"].map((x) => LessonsClassDatum.fromJson(x))),
    message: json["message"],
    code: json["code"],
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "message": message,
    "code": code,
  };
}

class LessonsClassDatum {
  LessonsClassDatum({
    required this.id,
    required this.name,
    required this.type,
    this.note,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  String name;
  String type;
  dynamic note;
  DateTime createdAt;
  DateTime updatedAt;

  factory LessonsClassDatum.fromJson(Map<String, dynamic> json) => LessonsClassDatum(
    id: json["id"],
    name: json["name"],
    type: json["type"],
    note: json["note"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "type": type,
    "note": note,
    "created_at": "${createdAt.year.toString().padLeft(4, '0')}-${createdAt.month.toString().padLeft(2, '0')}-${createdAt.day.toString().padLeft(2, '0')}",
    "updated_at": "${updatedAt.year.toString().padLeft(4, '0')}-${updatedAt.month.toString().padLeft(2, '0')}-${updatedAt.day.toString().padLeft(2, '0')}",
  };
}
