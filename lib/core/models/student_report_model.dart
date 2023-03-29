// To parse this JSON data, do
//
//     final studentReportModel = studentReportModelFromJson(jsonString);

import 'dart:convert';

StudentReportModel studentReportModelFromJson(String str) => StudentReportModel.fromJson(json.decode(str));

String studentReportModelToJson(StudentReportModel data) => json.encode(data.toJson());

class StudentReportModel {
  StudentReportModel({
    this.data,
    this.message,
    this.code,
  });

  final Data? data;
  final String? message;
  final int? code;

  factory StudentReportModel.fromJson(Map<String, dynamic> json) => StudentReportModel(
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
    message: json["message"],
    code: json["code"],
  );

  Map<String, dynamic> toJson() => {
    "data": data?.toJson(),
    "message": message,
    "code": code,
  };
}

class Data {
  Data({
    this.user,
    this.exams,
    this.papelSheet,
  });

  final User? user;
  final List<Exam>? exams;
  final List<Exam>? papelSheet;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    user: json["user"] == null ? null : User.fromJson(json["user"]),
    exams: json["exams"] == null ? [] : List<Exam>.from(json["exams"]!.map((x) => Exam.fromJson(x))),
    papelSheet: json["papel_sheet"] == null ? [] : List<Exam>.from(json["papel_sheet"]!.map((x) => Exam.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "user": user?.toJson(),
    "exams": exams == null ? [] : List<dynamic>.from(exams!.map((x) => x.toJson())),
    "papel_sheet": papelSheet == null ? [] : List<dynamic>.from(papelSheet!.map((x) => x.toJson())),
  };
}

class Exam {
  Exam({
    this.id,
    this.exam,
    this.fullDegree,
    this.per,
  });

  final int? id;
  final String? exam;
  final String? fullDegree;
  final String? per;

  factory Exam.fromJson(Map<String, dynamic> json) => Exam(
    id: json["id"],
    exam: json["exam"],
    fullDegree: json["full_degree"],
    per: json["per"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "exam": exam,
    "full_degree": fullDegree,
    "per": per,
  };
}

class User {
  User({
    this.id,
    this.name,
    this.phone,
    this.season,
    this.term,
    this.country,
    this.fatherPhone,
    this.image,
  });

  final int? id;
  final String? name;
  final String? phone;
  final Season? season;
  final Season? term;
  final Country? country;
  final String? fatherPhone;
  final String? image;

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    name: json["name"],
    phone: json["phone"],
    season: json["season"] == null ? null : Season.fromJson(json["season"]),
    term: json["term"] == null ? null : Season.fromJson(json["term"]),
    country: json["country"] == null ? null : Country.fromJson(json["country"]),
    fatherPhone: json["father_phone"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "phone": phone,
    "season": season?.toJson(),
    "term": term?.toJson(),
    "country": country?.toJson(),
    "father_phone": fatherPhone,
    "image": image,
  };
}

class Country {
  Country({
    this.id,
    this.nameAr,
    this.nameEn,
    this.createdAt,
    this.updatedAt,
  });

  final int? id;
  final String? nameAr;
  final String? nameEn;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory Country.fromJson(Map<String, dynamic> json) => Country(
    id: json["id"],
    nameAr: json["name_ar"],
    nameEn: json["name_en"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name_ar": nameAr,
    "name_en": nameEn,
    "created_at": "${createdAt!.year.toString().padLeft(4, '0')}-${createdAt!.month.toString().padLeft(2, '0')}-${createdAt!.day.toString().padLeft(2, '0')}",
    "updated_at": "${updatedAt!.year.toString().padLeft(4, '0')}-${updatedAt!.month.toString().padLeft(2, '0')}-${updatedAt!.day.toString().padLeft(2, '0')}",
  };
}

class Season {
  Season({
    this.id,
    this.nameAr,
    this.nameEn,
    this.status,
  });

  final int? id;
  final String? nameAr;
  final String? nameEn;
  final String? status;

  factory Season.fromJson(Map<String, dynamic> json) => Season(
    id: json["id"],
    nameAr: json["name_ar"],
    nameEn: json["name_en"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name_ar": nameAr,
    "name_en": nameEn,
    "status": status,
  };
}
