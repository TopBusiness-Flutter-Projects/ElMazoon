// To parse this JSON data, do
//
//     final lessonsDetailsModel = lessonsDetailsModelFromJson(jsonString);

import 'dart:convert';

LessonsDetailsModel lessonsDetailsModelFromJson(String str) => LessonsDetailsModel.fromJson(json.decode(str));

String lessonsDetailsModelToJson(LessonsDetailsModel data) => json.encode(data.toJson());

class LessonsDetailsModel {
  LessonsDetailsModel({
    required this.data,
    required this.message,
    required this.code,
  });

  LessonsDetailsData data;
  String message;
  int code;

  factory LessonsDetailsModel.fromJson(Map<String, dynamic> json) => LessonsDetailsModel(
    data: LessonsDetailsData.fromJson(json["data"]),
    message: json["message"],
    code: json["code"],
  );

  Map<String, dynamic> toJson() => {
    "data": data.toJson(),
    "message": message,
    "code": code,
  };
}

class LessonsDetailsData {
  LessonsDetailsData({
    required this.videos,
    required this.exams,
  });

  List<Lessons> videos;
  List<Exam> exams;

  factory LessonsDetailsData.fromJson(Map<String, dynamic> json) => LessonsDetailsData(
    videos: List<Lessons>.from(json["videos"].map((x) => Lessons.fromJson(x))),
    exams: List<Exam>.from(json["exams"].map((x) => Exam.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "videos": List<dynamic>.from(videos.map((x) => x.toJson())),
    "exams": List<dynamic>.from(exams.map((x) => x.toJson())),
  };
}

class Exam {
  Exam({
    required this.id,
    required this.name,
    required this.note,
    required this.seasonId,
    required this.termId,
    required this.createdAt,
    required this.updatedAt,
    this.instruction,
  });

  int id;
  String name;
  String note;
  int seasonId;
  int termId;
  DateTime createdAt;
  DateTime updatedAt;
  Instruction? instruction;

  factory Exam.fromJson(Map<String, dynamic> json) => Exam(
    id: json["id"],
    name: json["name"],
    note: json["note"],
    seasonId: json["season_id"],
    termId: json["term_id"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    instruction: json["instruction"] == null ? null : Instruction.fromJson(json["instruction"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "note": note,
    "season_id": seasonId,
    "term_id": termId,
    "created_at": "${createdAt.year.toString().padLeft(4, '0')}-${createdAt.month.toString().padLeft(2, '0')}-${createdAt.day.toString().padLeft(2, '0')}",
    "updated_at": "${updatedAt.year.toString().padLeft(4, '0')}-${updatedAt.month.toString().padLeft(2, '0')}-${updatedAt.day.toString().padLeft(2, '0')}",
    "instruction": instruction?.toJson(),
  };
}

class Instruction {
  Instruction({
    required this.id,
    required this.instruction,
    required this.tryingNumber,
    required this.numberOfQuestion,
    required this.quizMinute,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  String instruction;
  int tryingNumber;
  int numberOfQuestion;
  String quizMinute;
  DateTime createdAt;
  DateTime updatedAt;

  factory Instruction.fromJson(Map<String, dynamic> json) => Instruction(
    id: json["id"],
    instruction: json["instruction"],
    tryingNumber: json["trying_number"],
    numberOfQuestion: json["number_of_question"],
    quizMinute: json["quiz_minute"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "instruction": instruction,
    "trying_number": tryingNumber,
    "number_of_question": numberOfQuestion,
    "quiz_minute": quizMinute,
    "created_at": "${createdAt.year.toString().padLeft(4, '0')}-${createdAt.month.toString().padLeft(2, '0')}-${createdAt.day.toString().padLeft(2, '0')}",
    "updated_at": "${updatedAt.year.toString().padLeft(4, '0')}-${updatedAt.month.toString().padLeft(2, '0')}-${updatedAt.day.toString().padLeft(2, '0')}",
  };
}

class Lessons {
  Lessons({
    required this.id,
    required this.name,
    required this.note,
    required this.link,
    required this.type,
    required this.ordered,
    required this.status,
    required this.videoTime,
    required this.createdAt,
    required this.updatedAt,
    required this.exams,
  });

  int id;
  String name;
  String note;
  String link;
  String type;
  int ordered;
  String status;
  int videoTime;
  DateTime createdAt;
  DateTime updatedAt;
  List<Exam> exams;

  factory Lessons.fromJson(Map<String, dynamic> json) => Lessons(
    id: json["id"],
    name: json["name"],
    note: json["note"],
    link: json["link"],
    type: json["type"],
    ordered: json["ordered"],
    status: json["status"],
    videoTime: json["video_time"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    exams: List<Exam>.from(json["exams"].map((x) => Exam.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "note": note,
    "link": link,
    "type": type,
    "ordered": ordered,
    "status": status,
    "video_time": videoTime,
    "created_at": "${createdAt.year.toString().padLeft(4, '0')}-${createdAt.month.toString().padLeft(2, '0')}-${createdAt.day.toString().padLeft(2, '0')}",
    "updated_at": "${updatedAt.year.toString().padLeft(4, '0')}-${updatedAt.month.toString().padLeft(2, '0')}-${updatedAt.day.toString().padLeft(2, '0')}",
    "exams": List<dynamic>.from(exams.map((x) => x.toJson())),
  };
}
