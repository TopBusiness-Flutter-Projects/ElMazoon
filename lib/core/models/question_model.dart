import 'answer_model.dart';

class Questions {
  int? id;
  String? question;
  String status='';
  String type='text';
  String answer='';
  String? note;
  List<Answers>? answers;
  String? createdAt;
  String? updatedAt;

  Questions(
      {this.id,
        this.question,
        this.note,
        this.answers,
        this.createdAt,
        this.updatedAt});

  Questions.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    question = json['question'];
    note = json['note'];
    if (json['answers'] != null) {
      answers = [];
      json['answers'].forEach((v) {
        answers!.add(new Answers.fromJson(v));
      });
    }
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['question'] = this.question;
    data['note'] = this.note;
    if (this.answers != null) {
      data['answers'] = this.answers!.map((v) => v.toJson()).toList();
    }
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
