import 'dart:async';
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
    _timer = Timer(const Duration(milliseconds: 3000), () => _goNext());
  }

  Future<void> _getStoreUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
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
    _animation = Tween<Offset>(
      begin: const Offset(0.0, 0.0),
      end: const Offset(0.0, -1.5),
    ).animate(CurvedAnimation(
      parent: _controller!,
      curve: Curves.easeInCubic,
    ));
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
              width: 300,
              height: 150,
              child: Image.asset('assets/images/logo.png')),
        ),
      ),
    );
  }
}
