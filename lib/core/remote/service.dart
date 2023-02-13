import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../api/base_api_consumer.dart';
import '../api/end_points.dart';
import '../error/exceptions.dart';
import '../error/failures.dart';
import '../models/login_model.dart';
import '../models/response_message.dart';
import '../utils/app_strings.dart';

class ServiceApi {
  final BaseApiConsumer dio;

  ServiceApi(this.dio);

  Future<Either<Failure, LoginModel>> postLogin(String phone) async {
    try {
      final response = await dio.post(
        EndPoints.loginUrl,
        body: {
          'phone': phone,
          'phone_code': AppStrings.phoneCode,
        },
      );
      return Right(LoginModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

}
