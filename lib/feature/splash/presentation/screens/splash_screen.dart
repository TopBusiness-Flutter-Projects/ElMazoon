import 'dart:async';
import 'package:elmazoon/core/utils/app_routes.dart';
import 'package:elmazoon/feature/splash/presentation/cubit/splash_cubit.dart';
import 'package:elmazoon/feature/splash/presentation/screens/pop_ads_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
        _goNext();
      },
    );
  }

  Future<void> _getStoreUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString('user') != null) {
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
