import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../../../core/utils/app_colors.dart';
import '../cubit/live_exam_cubit.dart';

class LiveExamTimerWidget extends StatefulWidget {
  const LiveExamTimerWidget({Key? key, required this.examTime}) : super(key: key);

  final int examTime;
  @override
  State<LiveExamTimerWidget> createState() => _LiveExamTimerWidgetState();
}

class _LiveExamTimerWidgetState extends State<LiveExamTimerWidget> {


  //CountdownTimerController? controller;
  Timer? countdownTimer;
  Duration? myDuration;

  @override
  void initState() {
    super.initState();
    myDuration = Duration(minutes: widget.examTime);
    startTimer();
  }

  @override
  void dispose() {
    super.dispose();
    stopTimer();
  }

  void startTimer() {
    countdownTimer =
        Timer.periodic(Duration(seconds: 1), (_) => setCountDown());
  }

  // Step 4
  void stopTimer() {
    countdownTimer!.cancel();
  }

  // Step 5
  void resetTimer() {
    stopTimer();
    setState(() => myDuration = Duration(days: 5));
  }

  void setCountDown() {
    final reduceSecondsBy = 1;
    setState(() {
      final seconds = myDuration!.inSeconds - reduceSecondsBy;
      if (seconds < 0) {
        countdownTimer!.cancel();

      } else {
        myDuration = Duration(seconds: seconds);
      }
    });
  }
  // void checkInternet(LiveExamCubit cubit) async {
  //   bool result = await InternetConnectionChecker().hasConnection;
  //   if (result == false) {
  //     cubit.saveExam(cubit.minute + ":" + cubit.second);
  //   }
  // }

  @override
  Widget build(BuildContext context) {

    String strDigits(int n) => n.toString().padLeft(2, '0');
    LiveExamCubit cubit = context.read<LiveExamCubit>();
    if (cubit.minutes != -1 || cubit.seconed != -1) {
      myDuration = Duration(minutes: cubit.minutes, seconds: cubit.seconed);
      cubit.updateTime();
    }
    // checkInternet(cubit);
    cubit.minute = strDigits(myDuration!.inMinutes.remainder(60));
    cubit.second = strDigits(myDuration!.inSeconds.remainder(60));
    return Column(
      children: [
        Container(
          width: double.infinity,
          child: Text(
            'remind_time'.tr(),
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: AppColors.success,
              fontSize: 13,
            ),
          ),
        ),
        Container(
          width: double.infinity,
          child: Text(
            '${cubit.minute}:${cubit.second}',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: AppColors.success,
              fontSize: 13,
            ),
          ),
        ),
      ],
    );
  }
}
