// To parse this JSON data, do
//
//     final liveExamModel = liveExamModelFromJson(jsonString);

import 'dart:convert';

import 'answer_model.dart';

LiveExamModel liveExamModelFromJson(String str) =>
    LiveExamModel.fromJson(json.decode(str));

String liveExamModelToJson(LiveExamModel data) => json.encode(data.toJson());

class LiveExamModel {
  LiveExamModel({
    this.liveExamDatum,
    this.message,
    this.code,
    this.degree,
    this.pre,
  });

  final LiveExamDatum? liveExamDatum;
  final String? message;
  final int? code;
  final int? degree;
  final String? pre;

  factory LiveExamModel.fromJson(Map<String, dynamic> json) => LiveExamModel(
        liveExamDatum:
            json["data"] == null ? null : LiveExamDatum.fromJson(json["data"]),
        message: json["message"],
        code: json["code"],
        degree: json["code"] == 201 ? json["degree"] : 0,
        pre: json["code"] == 201 ? json["per"] : '',
      );

  Map<String, dynamic> toJson() => {
        "data": liveExamDatum?.toJson(),
        "message": message,
        "code": code,
      };
}

class LiveExamDatum {
  LiveExamDatum({
    this.id,
    this.question,
    this.questionType,
    this.fileType,
    this.degree,
    this.note,
    this.remainingTime,
    this.answers,
  });

  final int? id;
  final String? question;
  final String? questionType;
  final String? fileType;
  final int? degree;
  final String? note;
  final int? remainingTime;
  final List<Answers>? answers;

  factory LiveExamDatum.fromJson(Map<String, dynamic> json) => LiveExamDatum(
        id: json["id"],
        question: json["question"],
        questionType: json["question_type"],
        fileType: json["file_type"],
        degree: json["degree"],
        note: json["note"],
        remainingTime: json["remaining_time"],
        answers: json["answers"] == null
            ? []
            : List<Answers>.from(
                json["answers"]!.map((x) => Answers.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "question": question,
        "question_type": questionType,
        "file_type": fileType,
        "degree": degree,
        "note": note,
        "remaining_time": remainingTime,
        "answers": answers == null
            ? []
            : List<dynamic>.from(answers!.map((x) => x.toJson())),
      };
}
