import 'package:elmazoon/core/models/response_message.dart';

import 'comments_model.dart';

class OneComment {
  final CommentDatum oneComment;
  final StatusResponse response;

  OneComment({required this.oneComment, required this.response});

  factory OneComment.fromJson(Map<String, dynamic> json) => OneComment(
        oneComment: CommentDatum.fromJson(json["data"]),
        response: StatusResponse.fromJson(json),
      );

  Map<String, dynamic> toJson() => {
        "data": oneComment.toJson(),
      };
}