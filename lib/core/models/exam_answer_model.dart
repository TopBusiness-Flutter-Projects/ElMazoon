import 'lessons_details_model.dart';

class ExamAnswerModel {
  ExamAnswerModel({
    this.data,
    this.message,
    this.code,
  });

  ExamDataModel? data;
  String? message;
  int? code;

  factory ExamAnswerModel.fromJson(Map<String, dynamic> json) => ExamAnswerModel(
    data: json["data"] == null ? null : ExamDataModel.fromJson(json["data"]),
    message: json["message"],
    code: json["code"],
  );

  Map<String, dynamic> toJson() => {
    "data": data?.toJson(),
    "message": message,
    "code": code,
  };
}

class ExamDataModel {
  ExamDataModel({
    this.id,
    this.name,
    this.note,
    this.depends,
    this.seasonId,
    this.termId,
    this.createdAt,
    this.updatedAt,
    this.instruction,
  });

  int? id;
  String? name;
  String? note;
  String? depends;
  int? seasonId;
  int? termId;
  DateTime? createdAt;
  DateTime? updatedAt;
  Instruction? instruction;

  factory ExamDataModel.fromJson(Map<String, dynamic> json) => ExamDataModel(
    id: json["id"],
    name: json["name"]??'',
    note: json["note"],
    depends: json["depends"],
    seasonId: json["season_id"],
    termId: json["term_id"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    instruction: json["instruction"] == null ? null : Instruction.fromJson(json["instruction"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "note": note,
    "depends": depends,
    "season_id": seasonId,
    "term_id": termId,
    "created_at": "${createdAt!.year.toString().padLeft(4, '0')}-${createdAt!.month.toString().padLeft(2, '0')}-${createdAt!.day.toString().padLeft(2, '0')}",
    "updated_at": "${updatedAt!.year.toString().padLeft(4, '0')}-${updatedAt!.month.toString().padLeft(2, '0')}-${updatedAt!.day.toString().padLeft(2, '0')}",
    "instruction": instruction?.toJson(),
  };
}

