
import 'package:elmazoon/feature/splash/presentation/cubit/splash_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';

import 'core/utils/app_colors.dart';
import 'core/utils/app_routes.dart';
import 'core/utils/app_strings.dart';
import 'package:elmazoon/injector.dart' as injector;


class Elmazoon extends StatefulWidget {
  const Elmazoon({Key? key}) : super(key: key);

  @override
  State<Elmazoon> createState() => _ElmazoonState();
}

class _ElmazoonState extends State<Elmazoon> {

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(

      SystemUiOverlayStyle(
        statusBarColor: AppColors.transparent,

      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) =>
              injector.serviceLocator<SplashCubit>(),
        ),
      ],
      child: MaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      debugShowCheckedModeBanner: false,
      title: AppStrings.appName,
      onGenerateRoute: AppRoutes.onGenerateRoute,
    ),
    );
  }
}