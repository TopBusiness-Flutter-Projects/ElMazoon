import 'dart:convert';

MyDegreeModel myDegreeModelFromJson(String str) =>
    MyDegreeModel.fromJson(json.decode(str));

String myDegreeModelToJson(MyDegreeModel data) => json.encode(data.toJson());

class MyDegreeModel {
  MyDegreeModel({
    this.myDegreeModelData,
    this.message,
    this.code,
  });

  MyDegreeModelData? myDegreeModelData;
  String? message;
  int? code;

  factory MyDegreeModel.fromJson(Map<String, dynamic> json) => MyDegreeModel(
        myDegreeModelData: json["data"] == null
            ? null
            : MyDegreeModelData.fromJson(json["data"]),
        message: json["message"],
        code: json["code"],
      );

  Map<String, dynamic> toJson() => {
        "data": myDegreeModelData?.toJson(),
        "message": message,
        "code": code,
      };
}

class MyDegreeModelData {
  MyDegreeModelData({
    this.partialExams,
    this.allExams,
    this.exams,
    this.papelSheet,
  });

  List<ExamDetailsModel>? partialExams;
  List<ExamDetailsModel>? allExams;
  List<ExamDetailsModel>? exams;
  List<ExamDetailsModel>? papelSheet;

  factory MyDegreeModelData.fromJson(Map<String, dynamic> json) =>
      MyDegreeModelData(
        partialExams: json["videos"] == null
            ? []
            : List<ExamDetailsModel>.from(
                json["videos"]!.map((x) => ExamDetailsModel.fromJson(x))),
        allExams: json["all_exams"] == null
            ? []
            : List<ExamDetailsModel>.from(
                json["all_exams"]!.map((x) => ExamDetailsModel.fromJson(x))),
        exams: json["subject_classes"] == null
            ? []
            : List<ExamDetailsModel>.from(json["subject_classes"]!
                .map((x) => ExamDetailsModel.fromJson(x))),
        papelSheet: json["papel_sheet"] == null
            ? []
            : List<ExamDetailsModel>.from(json["papel_sheet"]!
                .map((x) => ExamDetailsModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "videos": partialExams == null
            ? []
            : List<dynamic>.from(partialExams!.map((x) => x.toJson())),
        "all_exams": allExams == null
            ? []
            : List<dynamic>.from(allExams!.map((x) => x.toJson())),
        "subject_classes": exams == null
            ? []
            : List<dynamic>.from(exams!.map((x) => x.toJson())),
        "papel_sheet": papelSheet == null
            ? []
            : List<dynamic>.from(papelSheet!.map((x) => x.toJson())),
      };
}

class ExamDetailsModel {
  ExamDetailsModel({
    this.id,
    this.name,
    this.type,
    this.status,
    this.degree,
  });

  int? id;
  String? name;
  String? type;
  String? status;
  String? degree;

  factory ExamDetailsModel.fromJson(Map<String, dynamic> json) =>
      ExamDetailsModel(
        id: json["id"],
        name: json["name"],
        type: json["type"],
        status: json["status"],
        degree: json["degree"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "type": type,
        "status": status,
        "degree": degree,
      };
}
