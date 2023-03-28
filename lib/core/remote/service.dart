import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:elmazoon/core/models/guide_model.dart';
import 'package:elmazoon/core/models/home_page_model.dart';
import 'package:elmazoon/core/models/my_degree_model.dart';
import 'package:elmazoon/core/preferences/preferences.dart';
import 'package:elmazoon/feature/mainscreens/study_page/models/all_classes_model.dart';

import '../../feature/exam/models/answer_exam_model.dart';
import '../../feature/login/models/communication_model.dart';
import '../../feature/payment/model/pay_model.dart';
import '../../feature/payment/model/payment_response_model.dart';
import '../api/base_api_consumer.dart';
import '../api/end_points.dart';
import '../error/exceptions.dart';
import '../error/failures.dart';
import '../models/ads_model.dart';
import '../models/comments_model.dart';
import '../models/degree_detials_model.dart';
import '../models/exam_answer_model.dart';
import '../models/exam_hero_model.dart';
import '../models/exam_model.dart';
import '../models/lessons_details_model.dart';
import '../models/live_exam_model.dart';
import '../models/month_plan_model.dart';
import '../models/one_comment_model.dart';
import '../models/questiones_data_model.dart';
import '../models/response_message.dart';
import '../models/notifications_model.dart';
import '../models/status_response_model.dart';
import '../models/subscribes_model.dart';
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
          headers: {'Accept-Language': lan},
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

  Future<Either<Failure, OneComment>> updateCommentAndReply(
    int commentId,
    String type,
    String comment,
  ) async {
    UserModel loginModel = await Preferences.instance.getUserModel();
    try {
      final response = await dio.post(
        type == 'comment'
            ? EndPoints.updateCommentUrl + commentId.toString()
            : EndPoints.updateReplyUrl + commentId.toString(),
        body: {
          'type': 'text',
          'comment': comment,
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

  Future<Either<Failure, StatusResponse>> deleteComment(int commentId) async {
    UserModel loginModel = await Preferences.instance.getUserModel();
    try {
      final response = await dio.delete(
        EndPoints.deleteCommentUrl + commentId.toString(),
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

  Future<Either<Failure, StatusResponse>> deleteReply(int replyId) async {
    UserModel loginModel = await Preferences.instance.getUserModel();
    try {
      final response = await dio.delete(
        EndPoints.deleteReplayUrl + replyId.toString(),
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

  Future<Either<Failure, QuestionsDataModel>> getQuestion(
      int exam_id, String exam_type) async {
    UserModel userModel = await Preferences.instance.getUserModel();
    String lan = await Preferences.instance.getSavedLang();
    print('lan : $lan');
    try {
      final response = await dio.get(
        EndPoints.questionsUrl + "${exam_id}",
        queryParameters: {"exam_type": exam_type},
        options: Options(
          headers: {
            'Authorization': userModel.data!.token,
            'Accept-Language': lan
          },
        ),
      );
      return Right(QuestionsDataModel.fromJson(response));
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
        EndPoints.monthPlanUrl,
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
      {required String type, required int id}) async {
    UserModel loginModel = await Preferences.instance.getUserModel();
    try {
      final response = await dio.post(
        '${EndPoints.openFirstVideoUrl}$id',
        queryParameters: {
          'type': type,
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
      {required String type, required int id}) async {
    UserModel loginModel = await Preferences.instance.getUserModel();
    try {
      final response = await dio.post(
        '${EndPoints.openNextVideoUrl}$id',
        body: {
          'status': 'watched',
        },
        queryParameters: {
          'type': type,
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
      {required int exma_id, required int time_id}) async {
    UserModel loginModel = await Preferences.instance.getUserModel();
    String lan = await Preferences.instance.getSavedLang();

    try {
      final response = await dio.post(
        EndPoints.registerExamUrl + exma_id.toString(),
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

  Future<Either<Failure, UserModel>> updateProfile(
      {required String imagePath}) async {
    UserModel loginModel = await Preferences.instance.getUserModel();
    try {
      final response = await dio.post(
        EndPoints.updateProfileUrl,
        formDataIsEnabled: true,
        body: {"image": await MultipartFile.fromFile(imagePath)},
        options: Options(headers: {'Authorization': loginModel.data!.token}),
      );
      return Right(UserModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, StatusResponse>> updateAcessTime(
      {required int exam_id, required int time, required String type}) async {
    UserModel loginModel = await Preferences.instance.getUserModel();
    try {
      final response = await dio.post(
        EndPoints.updateAccessTimeUrl + exam_id.toString(),
        formDataIsEnabled: false,
        body: {"type": type, "timer": time},
        options: Options(headers: {'Authorization': loginModel.data!.token}),
      );
      return Right(StatusResponse.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, HomePageModel>> getHomePageData() async {
    UserModel loginModel = await Preferences.instance.getUserModel();
    String lan = await Preferences.instance.getSavedLang();
    try {
      final response = await dio.get(
        EndPoints.homePageUrl,
        options: Options(headers: {
          'Authorization': loginModel.data!.token,
          'Accept-Language': lan
        }),
      );
      return Right(HomePageModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, MyDegreeModel>> getMyDegreeData() async {
    UserModel loginModel = await Preferences.instance.getUserModel();
    String lan = await Preferences.instance.getSavedLang();
    try {
      final response = await dio.get(
        EndPoints.myDegreeUrl,
        options: Options(headers: {
          'Authorization': loginModel.data!.token,
          'Accept-Language': lan
        }),
      );
      return Right(MyDegreeModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, GuideModel>> getGuideData() async {
    UserModel loginModel = await Preferences.instance.getUserModel();
    String lan = await Preferences.instance.getSavedLang();
    try {
      final response = await dio.get(
        EndPoints.guideUrl,
        options: Options(headers: {
          'Authorization': loginModel.data!.token,
          'Accept-Language': lan
        }),
      );
      return Right(GuideModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, ExamAnswerModel>> answerExam(
      {required QuestionData questionData,
      required AnswerExamModel answerExamModel,
      required int time,
      required String type}) async {
    UserModel loginModel = await Preferences.instance.getUserModel();
    Map<String, dynamic> fields = {"exam_type": type, "timer": time};
    for (int i = 0; i < questionData.questions.length; i++) {
      fields.addAll(
          {"details[$i][question]": questionData.questions[i].id.toString()});
      if (answerExamModel.audio[i].isNotEmpty) {
        fields.addAll({
          "details[$i][audio]":
              await MultipartFile.fromFile(answerExamModel.audio[i])
        });
        fields.addAll({"details[$i][image]": ''});
      } else if (answerExamModel.image[i].isNotEmpty) {
        fields.addAll({
          "details[$i][image]":
              await MultipartFile.fromFile(answerExamModel.image[i])
        });
        fields.addAll({"details[$i][audio]": ''});
      }
      if (answerExamModel.answer[i].isNotEmpty) {
        fields.addAll({"details[$i][answer]": answerExamModel.answer[i]});
      } else {
        fields.addAll({"details[$i][answer]": ''});
      }
    }

    try {
      final response = await dio.post(
        EndPoints.answerExamUrl + questionData.id.toString(),
        formDataIsEnabled: true,
        options: Options(headers: {'Authorization': loginModel.data!.token}),
        body: fields,
      );

      return Right(ExamAnswerModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, AdsModel>> getAppAds() async {
    try {
      final response = await dio.get(EndPoints.adsUrl);
      return Right(AdsModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, SubscribesModel>> getSubscribesPayment() async {
    UserModel loginModel = await Preferences.instance.getUserModel();
    String lan = await Preferences.instance.getSavedLang();
    try {
      final response = await dio.get(
        EndPoints.subscribesUrl,
        options: Options(
          headers: {
            'Authorization': loginModel.data!.token,
            'Accept-Language': lan
          },
        ),
      );
      return Right(SubscribesModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, DegreeDetails>> getDegreeDetails(
      {required int exam_id, required String exam_type}) async {
    UserModel loginModel = await Preferences.instance.getUserModel();
    String lan = await Preferences.instance.getSavedLang();

    try {
      final response = await dio.get(
        EndPoints.degreeDetialsUrl,
        queryParameters: {'exam_type': exam_type, 'id': exam_id},
        options: Options(
          headers: {
            'Authorization': loginModel.data!.token,
            'Accept-Language': lan
          },
        ),
      );
      return Right(DegreeDetails.fromJson(response));
    } on ServerException {
      print(DioErrorType.response);
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, ExamHeroModel>> getExamHeroes() async {
    UserModel loginModel = await Preferences.instance.getUserModel();
    String lan = await Preferences.instance.getSavedLang();
    try {
      final response = await dio.get(
        EndPoints.examHeroUrl,
        options: Options(
          headers: {
            'Authorization': loginModel.data!.token,
            'Accept-Language': lan
          },
        ),
      );
      return Right(ExamHeroModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, PaymentResponse>> paySubscribes(
      SendPayModel sendPayModel) async {
    UserModel loginModel = await Preferences.instance.getUserModel();
    String lan = await Preferences.instance.getSavedLang();
    try {
      final response = await dio.post(
        EndPoints.paySubscribesUrl,
        body: sendPayModel.toJson(),
        options: Options(
          headers: {
            'Authorization': loginModel.data!.token,
            'Accept-Language': lan
          },
        ),
      );
      return Right(PaymentResponse.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, LiveExamModel>> getFirstLiveExamQuestion(
      int examId) async {
    UserModel loginModel = await Preferences.instance.getUserModel();
    String lan = await Preferences.instance.getSavedLang();
    try {
      final response = await dio.get(
          EndPoints.accessFirstLiveExamQuestionUrl + examId.toString(),
          options: Options(
            headers: {
              'Authorization': loginModel.data!.token,
              'Accept-Language': lan
            },
          ));
      return Right(LiveExamModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, LiveExamModel>> answerLiveExamQuestion({
    required int examId,
    required int questionId,
    required int answerId,
  }) async {
    UserModel loginModel = await Preferences.instance.getUserModel();
    String lan = await Preferences.instance.getSavedLang();
    try {
      final response = await dio.post(
        EndPoints.answerLiveExamQuestionUrl + examId.toString(),
        body: {
          'question_id': questionId,
          'answer_id': answerId,
        },
        options: Options(
          headers: {
            'Authorization': loginModel.data!.token,
            'Accept-Language': lan
          },
        ),
      );
      return Right(LiveExamModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
