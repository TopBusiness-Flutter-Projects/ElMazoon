import 'package:elmazoon/core/models/times_model.dart';
import 'package:elmazoon/feature/exam/presentation/screens/exam_page.dart';
import 'package:elmazoon/feature/exam_degree_detials/presentation/screens/exam_degree_detials.dart';
import 'package:elmazoon/feature/login/screens/login.dart';
import 'package:elmazoon/feature/examRegister/presentation/screens/exam_register.dart';
import 'package:elmazoon/feature/month_plan/presentation/screens/month_plan.dart';
import 'package:flutter/material.dart';

import '../../core/utils/app_strings.dart';
import '../../feature/confirm_exam_register/presentation/screens/confirm_exam_register.dart';
import '../../feature/login/screens/login.dart';
import '../../feature/mainscreens/profilePage/screens/suggest_screen.dart';
import '../../feature/monthplandetials/presentation/screens/month_plan_detials.dart';
import '../../feature/mydegree/screens/mydegree.dart';
import '../../feature/splash/presentation/screens/splash_screen.dart';
import '../models/exam_answer_model.dart';
import '../models/exam_model.dart';
import '../models/lessons_details_model.dart';
import '../models/month_plan_model.dart';

class Routes {
  static const String initialRoute = '/';
  static const String loginRoute = '/login';
  static const String myDegreeRoute = '/mydegree';
  static const String examRegisterRoute = '/examregister';
  static const String verificationScreenRoute = '/verificationScreen';
  static const String homePageScreenRoute = '/homePageScreen';
  static const String paymentRoute = '/paymentRoute';
  static const String suggestRoute = '/suggestRoute';
  static const String examRoute = '/examRoute';
  static const String examdegreeDetialsRoute = '/examdegreeDetialsRoute';
  static const String monthplansRoute = '/monthplansRoute';
  static const String monthplanDetialsRoute = '/monthplandetialsRoute';
  static const String confirmexamRegisterRoute = '/confirmexamregister';
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
      case Routes.monthplansRoute:
        return MaterialPageRoute(
          builder: (context) => const MonthPage(),
        );

      case Routes.examRegisterRoute:
        TimeDataModel timeDataModel = settings.arguments as TimeDataModel;

        return MaterialPageRoute(
          builder: (context) => ExmRegisterPage(timeDataModel: timeDataModel),
        );
        case Routes.examdegreeDetialsRoute:
          ExamAnswerModel examAnswerModel = settings.arguments as ExamAnswerModel;

        return MaterialPageRoute(
          builder: (context) => ExamDegreePage(examAnswerModel: examAnswerModel),
        );
        case Routes.examRoute:
          Instruction examInstruction = settings.arguments as Instruction;

        return MaterialPageRoute(
          builder: (context) => ExamScreen(examInstruction: examInstruction),
        );
      case Routes.monthplanDetialsRoute:
        List<dynamic> data = settings.arguments as List<dynamic>;
        List<Plans> plans = data[0];
        DateTime dateTime = data[1];

        return MaterialPageRoute(
          builder: (context) => MonthPlanDetails(
            dateTime: dateTime,
            plans: plans,
          ),
        );
      case Routes.confirmexamRegisterRoute:
        ExamModel examModel = settings.arguments as ExamModel;

        return MaterialPageRoute(
          builder: (context) => ConfirmExamRegister(
            examModel: examModel,
          ),
        );
      case Routes.myDegreeRoute:
        return MaterialPageRoute(
          builder: (context) => const MyDegreePage(),
        );
      case Routes.suggestRoute:
        return MaterialPageRoute(
          builder: (context) => SuggestScreen(),
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
