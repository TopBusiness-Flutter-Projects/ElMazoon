import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/api/app_interceptors.dart';
import 'core/api/base_api_consumer.dart';
import 'core/api/dio_consumer.dart';
import 'core/remote/service.dart';
import 'feature/downloads_videos/cubit/downloads_videos_cubit.dart';
import 'feature/exam/cubit/exam_cubit.dart';
import 'feature/examRegister/cubit/exam_register_cubit.dart';
import 'feature/exam_degree_detials/cubit/exam_degree_cubit.dart';
import 'feature/exam_hero/cubit/exam_hero_cubit.dart';
import 'feature/live_exam/cubit/live_exam_cubit.dart';
import 'feature/login/cubit/login_cubit.dart';
import 'feature/mainscreens/guide_page/cubit/guide_cubit.dart';
import 'feature/mainscreens/homePage/cubit/home_page_cubit.dart';
import 'feature/mainscreens/profilePage/cubit/profile_cubit.dart';
import 'feature/mainscreens/notificationpage/cubit/notification_cubit.dart';
import 'feature/mainscreens/study_page/cubit/study_page_cubit.dart';
import 'feature/month_plan/cubit/month_plan_cubit.dart';
import 'feature/mydegree/cubit/my_degree_cubit.dart';
import 'feature/navigation_bottom/cubit/navigation_cubit.dart';
import 'feature/payment/cubit/payment_cubit.dart';
import 'feature/splash/presentation/cubit/splash_cubit.dart';

final serviceLocator = GetIt.instance;

Future<void> setup() async {
  //! Features

  ///////////////////////// Blocs ////////////////////////

  serviceLocator.registerFactory(
    () => SplashCubit(
      serviceLocator(),
    ),
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
  serviceLocator.registerFactory(
    () => MyDegreeCubit(serviceLocator()),
  );
  serviceLocator.registerFactory(
    () => DownloadsVideosCubit(),
  );
  serviceLocator.registerFactory(
    () => GuideCubit(serviceLocator()),
  );
  serviceLocator.registerFactory(
    () => ExamDegreeCubit(serviceLocator()),
  );
  serviceLocator.registerFactory(
    () => PaymentCubit(serviceLocator()),
  );
  serviceLocator.registerFactory(
    () => ExamHeroCubit(serviceLocator()),
  );
  serviceLocator.registerFactory(
    () => LiveExamCubit(serviceLocator()),
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
