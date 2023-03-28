class Answers {
  int? id;
  String? answer;
  String? answerNumber;
  String? answerStatus;
  String status = '';
  String? createdAt;
  String? updatedAt;

  Answers({
    this.id,
    this.answer,
    this.answerNumber,
    this.answerStatus,
    this.createdAt,
    this.updatedAt,
  });

  Answers.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    answer = json['answer'];
    answerNumber = json['answer_number'];
    answerStatus = json['answer_status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['answer'] = this.answer;
    data['answer_number'] = this.answerNumber;
    data['answer_status'] = this.answerStatus;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
  @override
  String toString() {
    return '\n ## id : ${id} ,status : ${status} ,answer : ${answer} ## \n';
  }
}
