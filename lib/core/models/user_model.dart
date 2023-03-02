// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

UserModel userModelFromJson(String str) =>
    UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  UserModel({
    this.data,
    this.message,
    this.code,
  });

  User? data;
  String? message;
  int? code;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        data:json["data"]!=null? User.fromJson(json["data"]):null,
        message: json["message"],
        code: json["code"],
      );

  Map<String, dynamic> toJson() => {
        "data": data!.toJson(),
        "message": message,
        "code": code,
      };
}

class User {
  User({
    required this.id,
    required this.name,
    this.email,
    required this.phone,
    required this.fatherPhone,
    required this.image,
    required this.userStatus,
    required this.code,
    required this.dateStartCode,
    required this.dateEndCode,
     this.country,
    required this.token,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  String name;
  dynamic email;
  String phone;
  String fatherPhone;
  String image;
  String userStatus;
  String code;
  DateTime dateStartCode;
  DateTime dateEndCode;
  Country? country;
  String token;
  DateTime createdAt;
  DateTime updatedAt;

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    phone: json["phone"]??'no phone',
    fatherPhone: json["father_phone"]??'no father phone',
    image: json["image"],
    userStatus: json["user_status"]??'no status',
    code: json["code"]??'no code',
    dateStartCode: json["date_start_code"]!=null?DateTime.parse(json["date_start_code"]):DateTime(2022),
    dateEndCode:json["date_end_code"]!=null? DateTime.parse(json["date_end_code"]):DateTime(2022),
    country:json["country"]!=null? Country.fromJson(json["country"]):null,
    token: json["token"]??'',
    createdAt:json["created_at"]!=null? DateTime.parse(json["created_at"]):DateTime(2020),
    updatedAt:json["updated_at"]!=null? DateTime.parse(json["updated_at"]):DateTime(2020),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "phone": phone,
    "father_phone": fatherPhone,
    "image": image,
    "user_status": userStatus,
    "code": code,
    "date_start_code": "${dateStartCode.year.toString().padLeft(4, '0')}-${dateStartCode.month.toString().padLeft(2, '0')}-${dateStartCode.day.toString().padLeft(2, '0')}",
    "date_end_code": "${dateEndCode.year.toString().padLeft(4, '0')}-${dateEndCode.month.toString().padLeft(2, '0')}-${dateEndCode.day.toString().padLeft(2, '0')}",
    "country": country!.toJson(),
    "token": token,
    "created_at": "${createdAt.year.toString().padLeft(4, '0')}-${createdAt.month.toString().padLeft(2, '0')}-${createdAt.day.toString().padLeft(2, '0')}",
    "updated_at": "${updatedAt.year.toString().padLeft(4, '0')}-${updatedAt.month.toString().padLeft(2, '0')}-${updatedAt.day.toString().padLeft(2, '0')}",
  };
}

class Country {
  Country({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  String name;
  DateTime createdAt;
  DateTime updatedAt;

  factory Country.fromJson(Map<String, dynamic> json) => Country(
    id: json["id"],
    name: json["name"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "created_at": "${createdAt.year.toString().padLeft(4, '0')}-${createdAt.month.toString().padLeft(2, '0')}-${createdAt.day.toString().padLeft(2, '0')}",
    "updated_at": "${updatedAt.year.toString().padLeft(4, '0')}-${updatedAt.month.toString().padLeft(2, '0')}-${updatedAt.day.toString().padLeft(2, '0')}",
  };
}