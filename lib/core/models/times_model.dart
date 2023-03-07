// To parse this JSON data, do
//
//     final TimeDataModel = TimeDataModelFromJson(jsonString);

import 'dart:convert';

import 'TimeModel.dart';

TimeDataModel TimeDataModelFromJson(String str) => TimeDataModel.fromJson(json.decode(str));

String TimeDataModelToJson(TimeDataModel data) => json.encode(data.toJson());

class TimeDataModel {
  TimeDataModel({
    required this.data,
    required this.message,
    required this.code,
  });

  TimeDataData data;
  String message;
  int code;

  factory TimeDataModel.fromJson(Map<String, dynamic> json) => TimeDataModel(
    data: TimeDataData.fromJson(json["data"]),
    message: json["message"],
    code: json["code"],
  );

  Map<String, dynamic> toJson() => {
    "data": data.toJson(),
    "message": message,
    "code": code,
  };
}

class TimeDataData {
  TimeDataData({
    required this.times, required this.id, required this.name, required this.from, required this.to,
    required this.description
  });
  int id;
  String name;
  String description;
  String from;
  String to;
  List<Time> times;

  factory TimeDataData.fromJson(Map<String, dynamic> json) => TimeDataData(
    times: List<Time>.from(json["times"].map((x) => Time.fromJson(x))),
    id: json["id"],
    name: json["name"],
    from: json["from"],
    to:json["to"], description: json["description"],
  );

  Map<String, dynamic> toJson() => {
    "times": List<dynamic>.from(times.map((x) => x.toJson())),
    "id": id,
    "name": name,
    "from": from,
    "to": to,
    "description": description,
  };
}




