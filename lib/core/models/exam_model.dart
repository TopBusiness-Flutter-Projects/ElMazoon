import 'TimeModel.dart';

class ExamModel{
  Data? data;
  String? message;
  int? code;
  String? dateExam;
  String? address;
  String? sectionName;

  ExamModel(
      {this.data,
        this.message,
        this.code,
        this.dateExam,
        this.address,
        this.sectionName});

  ExamModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    message = json['message'];
    code = json['code'];
    dateExam = json['date_exam'];
    address = json['address'];
    sectionName = json['section_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['message'] = this.message;
    data['code'] = this.code;
    data['date_exam'] = this.dateExam;
    data['address'] = this.address;
    data['section_name'] = this.sectionName;
    return data;
  }
}

class Data {
  Exam? exam;

  Data({this.exam});

  Data.fromJson(Map<String, dynamic> json) {
    exam = json['exam'] != null ? new Exam.fromJson(json['exam']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.exam != null) {
      data['exam'] = this.exam!.toJson();
    }
    return data;
  }
}

class Exam {
  int? id;
  String? name;
  String? description;
  String? from;
  String? to;
  String? dateExam;
  Time? time;
  String? createdAt;
  String? updatedAt;

  Exam(
      {this.id,
        this.name,
        this.description,
        this.from,
        this.to,
        this.dateExam,
        this.time,
        this.createdAt,
        this.updatedAt});

  Exam.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    from = json['from'];
    to = json['to'];
    dateExam = json['date_exam'];
    time = json['time'] != null ? new Time.fromJson(json['time']) : null;
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['from'] = this.from;
    data['to'] = this.to;
    data['date_exam'] = this.dateExam;
    if (this.time != null) {
      data['time'] = this.time!.toJson();
    }
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

