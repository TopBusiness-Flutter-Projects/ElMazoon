import 'package:elmazoon/core/models/question_model.dart';

import 'ads_model.dart';

class LiveQuestionsDataModel {
  LifeExam? data;
  String? message;
  int? code;

  LiveQuestionsDataModel({this.data, this.message, this.code});

  LiveQuestionsDataModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new LifeExam.fromJson(json['data']) : null;
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



