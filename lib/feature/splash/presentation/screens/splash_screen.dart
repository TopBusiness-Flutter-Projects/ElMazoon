import 'dart:async';
import 'package:elmazoon/core/preferences/preferences.dart';
import 'package:elmazoon/core/utils/app_routes.dart';
import 'package:elmazoon/feature/auth/login/presentation/screens/login.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
    if (prefs.getString('user') != null) {
      Navigator.pushReplacement(
        context,
        PageTransition(
          type: PageTransitionType.fade,
          alignment: Alignment.center,
          duration: const Duration(milliseconds: 1300),
          child: NavigatorBar(
            // loginDataModel: loginDataModel,
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
          child:  LoginScreen(),
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _startDelay();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Hero(
          tag: 'logo',
          child: SizedBox(
              width: 300,
              height: 300,
              child: Image.asset('assets/images/logo.png')),
        ),
      ),
    );
  }
}
