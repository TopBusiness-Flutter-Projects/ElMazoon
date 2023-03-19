// To parse this JSON data, do
//
//     final adsModel = adsModelFromJson(jsonString);

import 'dart:convert';

AdsModel adsModelFromJson(String str) => AdsModel.fromJson(json.decode(str));

String adsModelToJson(AdsModel data) => json.encode(data.toJson());

class AdsModel {
  AdsModel({
    this.data,
    this.message,
    this.code,
  });

  List<AdsModelDatum>? data;
  String? message;
  int? code;

  factory AdsModel.fromJson(Map<String, dynamic> json) => AdsModel(
    data: json["data"] == null ? [] : List<AdsModelDatum>.from(json["data"]!.map((x) => AdsModelDatum.fromJson(x))),
    message: json["message"],
    code: json["code"],
  );

  Map<String, dynamic> toJson() => {
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    "message": message,
    "code": code,
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
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "link": link,
    "type": type,
    "file_path": filePath,
    "created_at": "${createdAt!.year.toString().padLeft(4, '0')}-${createdAt!.month.toString().padLeft(2, '0')}-${createdAt!.day.toString().padLeft(2, '0')}",
  };
}
