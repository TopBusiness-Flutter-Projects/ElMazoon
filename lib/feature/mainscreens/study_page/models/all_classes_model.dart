// To parse this JSON data, do
//
//     final allClassesModel = allClassesModelFromJson(jsonString);

import 'dart:convert';

import '../../../../core/models/lessons_details_model.dart';

AllClassesModel allClassesModelFromJson(String str) => AllClassesModel.fromJson(json.decode(str));

String allClassesModelToJson(AllClassesModel data) => json.encode(data.toJson());

class AllClassesModel {
  AllClassesModel({
    required this.data,
  });

  AllClassesDatum data;

  factory AllClassesModel.fromJson(Map<String, dynamic> json) => AllClassesModel(
    data: AllClassesDatum.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "data": data.toJson(),
  };
}

class AllClassesDatum {
  AllClassesDatum({
    required this.classes,
    required this.fullExams,
    required this.code,
    required this.message,
  });

  List<ClassLessons> classes;
  List<FullExam> fullExams;
  int code;
  String message;

  factory AllClassesDatum.fromJson(Map<String, dynamic> json) => AllClassesDatum(
    classes: List<ClassLessons>.from(json["classes"].map((x) => ClassLessons.fromJson(x))),
    fullExams: List<FullExam>.from(json["fullExams"].map((x) => FullExam.fromJson(x))),
    code: json["code"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "classes": List<dynamic>.from(classes.map((x) => x.toJson())),
    "fullExams": List<dynamic>.from(fullExams.map((x) => x.toJson())),
    "code": code,
    "message": message,
  };
}

class ClassLessons {
  ClassLessons({
    required this.id,
    required this.name,
    required this.image,
    required this.lessons,
    required this.exams,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  String name;
  String image;
  List<Lesson> lessons;
  List<Exam> exams;
  DateTime createdAt;
  DateTime updatedAt;

  factory ClassLessons.fromJson(Map<String, dynamic> json) => ClassLessons(
    id: json["id"],
    name: json["name"],
    image: json["image"],
    lessons: List<Lesson>.from(json["lessons"].map((x) => Lesson.fromJson(x))),
    exams: List<Exam>.from(json["exams"].map((x) => Exam.fromJson(x))),
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "image": image,
    "lessons": List<dynamic>.from(lessons.map((x) => x.toJson())),
    "exams": List<dynamic>.from(exams.map((x) => x.toJson())),
    "created_at": "${createdAt.year.toString().padLeft(4, '0')}-${createdAt.month.toString().padLeft(2, '0')}-${createdAt.day.toString().padLeft(2, '0')}",
    "updated_at": "${updatedAt.year.toString().padLeft(4, '0')}-${updatedAt.month.toString().padLeft(2, '0')}-${updatedAt.day.toString().padLeft(2, '0')}",
  };
}


class Lesson {
  Lesson({
    required this.id,
    required this.name,
    required this.note,
    required this.videosCount,
    required this.videosTime,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  String name;
  String note;
  int videosCount;
  int videosTime;
  DateTime createdAt;
  DateTime updatedAt;

  factory Lesson.fromJson(Map<String, dynamic> json) => Lesson(
    id: json["id"],
    name: json["name"],
    note: json["note"],
    videosCount: json["videos_count"],
    videosTime: json["videos_time"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "note": note,
    "videos_count": videosCount,
    "videos_time": videosTime,
    "created_at": "${createdAt.year.toString().padLeft(4, '0')}-${createdAt.month.toString().padLeft(2, '0')}-${createdAt.day.toString().padLeft(2, '0')}",
    "updated_at": "${updatedAt.year.toString().padLeft(4, '0')}-${updatedAt.month.toString().padLeft(2, '0')}-${updatedAt.day.toString().padLeft(2, '0')}",
  };
}

class FullExam {
  FullExam({
    required this.id,
    required this.name,
    required this.note,
    required this.createdAt,
    required this.updatedAt,
    this.instruction,
  });

  int id;
  String name;
  String note;
  DateTime createdAt;
  DateTime updatedAt;
  Instruction? instruction;

  factory FullExam.fromJson(Map<String, dynamic> json) => FullExam(
    id: json["id"],
    name: json["name"],
    note: json["note"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    instruction: json["instruction"] == null ? null : Instruction.fromJson(json["instruction"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "note": note,
    "created_at": "${createdAt.year.toString().padLeft(4, '0')}-${createdAt.month.toString().padLeft(2, '0')}-${createdAt.day.toString().padLeft(2, '0')}",
    "updated_at": "${updatedAt.year.toString().padLeft(4, '0')}-${updatedAt.month.toString().padLeft(2, '0')}-${updatedAt.day.toString().padLeft(2, '0')}",
    "instruction": instruction?.toJson(),
  };
}

