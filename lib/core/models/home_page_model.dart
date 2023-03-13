import 'dart:convert';

import '../../feature/mainscreens/study_page/models/all_classes_model.dart';
import 'notifications_model.dart';

HomePageModel homePageModelFromJson(String str) => HomePageModel.fromJson(json.decode(str));

String homePageModelToJson(HomePageModel data) => json.encode(data.toJson());

class HomePageModel {
  HomePageModel({
    required this.data,
    required this.code,
    required this.message,
  });

  Data data;
  int code;
  String message;

  factory HomePageModel.fromJson(Map<String, dynamic> json) => HomePageModel(
    data: Data.fromJson(json["data"]),
    code: json["code"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "data": data.toJson(),
    "code": code,
    "message": message,
  };
}

class Data {
  Data({
    required this.sliders,
    required this.notification,
    required this.classes,
  });

  List<SliderModel> sliders;
  NotificationModel notification;
  List<ClassLessons> classes;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    sliders: List<SliderModel>.from(json["sliders"].map((x) => SliderModel.fromJson(x))),
    notification: NotificationModel.fromJson(json["notification"]),
    classes: List<ClassLessons>.from(json["classes"].map((x) => ClassLessons.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "sliders": List<dynamic>.from(sliders.map((x) => x.toJson())),
    "notification": notification.toJson(),
    "classes": List<dynamic>.from(classes.map((x) => x.toJson())),
  };
}
class SliderModel {
  SliderModel({
    required this.id,
    required this.image,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  String image;
  DateTime createdAt;
  DateTime updatedAt;

  factory SliderModel.fromJson(Map<String, dynamic> json) => SliderModel(
    id: json["id"],
    image: json["image"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "image": image,
    "created_at": "${createdAt.year.toString().padLeft(4, '0')}-${createdAt.month.toString().padLeft(2, '0')}-${createdAt.day.toString().padLeft(2, '0')}",
    "updated_at": "${updatedAt.year.toString().padLeft(4, '0')}-${updatedAt.month.toString().padLeft(2, '0')}-${updatedAt.day.toString().padLeft(2, '0')}",
  };
}
