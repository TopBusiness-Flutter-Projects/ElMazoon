// To parse this JSON data, do
//
//     final TimeDataModel = TimeDataModelFromJson(jsonString);

import 'dart:convert';

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



class Time {
  Time({
    required this.id,
    required this.from,
    required this.to,
    required this.createdAt,
    required this.updatedAt,
  });


  int id;
  String from;
  String to;
  DateTime createdAt;
  DateTime updatedAt;

  factory Time.fromJson(Map<String, dynamic> json) => Time(
    id: json["id"],
    from: json["from"],
    to: json["to"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "from": from,
    "to": to,
    "created_at": "${createdAt.year.toString().padLeft(4, '0')}-${createdAt.month.toString().padLeft(2, '0')}-${createdAt.day.toString().padLeft(2, '0')}",
    "updated_at": "${updatedAt.year.toString().padLeft(4, '0')}-${updatedAt.month.toString().padLeft(2, '0')}-${updatedAt.day.toString().padLeft(2, '0')}",
  };
}
