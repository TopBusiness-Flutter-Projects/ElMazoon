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

  Future<Either<Failure, LessonsClassModel>> getLessonsByClassId(int id) async {
    UserModel userModel = await Preferences.instance.getUserModel();
    try {
      final response = await dio.get(
        EndPoints.lessonsByClassIdUrl + id.toString(),
        options: Options(
          headers: {
            'Authorization': userModel.data!.token,
          },
        ),
      );
      return Right(LessonsClassModel.fromJson(response));
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
}
