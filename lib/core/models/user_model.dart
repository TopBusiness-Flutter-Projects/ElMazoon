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
    // required this.userType,
    required this.image,
    // required this.userStatus,
    required this.userStatus,
    required this.code,
    required this.dateStartCode,
    required this.dateEndCode,
    required this.token,
  });

  int id;
  String name;
  dynamic email;
  String phone;
  String fatherPhone;
  // String userType;
  String image;
  // String userStatus;
  String userStatus;
  String code;
  DateTime dateStartCode;
  DateTime dateEndCode;
  String token;
  late bool isLoggedIn = false;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"]??'no name',
        email: json["email"]??'no email',
        phone: json["phone"],
        fatherPhone: json["father_phone"],
        // userType: json["user_type"],
        image: json["image"],
        // userStatus: json["user_status"],
        userStatus: json["user_status"],
        code: json["code"],
        dateStartCode: DateTime.parse(json["date_start_code"]),
        dateEndCode: DateTime.parse(json["date_end_code"]),
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "phone": phone,
        "father_phone": fatherPhone,
        // "user_type": userType,
        "image": image,
        // "user_status": userStatus,
        "user_status": userStatus,
        "code": code,
        "date_start_code":
            "${dateStartCode.year.toString().padLeft(4, '0')}-${dateStartCode.month.toString().padLeft(2, '0')}-${dateStartCode.day.toString().padLeft(2, '0')}",
        "date_end_code":
            "${dateEndCode.year.toString().padLeft(4, '0')}-${dateEndCode.month.toString().padLeft(2, '0')}-${dateEndCode.day.toString().padLeft(2, '0')}",
        "token": token,
      };
}
