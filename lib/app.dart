import 'package:elmazoon/feature/splash/presentation/cubit/splash_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';

import 'core/preferences/preferences.dart';
import 'core/utils/app_routes.dart';
import 'core/utils/app_strings.dart';
import 'package:elmazoon/injector.dart' as injector;

import 'feature/login/cubit/login_cubit.dart';
import 'feature/mainscreens/notificationpage/cubit/notification_cubit.dart';
import 'feature/mainscreens/study_page/cubit/study_page_cubit.dart';

class Elmazoon extends StatefulWidget {
  const Elmazoon({Key? key}) : super(key: key);

  @override
  State<Elmazoon> createState() => _ElmazoonState();
}

class _ElmazoonState extends State<Elmazoon> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // print(",kkk");

    //EasyLocalization.of(context)!.setLocale(const Locale('ar'));
     print( EasyLocalization.of(context)!.locale.languageCode);
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
      ],
      child: MaterialApp(
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        localizationsDelegates: context.localizationDelegates,
        debugShowCheckedModeBanner: false,
        title: AppStrings.appName,
        onGenerateRoute: AppRoutes.onGenerateRoute,
      ),
    );
  }
}
