import 'exam_answer_model.dart';

class DegreeDetails {
  DegreeDetails({
    this.data,
    this.details,
    this.ordered,
    this.degree,
    this.timer,
    this.numberMistake,
    this.tryingNumberAgain,
  });

  Data? data;
  ExamDataModel? details;
  int? ordered;
  int? degree;
  String? timer;
  int? numberMistake;
  int? tryingNumberAgain;

  factory DegreeDetails.fromJson(Map<String, dynamic> json) => DegreeDetails(
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
    details: json["details"] == null ? ExamDataModel() : ExamDataModel.fromJson(json["details"]),
    ordered: json["ordered"],
    degree: json["degree"],
    timer: json["timer"],
    numberMistake: json["number_mistake"],
    tryingNumberAgain: json["trying_number_again"],
  );

  Map<String, dynamic> toJson() => {
    "data": data?.toJson(),
    "details": details?.toJson(),
    "ordered": ordered,
    "degree": degree,
    "timer": timer,
    "number_mistake": numberMistake,
    "trying_number_again": tryingNumberAgain,
  };
}

class Data {
  Data({
    this.users,
  });

  List<User>? users;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    users: json["users"] == null ? [] : List<User>.from(json["users"]!.map((x) => User.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "users": users == null ? [] : List<dynamic>.from(users!.map((x) => x.toJson())),
  };
}

class User {
  User({
    this.id,
    this.name,
    this.image,
    this.percentage,
  });

  int? id;
  String? name;
  String? image;
  String? percentage;

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    name: json["name"],
    image: json["image"],
    percentage: json["percentage"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "image": image,
    "percentage": percentage,
  };
}


