
import 'comments_model.dart';
import 'status_response_model.dart';

class OneComment {
  final CommentDatum oneComment;
  final StatusResponse response;

  OneComment({required this.oneComment, required this.response});

  factory OneComment.fromJson(Map<String, dynamic> json) => OneComment(
        oneComment:json["data"]!=null? CommentDatum.fromJson(json["data"]):CommentDatum(),
        response: StatusResponse.fromJson(json),
      );

  Map<String, dynamic> toJson() => {
        "data": oneComment.toJson(),
      };
}
