import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:elmazoon/core/preferences/preferences.dart';
import 'package:elmazoon/feature/mainscreens/study_page/models/all_classes_model.dart';

import '../../feature/mainscreens/study_page/models/lessons_class_model.dart';
import '../api/base_api_consumer.dart';
import '../api/end_points.dart';
import '../error/exceptions.dart';
import '../error/failures.dart';
import '../models/login_model.dart';
import '../utils/app_strings.dart';

class ServiceApi {
  final BaseApiConsumer dio;

  ServiceApi(this.dio);

  Future<Either<Failure, LoginModel>> postLogin(String code) async {
    try {
      final response = await dio.post(
        EndPoints.loginUrl,
        body: {
          'code': code,
        },
      );
      print(response);
      return Right(LoginModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, AllClassesModel>> getAllClasses() async {
    LoginModel loginModel = await Preferences.instance.getUserModel();
    String lan = await Preferences.instance.getSavedLang();
    try {
      final response = await dio.get(
        EndPoints.allClassesUrl,
        options: Options(
          headers: {
            'Authorization': loginModel.data!.token,
            'Accept-Language': lan
          },
        ),
      );
      return Right(AllClassesModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, LessonsClassModel>> getLessonsByClassId(int id) async {
    LoginModel loginModel = await Preferences.instance.getUserModel();
    try {
      final response = await dio.get(
        EndPoints.lessonsByClassIdUrl + id.toString(),
        options: Options(
          headers: {
            'Authorization': loginModel.data!.token,
          },
        ),
      );
      return Right(LessonsClassModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
