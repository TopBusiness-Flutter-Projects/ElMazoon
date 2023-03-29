// To parse this JSON data, do
//
//     final notificationsModel = notificationsModelFromJson(jsonString);

import 'dart:convert';

NotificationsModel notificationsModelFromJson(String str) =>
    NotificationsModel.fromJson(json.decode(str));

String notificationsModelToJson(NotificationsModel data) =>
    json.encode(data.toJson());

class NotificationsModel {
  NotificationsModel({
    this.data,
  });

  List<NotificationModel>? data;

  factory NotificationsModel.fromJson(Map<String, dynamic> json) =>
      NotificationsModel(
        data: List<NotificationModel>.from(
            json["data"].map((x) => NotificationModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class NotificationModel {
  NotificationModel({
    this.id,
    this.title,
    this.body,
    this.type,
    this.image,
    this.updatedAt,
    this.createdAt,
  });

  int? id;

  String? title;
  String? body;
  String? type;
  String? image;
  String? createdAt;
  String? updatedAt;

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      NotificationModel(
        id: json["id"],
        title: json["title"] != null ? json["title"] : '',
        body: json["body"] != null ? json["body"] : '',
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "body": body,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}
