import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:elmazoon/core/preferences/preferences.dart';
import 'package:elmazoon/feature/mainscreens/study_page/models/all_classes_model.dart';

import '../../feature/login/models/communication_model.dart';
import '../../feature/mainscreens/study_page/models/lessons_class_model.dart';
import '../api/base_api_consumer.dart';
import '../api/end_points.dart';
import '../error/exceptions.dart';
import '../error/failures.dart';
import '../models/comments_model.dart';
import '../models/lessons_details_model.dart';
import '../models/one_comment_model.dart';
import '../models/response_message.dart';
import '../models/notifications_model.dart';
import '../models/user_model.dart';
import '../utils/app_strings.dart';

class ServiceApi {
  final BaseApiConsumer dio;

  ServiceApi(this.dio);

  Future<Either<Failure, UserModel>> postuser(String code) async {
    try {
      final response = await dio.post(
        EndPoints.userUrl,
        body: {
          'code': code,
        },
      );
      print(response);
      return Right(UserModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, AllClassesModel>> getAllClasses() async {
    UserModel userModel = await Preferences.instance.getUserModel();
    String lan = await Preferences.instance.getSavedLang();
    print('lan : $lan');
    try {
      final response = await dio.get(
        EndPoints.allClassesUrl,
        options: Options(
          headers: {
            'Authorization': userModel.data!.token,
            'Accept-Language': lan
          },
        ),
      );
      return Right(AllClassesModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, NotificationsModel>> getAllNotification() async {
    UserModel userModel = await Preferences.instance.getUserModel();
    String lan = await Preferences.instance.getSavedLang();
    print('lan : $lan');
    try {
      final response = await dio.get(
        EndPoints.notificationUrl,
        options: Options(
          headers: {
            'Authorization': userModel.data!.token,
            'Accept-Language': lan
          },
        ),
      );
      return Right(NotificationsModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, LessonsDetailsModel>> getLessonsDetails(int id) async {
    UserModel loginModel = await Preferences.instance.getUserModel();
    try {
      final response = await dio.get(
        EndPoints.lessonsDetailsUrl + id.toString(),
        options: Options(
          headers: {
            'Authorization': loginModel.data!.token,
          },
        ),
      );
      return Right(LessonsDetailsModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, CommunicationModel>> getCommunicationData() async {
    try {
      final response = await dio.get(EndPoints.communicationUrl);
      return Right(CommunicationModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, StatusResponse>> sendSuggest(
      {required String suggest}) async {
    UserModel loginModel = await Preferences.instance.getUserModel();
    try {
      final response = await dio.post(
        EndPoints.suggestUrl,
        body: {
          'suggestion': suggest,
        },
        options: Options(
          headers: {
            'Authorization': loginModel.data!.token,
          },
        ),
      );
      return Right(StatusResponse.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, CommentsModel>> getCommentsByLesson(int id) async {
    UserModel loginModel = await Preferences.instance.getUserModel();
    try {
      final response = await dio.get(
        EndPoints.commentByLessonUrl + id.toString(),
        options: Options(
          headers: {
            'Authorization': loginModel.data!.token,
          },
        ),
      );
      return Right(CommentsModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, CommentsModel>> getMoreComments(
      String nextLink) async {
    UserModel loginModel = await Preferences.instance.getUserModel();
    try {
      final response = await dio.get(
        nextLink,
        options: Options(
          headers: {
            'Authorization': loginModel.data!.token,
          },
        ),
      );
      return Right(CommentsModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, OneComment>> addComment(
    int lessonId,
    String type, {
    String? comment,
    String? image,
    String? audio,
  }) async {
    UserModel loginModel = await Preferences.instance.getUserModel();
    try {
      final response = await dio.post(
        EndPoints.addCommentUrl + lessonId.toString(),
        body: {
          'type': type,
          if (comment != null) ...{
            'comment': comment,
          },
          if (image != null) ...{
            'image': image,
          },
          if (audio != null) ...{
            'audio': audio,
          },
        },
        options: Options(
          headers: {
            'Authorization': loginModel.data!.token,
          },
        ),
      );
      return Right(OneComment.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
