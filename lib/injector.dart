import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/api/app_interceptors.dart';
import 'core/api/base_api_consumer.dart';
import 'core/api/dio_consumer.dart';
import 'core/remote/service.dart';
import 'feature/exam/cubit/exam_cubit.dart';
import 'feature/examRegister/cubit/exam_register_cubit.dart';
import 'feature/login/cubit/login_cubit.dart';
import 'feature/mainscreens/homePage/cubit/home_page_cubit.dart';
import 'feature/mainscreens/profilePage/cubit/profile_cubit.dart';
import 'feature/mainscreens/notificationpage/cubit/notification_cubit.dart';
import 'feature/mainscreens/study_page/cubit/study_page_cubit.dart';
import 'feature/month_plan/cubit/month_plan_cubit.dart';
import 'feature/navigation_bottom/cubit/navigation_cubit.dart';
import 'feature/splash/presentation/cubit/splash_cubit.dart';

final serviceLocator = GetIt.instance;

Future<void> setup() async {
  //! Features

  ///////////////////////// Blocs ////////////////////////

  serviceLocator.registerFactory(
    () => SplashCubit(),
  );
  serviceLocator.registerFactory(
    () => LoginCubit(serviceLocator()),
  );
  serviceLocator.registerFactory(
    () => StudyPageCubit(serviceLocator()),
  );
  serviceLocator.registerFactory(
    () => ProfileCubit(serviceLocator()),
  );
  serviceLocator.registerFactory(
    () => NotificationCubit(serviceLocator()),
  );
  serviceLocator.registerFactory(
    () => ExamRegisterCubit(serviceLocator()),
  );
  serviceLocator.registerFactory(
    () => MonthPlanCubit(serviceLocator()),
  );
  serviceLocator.registerFactory(
    () => ExamCubit(serviceLocator()),
  );
  serviceLocator.registerFactory(
    () => NavigationCubit(),
  );
  serviceLocator.registerFactory(
    () => HomePageCubit(serviceLocator()),
  );
  ///////////////////////////////////////////////////////////////////////////////

  //! External
  // Shared Preferences
  final sharedPreferences = await SharedPreferences.getInstance();
  serviceLocator.registerLazySingleton(() => sharedPreferences);

  serviceLocator.registerLazySingleton(() => ServiceApi(serviceLocator()));

  serviceLocator.registerLazySingleton<BaseApiConsumer>(
      () => DioConsumer(client: serviceLocator()));
  serviceLocator.registerLazySingleton(() => AppInterceptors());

  // Dio
  serviceLocator.registerLazySingleton(
    () => Dio(
      BaseOptions(
        contentType: "application/x-www-form-urlencoded",
        headers: {
          "Accept": "application/json",
          'Content-Type': 'application/x-www-form-urlencoded',
        },
      ),
    ),
  );
  serviceLocator.registerLazySingleton(
    () => LogInterceptor(
      request: true,
      requestBody: true,
      requestHeader: true,
      responseBody: true,
      responseHeader: true,
      error: true,
    ),
  );
}
