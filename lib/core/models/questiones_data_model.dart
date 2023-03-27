import 'package:elmazoon/core/models/question_model.dart';

class QuestionsDataModel {
  QuestionData? data;
  String? message;
  int? code;

  QuestionsDataModel({this.data, this.message, this.code});

  QuestionsDataModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new QuestionData.fromJson(json['data']) : null;
    message = json['message'];
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['message'] = this.message;
    data['code'] = this.code;
    return data;
  }
}

class QuestionData {
  int? id;
  String? name;
  String? note;
  int? quizMinute;
  List<Questions> questions=[];

  QuestionData({this.id, this.name, this.note, this.quizMinute});

  QuestionData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    note = json['note'];
    quizMinute = json['quiz_minute'];
    if (json['questions'] != null) {
      questions = [];
      json['questions'].forEach((v) {
        questions.add(new Questions.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['note'] = this.note;
    data['quiz_minute'] = this.quizMinute;
    if (this.questions != null) {
      data['questions'] = this.questions!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}


