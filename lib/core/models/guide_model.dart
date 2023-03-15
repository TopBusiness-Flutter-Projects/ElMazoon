// To parse this JSON data, do
//
//     final guideModel = guideModelFromJson(jsonString);

import 'dart:convert';

GuideModel guideModelFromJson(String str) => GuideModel.fromJson(json.decode(str));

String guideModelToJson(GuideModel data) => json.encode(data.toJson());

class GuideModel {
  GuideModel({
    this.data,
    this.message,
    this.code,
  });

  List<GuideDatum>? data;
  String? message;
  int? code;

  factory GuideModel.fromJson(Map<String, dynamic> json) => GuideModel(
    data: json["data"] == null ? [] : List<GuideDatum>.from(json["data"]!.map((x) => GuideDatum.fromJson(x))),
    message: json["message"],
    code: json["code"],
  );

  Map<String, dynamic> toJson() => {
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    "message": message,
    "code": code,
  };
}

class GuideDatum {
  GuideDatum({
    this.id,
    this.title,
    this.description,
    this.createdAt,
    this.innerItems,
  });

  int? id;
  String? title;
  String? description;
  DateTime? createdAt;
  List<InnerItem>? innerItems;

  factory GuideDatum.fromJson(Map<String, dynamic> json) => GuideDatum(
    id: json["id"],
    title: json["title"],
    description: json["description"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    innerItems: json["inner_items"] == null ? [] : List<InnerItem>.from(json["inner_items"]!.map((x) => InnerItem.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "description": description,
    "created_at": "${createdAt!.year.toString().padLeft(4, '0')}-${createdAt!.month.toString().padLeft(2, '0')}-${createdAt!.day.toString().padLeft(2, '0')}",
    "inner_items": innerItems == null ? [] : List<dynamic>.from(innerItems!.map((x) => x.toJson())),
  };
}

class InnerItem {
  InnerItem({
    this.id,
    this.title,
    this.filePath,
    this.createdAt,
  });

  int? id;
  String? title;
  String? filePath;
  DateTime? createdAt;

  factory InnerItem.fromJson(Map<String, dynamic> json) => InnerItem(
    id: json["id"],
    title: json["title"],
    filePath: json["file_path"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "file_path": filePath,
    "created_at": "${createdAt!.year.toString().padLeft(4, '0')}-${createdAt!.month.toString().padLeft(2, '0')}-${createdAt!.day.toString().padLeft(2, '0')}",
  };
}
