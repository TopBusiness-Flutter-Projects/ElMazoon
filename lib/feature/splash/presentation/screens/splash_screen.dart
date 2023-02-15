import 'dart:async';
import 'package:elmazoon/core/utils/app_routes.dart';
import 'package:elmazoon/feature/auth/login/presentation/screens/login.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
  late Timer _timer;
  AnimationController? _controller;
  Animation<Offset>? _animation;
  _goNext() {
    _getStoreUser();
  }

  _startDelay() async {
    _timer = Timer( Duration(milliseconds: 3000),() {

    },);
  }

  Future<void> _getStoreUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Navigator.pushNamed(
        context,
       Routes.loginRoute,
    );
    if (prefs.getString('user') != null) {
      // Navigator.pushReplacement(
      //   context,
      //   PageTransition(
      //     type: PageTransitionType.fade,
      //     alignment: Alignment.center,
      //     duration: const Duration(milliseconds: 1300),
      //     child:  NavigationBottom(),
      //   ),
      // );

    }else{
      // Navigator.pushReplacement(
      //   context,
      //   PageTransition(
      //     type: PageTransitionType.fade,
      //     alignment: Alignment.center,
      //     duration: const Duration(milliseconds: 1300),
      //     child:  LoginScreen(),
      //   ),
      // );
    }

  }

  @override
  void initState() {
    super.initState();
    // Preferences.instance.clearUserData();
     _startDelay();

    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
    _controller!.addStatusListener((status) {
      if(status.index==3){
        _goNext();
      }

    });
    _animation = Tween<Offset>(
      begin: const Offset(0.0, 0.0),
      end: const Offset(0.0, -.9),
    ).animate(CurvedAnimation(
      parent: _controller!,
      curve: Curves.easeInOut,

    ),
    );
    Future.delayed(const Duration(milliseconds: 3000), () {
      _controller!.forward();
    });
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
        child: SlideTransition(
          position: _animation!,

          child: SizedBox(
              width: 350,
              height: 150,
              child: Image.asset('assets/images/logo.png')),

        ),
      ),
    );
  }
}
