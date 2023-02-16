import 'package:elmazoon/feature/auth/login/presentation/screens/login.dart';
import 'package:elmazoon/feature/examRegister/presentation/screens/exam_register.dart';
import 'package:flutter/material.dart';

import '../../core/utils/app_strings.dart';
import '../../feature/mydegree/presentation/screens/mydegree.dart';
import '../../feature/splash/presentation/screens/splash_screen.dart';

class Routes {
  static const String initialRoute = '/';
  static const String loginRoute = '/login';
  static const String myDegreeRoute = '/mydegree';
  static const String examRegisterRoute = '/examregister';
  static const String verificationScreenRoute = '/verificationScreen';
  static const String homePageScreenRoute = '/homePageScreen';
  static const String paymentRoute = '/paymentRoute';

}

class AppRoutes {
  static String route = '';

  static Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.initialRoute:
        return MaterialPageRoute(
          builder: (context) => const SplashScreen(),
        );
        case Routes.loginRoute:
        return MaterialPageRoute(
          builder: (context) => const LoginScreen(),
        );
      case Routes.examRegisterRoute:
        return MaterialPageRoute(
          builder: (context) => const ExmRegisterPage(),
        );
        case Routes.myDegreeRoute:
        return MaterialPageRoute(
          builder: (context) => const MyDegreePage(),
        );
      default:
        return undefinedRoute();
    }
  }

  static Route<dynamic> undefinedRoute() {
    return MaterialPageRoute(
      builder: (context) => const Scaffold(
        body: Center(
          child: Text(AppStrings.noRouteFound),
        ),
      ),
    );
  }
}
