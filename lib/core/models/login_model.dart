// To parse this JSON data, do
//
//     final loginModel = loginModelFromJson(jsonString);

import 'dart:convert';

LoginModel loginModelFromJson(String str) =>
    LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
  LoginModel({
    this.data,
    this.message,
    this.code,
  });

  User? data;
  String? message;
  int? code;

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
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
    required this.nameAr,
    required this.nameEn,
    this.email,
    required this.phone,
    required this.fatherPhone,
    required this.userType,
    required this.image,
    required this.loginStatus,
    required this.userStatus,
    required this.code,
    required this.dateStartCode,
    required this.dateEndCode,
    required this.token,
  });

  int id;
  String nameAr;
  String nameEn;
  dynamic email;
  String phone;
  String fatherPhone;
  String userType;
  String image;
  String loginStatus;
  String userStatus;
  String code;
  DateTime dateStartCode;
  DateTime dateEndCode;
  String token;
  late bool isLoggedIn = false;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        nameAr: json["name_ar"],
        nameEn: json["name_en"],
        email: json["email"],
        phone: json["phone"],
        fatherPhone: json["father_phone"],
        userType: json["user_type"],
        image: json["image"],
        loginStatus: json["login_status"],
        userStatus: json["user_status"],
        code: json["code"],
        dateStartCode: DateTime.parse(json["date_start_code"]),
        dateEndCode: DateTime.parse(json["date_end_code"]),
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name_ar": nameAr,
        "name_en": nameEn,
        "email": email,
        "phone": phone,
        "father_phone": fatherPhone,
        "user_type": userType,
        "image": image,
        "login_status": loginStatus,
        "user_status": userStatus,
        "code": code,
        "date_start_code":
            "${dateStartCode.year.toString().padLeft(4, '0')}-${dateStartCode.month.toString().padLeft(2, '0')}-${dateStartCode.day.toString().padLeft(2, '0')}",
        "date_end_code":
            "${dateEndCode.year.toString().padLeft(4, '0')}-${dateEndCode.month.toString().padLeft(2, '0')}-${dateEndCode.day.toString().padLeft(2, '0')}",
        "token": token,
      };
}
