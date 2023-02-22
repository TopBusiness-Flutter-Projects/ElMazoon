
import 'dart:convert';

AllClassesModel allClassesModelFromJson(String str) => AllClassesModel.fromJson(json.decode(str));

String allClassesModelToJson(AllClassesModel data) => json.encode(data.toJson());

class AllClassesModel {
  AllClassesModel({
    required this.data,
    required this.message,
    required this.code,
  });

  List<AllClassesDatum> data;
  String message;
  int code;

  factory AllClassesModel.fromJson(Map<String, dynamic> json) => AllClassesModel(
    data: List<AllClassesDatum>.from(json["data"].map((x) => AllClassesDatum.fromJson(x))),
    message: json["message"],
    code: json["code"],
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "message": message,
    "code": code,
  };
}

class AllClassesDatum {
  AllClassesDatum({
    required this.id,
    required this.name,
    required this.image,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  String name;
  String image;
  DateTime createdAt;
  DateTime updatedAt;

  factory AllClassesDatum.fromJson(Map<String, dynamic> json) => AllClassesDatum(
    id: json["id"],
    name: json["name"],
    image: json["image"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "image": image,
    "created_at": "${createdAt.year.toString().padLeft(4, '0')}-${createdAt.month.toString().padLeft(2, '0')}-${createdAt.day.toString().padLeft(2, '0')}",
    "updated_at": "${updatedAt.year.toString().padLeft(4, '0')}-${updatedAt.month.toString().padLeft(2, '0')}-${updatedAt.day.toString().padLeft(2, '0')}",
  };
}
