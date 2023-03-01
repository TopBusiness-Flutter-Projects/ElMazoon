// To parse this JSON data, do
//
//     final commentsModel = commentsModelFromJson(jsonString);

import 'dart:convert';

import 'package:elmazoon/core/models/user_model.dart';


CommentsModel commentsModelFromJson(String str) => CommentsModel.fromJson(json.decode(str));

String commentsModelToJson(CommentsModel data) => json.encode(data.toJson());

class CommentsModel {
  CommentsModel({
    required this.comments,
    required this.message,
    required this.code,
  });

  Comments comments;
  String message;
  int code;

  factory CommentsModel.fromJson(Map<String, dynamic> json) => CommentsModel(
    comments: Comments.fromJson(json["comments"]),
    message: json["message"],
    code: json["code"],
  );

  Map<String, dynamic> toJson() => {
    "comments": comments.toJson(),
    "message": message,
    "code": code,
  };
}

class Comments {
  Comments({
    required this.comment,
    required this.links,
  });

  List<CommentDatum> comment;
  Links links;

  factory Comments.fromJson(Map<String, dynamic> json) => Comments(
    comment: List<CommentDatum>.from(json["data"].map((x) => CommentDatum.fromJson(x))),
    links: Links.fromJson(json["links"]),
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(comment.map((x) => x.toJson())),
    "links": links.toJson(),
  };
}

class CommentDatum {
  CommentDatum({
     this.id,
     this.comment,
     this.audio,
     this.image,
     this.type,
     this.user,
     this.replies,
     this.createdAt,
     this.updatedAt,
  });

  int? id;
  String? comment;
  String? audio;
  String? image;
  String? type;
  User? user;
  List<dynamic>? replies;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory CommentDatum.fromJson(Map<String, dynamic> json) => CommentDatum(
    id: json["id"],
    comment: json["comment"],
    audio: json["audio"],
    image: json["image"],
    type: json["type"],
    user: User.fromJson(json["user"]),
    replies: List<dynamic>.from(json["replies"].map((x) => x)),
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "comment": comment,
    "audio": audio,
    "image": image,
    "type": type,
    "user": user!.toJson(),
    "replies": List<dynamic>.from(replies!.map((x) => x)),
    "created_at": "${createdAt!.year.toString().padLeft(4, '0')}-${createdAt!.month.toString().padLeft(2, '0')}-${createdAt!.day.toString().padLeft(2, '0')}",
    "updated_at": "${updatedAt!.year.toString().padLeft(4, '0')}-${updatedAt!.month.toString().padLeft(2, '0')}-${updatedAt!.day.toString().padLeft(2, '0')}",
  };
}
class Links {
  Links({
    required this.first,
    required this.last,
    required this.prev,
    required this.next,
  });

  String first;
  String last;
  String prev;
  String next;

  factory Links.fromJson(Map<String, dynamic> json) => Links(
    first: json["first"]??'',
    last: json["last"]??'',
    prev: json["prev"]??'',
    next: json["next"]??'',
  );
  Map<String, dynamic> toJson() => {
    "first": first,
    "last": last,
    "prev": prev,
    "next": next,
  };
}
