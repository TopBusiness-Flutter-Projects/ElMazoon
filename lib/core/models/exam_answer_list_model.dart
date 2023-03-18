import '../../feature/exam/models/answer_exam_model.dart';
import 'lessons_details_model.dart';

class ExamAnswerListModel {
  AnswerExamModel? answers;

  int id = 0;
  String time;

  ExamAnswerListModel({
    required this.answers,
    required this.id,
    required this.time,
  });

  factory ExamAnswerListModel.fromJson(Map<String, dynamic> json) =>
      ExamAnswerListModel(
          answers: json["answers"] == null
              ? null
              : AnswerExamModel.fromJson(json["answers"]),
          id: json["id"],
          time: json["time"]);

  Map<String, dynamic> toJson() => {
        "answers": answers?.toJson(),
        "id": id,
        "time": time,
      };
}
