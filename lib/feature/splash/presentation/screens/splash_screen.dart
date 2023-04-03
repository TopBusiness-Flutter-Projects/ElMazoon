import 'dart:async';
import 'package:easy_localization/easy_localization.dart';
import 'package:elmazoon/core/preferences/preferences.dart';
import 'package:elmazoon/core/utils/app_routes.dart';
import 'package:elmazoon/feature/splash/presentation/cubit/splash_cubit.dart';
import 'package:elmazoon/feature/splash/presentation/screens/pop_ads_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/models/user_model.dart';
import '../../../live_exam/screens/live_exam_screen.dart';
import '../../../mainscreens/profilePage/screens/profile_page.dart';
import '../../../mainscreens/profilePage/screens/profile_page_deatils.dart';
import '../../../navigation_bottom/screens/navigation_bottom.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late Timer _timer;

  _goNext() {
    _getStoreUser();
  }

  _startDelay() async {
    _timer = Timer(
      const Duration(seconds: 2),
      () {
        // Preferences.instance.clearUserData();
        _goNext();
      },
    );
  }

  Future<void> _getStoreUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    UserModel userModel = await Preferences.instance.getUserModel();
    if (prefs.getString('user') != null) {
      if (userModel.data!.dateEndCode.isBefore(DateTime.now())) {
        DateTime now = new DateTime.now();

        DateTime timeStart = DateTime.parse(
            '${context.read<SplashCubit>().lifeExam.dateExam.toString().split(' ')[0]} ${context.read<SplashCubit>().lifeExam.timeStart}');
        DateTime timeEnd = DateTime.parse(
            '${context.read<SplashCubit>().lifeExam.dateExam.toString().split(' ')[0]} ${context.read<SplashCubit>().lifeExam.timeEnd}');

        print('##################################');
        print(now);
        print(userModel.data!.dateEndCode);
        print(timeStart);
        print(timeEnd);
        print('##################################');

        if (now.compareTo(timeStart) < 0) {
          print("DT1 is before DT2");
        }

        if (now.compareTo(timeEnd) > 0) {
          print("DT1 is after DT2");
        }

      if(userModel.data!.dateEndCode.isBefore(DateTime.now())){
        Navigator.pushReplacement(
          context,
          PageTransition(
            type:  PageTransitionType.rightToLeft,
            alignment: Alignment.centerRight,
            duration: const Duration(milliseconds: 700),
            child: ProfilePage(isAppBar: true),
            childCurrent: SplashScreen(),
          ),
        );
      } else {
        if (context.read<SplashCubit>().adsList.isNotEmpty) {
          Navigator.pushReplacement(
            context,
            PageTransition(
              type: PageTransitionType.fade,
              alignment: Alignment.center,
              duration: const Duration(milliseconds: 1300),
              child: PopAdsScreen(
                adsDatum: context.read<SplashCubit>().adsList.first,
              ),
            ),
          );
        } else {
          Navigator.pushReplacement(
            context,
            PageTransition(
              type: PageTransitionType.fade,
              alignment: Alignment.center,
              duration: const Duration(milliseconds: 1300),
              child: NavigatorBar(),
            ),
          );
        }
        // DateTime now = new DateTime.now();
        // DateTime timeStart = DateTime.parse(
        //     '${context.read<SplashCubit>().lifeExam.dateExam.toString().split(' ')[0]} ${context.read<SplashCubit>().lifeExam.timeStart}');
        // DateTime timeEnd = DateTime.parse(
        //     '${context.read<SplashCubit>().lifeExam.dateExam.toString().split(' ')[0]} ${context.read<SplashCubit>().lifeExam.timeEnd}');
        //
        // if (now.isAtSameMomentAs(timeStart) ||
        //     now.isAtSameMomentAs(timeEnd) ||
        //     now.isAfter(timeStart) ) {
        //
        //   print(now.isAtSameMomentAs(timeStart));
        //   print(now.isAtSameMomentAs(timeEnd));
        //   // print(now.isBefore(timeEnd));
        //   print(now.isBefore(timeEnd));
        //   // print(now.isBefore(timeStart));
        //   print(now.isAfter(timeStart));
        //   Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //       builder: (context) => LiveExamScreen()
        //     ),
        //   );
        // } else {
        // }
      }
    } else {
      Navigator.pushNamedAndRemoveUntil(
        context,
        Routes.loginRoute,
        ModalRoute.withName(
          Routes.initialRoute,
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    // context.read<SplashCubit>().getAdsOfApp();
    _startDelay();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SplashCubit, SplashState>(
      builder: (context, state) {
        if (state is SplashLoading) {}
        if (state is SplashLoaded) {
          _startDelay();
        }
        return Scaffold(
          body: Center(
            child: Hero(
              tag: 'logo',
              child: SizedBox(
                width: 300,
                height: 300,
                child: Image.asset('assets/images/logo.png'),
              ),
            ),
          ),
        );
      },
    );
  }
}
