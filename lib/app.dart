import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:elmazoon/core/utils/toast_message_method.dart';
import 'package:elmazoon/feature/splash/presentation/cubit/splash_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:screenshot_callback/screenshot_callback.dart';

import 'core/preferences/preferences.dart';
import 'core/utils/app_colors.dart';
import 'core/utils/app_routes.dart';
import 'core/utils/app_strings.dart';
import 'package:elmazoon/injector.dart' as injector;
import 'dart:developer' as developer;
import 'package:path/path.dart';
import 'package:no_screenshot/no_screenshot.dart';

import 'feature/downloads_videos/cubit/downloads_videos_cubit.dart';
import 'feature/exam/cubit/exam_cubit.dart';
import 'feature/examRegister/cubit/exam_register_cubit.dart';
import 'feature/exam_degree_detials/cubit/exam_degree_cubit.dart';
import 'feature/exam_hero/cubit/exam_hero_cubit.dart';
import 'feature/live_exam/cubit/live_exam_cubit.dart';
import 'feature/login/cubit/login_cubit.dart';
import 'feature/mainscreens/guide_page/cubit/guide_cubit.dart';
import 'feature/mainscreens/homePage/cubit/home_page_cubit.dart';
import 'feature/mainscreens/notificationpage/cubit/notification_cubit.dart';
import 'feature/mainscreens/profilePage/cubit/profile_cubit.dart';
import 'feature/mainscreens/study_page/cubit/study_page_cubit.dart';
import 'feature/month_plan/cubit/month_plan_cubit.dart';
import 'feature/mydegree/cubit/my_degree_cubit.dart';
import 'feature/navigation_bottom/cubit/navigation_cubit.dart';
import 'feature/payment/cubit/payment_cubit.dart';

class Elmazoon extends StatefulWidget {
  const Elmazoon({Key? key}) : super(key: key);

  @override
  State<Elmazoon> createState() => _ElmazoonState();
}

class _ElmazoonState extends State<Elmazoon> {
  ConnectivityResult _connectionStatus = ConnectivityResult.none;

  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;
  // late ScreenshotCallback screenshotCallback;
  // final _noScreenshot = NoScreenshot.instance;
  // screenshotsOff() async{
  //   await _noScreenshot.screenshotOff();
  //
  //   // print('screenshots Off');
  // }
  // String text = "Ready..";
  @override
  void initState() {
    // screenshotsOff();
    super.initState();

    initConnectivity();

    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen((event) {
      if (event.index == 4) {
        toastMessage(
          'no_internet_connection'.tr(),
          context,
          color: AppColors.error,
        );
      } else if (event == 1 || event == 3) {
        toastMessage(
          'internet_connection'.tr(),
          context,
          color: AppColors.success,
        );
      }
      _updateConnectionStatus(event);
    });
    // init();
  }

//   void init() async {
//     await initScreenshotCallback();
//   }
//
//   //It must be created after permission is granted.
//   Future<void> initScreenshotCallback() async {
//     screenshotCallback = ScreenshotCallback();
// screenshotCallback.initialize();
//
// print("D;d;lelekle");
//     screenshotCallback.addListener(() {
//       setState(() {
//         text = "Screenshot callback Fired!";
//       });
//     });
//
//     screenshotCallback.addListener(() {
//       print("We can add multiple listeners ");
//     });
//   }


  @override
  void dispose() {
    // screenshotCallback.dispose();
    _connectivitySubscription.cancel();
    super.dispose();
  }

  Future<void> initConnectivity() async {
    late ConnectivityResult result;
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      developer.log('Couldn\'t check connectivity status', error: e);
      return;
    }
    if (!mounted) {
      return Future.value(null);
    }
    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    setState(() {
      _connectionStatus = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    // print(text);

    Preferences.instance.savedLang(
      EasyLocalization.of(context)!.locale.languageCode,
    );
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => injector.serviceLocator<SplashCubit>(),
        ),
        BlocProvider(
          create: (_) => injector.serviceLocator<LoginCubit>(),
        ),
        BlocProvider(
          create: (_) => injector.serviceLocator<StudyPageCubit>(),
        ),
        BlocProvider(
          create: (_) => injector.serviceLocator<NotificationCubit>(),
        ),
        BlocProvider(
          create: (_) => injector.serviceLocator<ProfileCubit>(),
        ),
        BlocProvider(
          create: (_) => injector.serviceLocator<ExamRegisterCubit>(),
        ),
        BlocProvider(
          create: (_) => injector.serviceLocator<MonthPlanCubit>(),
        ),
        BlocProvider(
          create: (_) => injector.serviceLocator<ExamCubit>(),
        ),
        BlocProvider(
          create: (_) => injector.serviceLocator<NavigationCubit>(),
        ),
        BlocProvider(
          create: (_) => injector.serviceLocator<HomePageCubit>(),
        ),
        BlocProvider(
          create: (_) => injector.serviceLocator<MyDegreeCubit>(),
        ),
        BlocProvider(
          create: (_) => injector.serviceLocator<GuideCubit>(),
        ),
        BlocProvider(
          create: (_) => injector.serviceLocator<ExamDegreeCubit>(),
        ),
        BlocProvider(
          create: (_) => injector.serviceLocator<PaymentCubit>(),
        ),
        BlocProvider(
          create: (_) => injector.serviceLocator<ExamHeroCubit>(),
        ),
        BlocProvider(
          create: (_) => injector.serviceLocator<DownloadsVideosCubit>(),
        ),
        BlocProvider(
          create: (_) => injector.serviceLocator<LiveExamCubit>(),
        ),
      ],
      child: MaterialApp(
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        theme: ThemeData(fontFamily: 'Cairo'),
        localizationsDelegates: context.localizationDelegates,
        debugShowCheckedModeBanner: false,
        title: AppStrings.appName,
        onGenerateRoute: AppRoutes.onGenerateRoute,
      ),
    );
  }
}
