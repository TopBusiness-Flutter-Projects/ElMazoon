class AnswerExamModel {
  AnswerExamModel({
    required this.answer,
    required this.audio,
    required this.image,
  });

  List<String> answer = [];
  List<String> audio = [];
  List<String> image = [];

  factory AnswerExamModel.fromJson(Map<String, dynamic> json) =>
      AnswerExamModel(
        answer: json["answer"] != null
            ? List<String>.from(json["answer"].map((x) => x))
            : [],
        audio: json["audio"] != null
            ? List<String>.from(json["audio"].map((x) => x))
            : [],
        image: json["image"] != null
            ? List<String>.from(json["image"].map((x) => x))
            : [],
      );

  Map<String, dynamic> toJson() => {
        "answer": List<dynamic>.from(answer.map((x) => x)),
        "audio": List<dynamic>.from(audio.map((x) => x)),
        "image": List<dynamic>.from(image.map((x) => x)),
      };
}
