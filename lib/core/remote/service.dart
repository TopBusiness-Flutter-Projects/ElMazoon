import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:elmazoon/core/preferences/preferences.dart';
import 'package:elmazoon/feature/mainscreens/study_page/models/all_classes_model.dart';

import '../../feature/login/models/communication_model.dart';
import '../api/base_api_consumer.dart';
import '../api/end_points.dart';
import '../error/exceptions.dart';
import '../error/failures.dart';
import '../models/comments_model.dart';
import '../models/exam_model.dart';
import '../models/lessons_details_model.dart';
import '../models/month_plan_model.dart';
import '../models/one_comment_model.dart';
import '../models/questiones_data_model.dart';
import '../models/response_message.dart';
import '../models/notifications_model.dart';
import '../models/status_response_model.dart';
import '../models/times_model.dart';
import '../models/user_model.dart';

class ServiceApi {
  final BaseApiConsumer dio;

  ServiceApi(this.dio);

  Future<Either<Failure, UserModel>> postUser(String code) async {
    String lan = await Preferences.instance.getSavedLang();
    try {
      final response = await dio.post(
        EndPoints.userUrl,
        body: {
          'code': code,
        },
        options: Options(
          headers: {
            'Accept-Language': lan
          },
        ),
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
        formDataIsEnabled: true,
        EndPoints.addCommentUrl + lessonId.toString(),
        body: {
          'type': type,
          if (comment != null) ...{
            'comment': comment,
          },
          if (image != null) ...{
            'image': await MultipartFile.fromFile(image),
          },
          if (audio != null) ...{
            'audio': await MultipartFile.fromFile(audio),
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

  Future<Either<Failure, OneComment>> addReply(
    int commentId,
    String type, {
    String? replay,
    String? image,
    String? audio,
  }) async {
    UserModel loginModel = await Preferences.instance.getUserModel();
    try {
      final response = await dio.post(
        formDataIsEnabled: true,
        EndPoints.addReplyUrl + commentId.toString(),
        body: {
          'type': type,
          if (replay != null) ...{
            'replay': replay,
          },
          if (image != null) ...{
            'image': await MultipartFile.fromFile(image),
          },
          if (audio != null) ...{
            'audio': await MultipartFile.fromFile(audio),
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
  Future<Either<Failure, TimeDataModel>> gettimes() async {
    UserModel userModel = await Preferences.instance.getUserModel();
    String lan = await Preferences.instance.getSavedLang();
    try {
      final response = await dio.get(
        EndPoints.timesUrl,
        options: Options(
          headers: {
            'Authorization': userModel.data!.token,
            'Accept-Language': lan
          },
        ),
      );
      return Right(TimeDataModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }
  Future<Either<Failure, QuestionesDataModel>> getQuestion(int exam_id) async {
    UserModel userModel = await Preferences.instance.getUserModel();
    String lan = await Preferences.instance.getSavedLang();
    print('lan : $lan');
    try {
      final response = await dio.get(
        EndPoints.questionsUrl+"${exam_id}",
        options: Options(
          headers: {
            'Authorization': userModel.data!.token,
            'Accept-Language': lan
          },
        ),
      );
      return Right(QuestionesDataModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }
  Future<Either<Failure, MothPlanModel>> getMonthPlans() async {
    UserModel userModel = await Preferences.instance.getUserModel();
    String lan = await Preferences.instance.getSavedLang();
    print('lan : $lan');
    try {
      final response = await dio.get(
        EndPoints.monthplanUrl,
        options: Options(
          headers: {
            'Authorization': userModel.data!.token,
            'Accept-Language': lan
          },
        ),
      );
      return Right(MothPlanModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, StatusResponse>> openFirstVideo(
      {required String status, required int id}) async {
    UserModel loginModel = await Preferences.instance.getUserModel();
    try {
      final response = await dio.post(
        '${EndPoints.openFirstVideoUrl}$id',
        body: {
          'status': status,
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

  Future<Either<Failure, StatusResponse>> openNextVideo(
      {required int id}) async {
    UserModel loginModel = await Preferences.instance.getUserModel();
    try {
      final response = await dio.post(
        '${EndPoints.openNextVideoUrl}$id',
        body: {
          'status': 'watched',
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
  Future<Either<Failure, ExamModel>> registerExam(
      {required int exma_id,required int time_id}) async {
    UserModel loginModel = await Preferences.instance.getUserModel();
    String lan = await Preferences.instance.getSavedLang();

    try {
      final response = await dio.post(
        EndPoints.registerExamUrl+exma_id.toString(),
        body: {
          'papel_sheet_exam_time_id': time_id,
        },
        options: Options(
          headers: {
            'Authorization': loginModel.data!.token,
            'Accept-Language': lan
          },
        ),
      );
      return Right(ExamModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
