// To parse this JSON data, do
//
//     final adsModel = adsModelFromJson(jsonString);

import 'dart:convert';

import 'package:elmazoon/core/models/question_model.dart';

AdsModel adsModelFromJson(String str) => AdsModel.fromJson(json.decode(str));

String adsModelToJson(AdsModel data) => json.encode(data.toJson());

class AdsModel {
  AdsModel({this.message, this.code, this.data});

  String? message;
  int? code;
  Data? data;

  factory AdsModel.fromJson(Map<String, dynamic> json) => AdsModel(
      data: json["data"] == null ? null : Data.fromJson(json["data"]),
      message: json["message"],
      code: json["code"]);

  Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
        "message": message,
        "code": code,
      };
}

class Data {
  List<AdsModelDatum>? ads;

  LifeExam? lifeExam;

  Data({
    this.ads,
    this.lifeExam,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        ads: json["ads"] == null
            ? []
            : List<AdsModelDatum>.from(
                json["ads"]!.map((x) => AdsModelDatum.fromJson(x))),
        lifeExam: json["life_exam"] == null
            ? null
            : LifeExam.fromJson(json["life_exam"]),
      );

  Map<String, dynamic> toJson() => {
        "ads":
            ads == null ? [] : List<dynamic>.from(ads!.map((x) => x.toJson())),
        "life_exam": lifeExam?.toJson(),
      };
}

class AdsModelDatum {
  AdsModelDatum({
    this.id,
    this.link,
    this.type,
    this.filePath,
    this.createdAt,
  });

  int? id;
  String? link;
  String? type;
  String? filePath;
  DateTime? createdAt;

  factory AdsModelDatum.fromJson(Map<String, dynamic> json) => AdsModelDatum(
        id: json["id"],
        link: json["link"],
        type: json["type"],
        filePath: json["file_path"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "link": link,
        "type": type,
        "file_path": filePath,
        "created_at":
            "${createdAt!.year.toString().padLeft(4, '0')}-${createdAt!.month.toString().padLeft(2, '0')}-${createdAt!.day.toString().padLeft(2, '0')}",
      };
}

class LifeExam {
  LifeExam({
    this.id,
    this.name,
    this.dateExam,
    this.timeStart,
    this.timeEnd,
    this.quizMinute,
    this.degree,
    this.createdAt,
    this.updatedAt,
    this.questions,
  });

  int? id;
  String? name;
  DateTime? dateExam;
  String? timeStart;
  String? timeEnd;
  int? quizMinute;
  int? degree;
  DateTime? createdAt;
  DateTime? updatedAt;
  List<Questions>? questions = [];

  factory LifeExam.fromJson(Map<String, dynamic> json) => LifeExam(
        id: json["id"],
        name: json["name"],
        dateExam: json["date_exam"] == null
            ? null
            : DateTime.parse(json["date_exam"]),
        timeStart: json["time_start"],
        timeEnd: json["time_end"],
        quizMinute: json["quiz_minute"],
        degree: json["degree"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        questions: json["questions"] == null
            ? []
            : List<Questions>.from(
                json["questions"]!.map((x) => Questions.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "date_exam":
            "${dateExam!.year.toString().padLeft(4, '0')}-${dateExam!.month.toString().padLeft(2, '0')}-${dateExam!.day.toString().padLeft(2, '0')}",
        "time_start": timeStart,
        "time_end": timeEnd,
        "quiz_minute": quizMinute,
        "degree": degree,
        "created_at":
            "${createdAt!.year.toString().padLeft(4, '0')}-${createdAt!.month.toString().padLeft(2, '0')}-${createdAt!.day.toString().padLeft(2, '0')}",
        "updated_at":
            "${updatedAt!.year.toString().padLeft(4, '0')}-${updatedAt!.month.toString().padLeft(2, '0')}-${updatedAt!.day.toString().padLeft(2, '0')}",
        "questions": questions == null
            ? []
            : List<dynamic>.from(questions!.map((x) => x.toJson())),
      };
}
