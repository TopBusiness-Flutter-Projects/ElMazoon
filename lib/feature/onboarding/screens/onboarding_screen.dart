import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:elmazoon/core/preferences/preferences.dart';
import 'package:elmazoon/core/utils/app_colors.dart';
import 'package:elmazoon/core/widgets/no_data_widget.dart';
import 'package:elmazoon/core/widgets/show_loading_indicator.dart';
import 'package:elmazoon/feature/onboarding/cubit/on_boarding_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../config/routes/app_routes.dart';
import '../../../core/models/user_model.dart';
import '../../mainscreens/profilePage/screens/profile_page.dart';
import '../../navigation_bottom/screens/navigation_bottom.dart';
import '../../splash/presentation/cubit/splash_cubit.dart';
import '../../splash/presentation/screens/pop_ads_screen.dart';
import '../../splash/presentation/screens/splash_screen.dart';


class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => OnBoardingScreenState();
}

class OnBoardingScreenState extends State<OnBoardingScreen> {
  List<ContentConfig> listContentConfig = [];

  @override
  void initState() {
    super.initState();
    context.read<OnBoardingCubit>().getOnBoardingData();
  }

  Future<void> onDonePress() async {
    log("End of slides");
    Preferences.instance.setFirstInstall();
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
        Navigator.pushReplacement(
          context,
          PageTransition(
            type: PageTransitionType.rightToLeft,
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
  Widget build(BuildContext context) {
    return BlocBuilder<OnBoardingCubit, OnBoardingState>(
      builder: (context, state) {
        OnBoardingCubit cubit = context.read<OnBoardingCubit>();
        if (state is OnBoardingLoading) {
          return ShowLoadingIndicator();
        }
        if (state is OnBoardingError) {
          return NoDataWidget(
            onclick: () => cubit.getOnBoardingData(),
            title: 'no_date'.tr(),
          );
        }
        return IntroSlider(
          key: UniqueKey(),
          listContentConfig: cubit.listContentConfig,
          onDonePress: onDonePress,
          renderNextBtn: Container(
            width: 80,
            height: 35,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: AppColors.primary,
            ),
            child: Text(
              'next'.tr(),
              textAlign: TextAlign.center,
              style: TextStyle(color: AppColors.white),
            ),
          ),
          renderDoneBtn: Container(
            width: 80,
            height: 35,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: AppColors.primary,
            ),
            child: Text(
              'done'.tr(),
              textAlign: TextAlign.center,
              style: TextStyle(color: AppColors.white),
            ),
          ),
          renderSkipBtn: Text(
            'skip'.tr(),
            style: TextStyle(color: AppColors.descriptionBoardingColor),
          ),
          nextButtonStyle: ButtonStyle(
            padding: MaterialStatePropertyAll<EdgeInsetsGeometry>(
              EdgeInsets.all(0),
            ),
          ),
          doneButtonStyle: ButtonStyle(
            padding: MaterialStatePropertyAll<EdgeInsetsGeometry>(
              EdgeInsets.all(0),
            ),
          ),
        );
      },
    );
  }
}
