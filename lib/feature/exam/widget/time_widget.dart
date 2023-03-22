import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../../../core/models/lessons_details_model.dart';
import '../../../core/utils/app_colors.dart';
import '../cubit/exam_cubit.dart';

class TimeWidget extends StatefulWidget {
  const TimeWidget({Key? key, required this.examInstruction}) : super(key: key);
  final Instruction examInstruction;

  @override
  State<TimeWidget> createState() => _TimeWidgetState();
}

class _TimeWidgetState extends State<TimeWidget> {
  //CountdownTimerController? controller;
  Timer? countdownTimer;
  Duration? myDuration;

  @override
  void initState() {
    super.initState();
    myDuration = Duration(minutes: widget.examInstruction.quizMinute);
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
        context.read<ExamCubit>().endExamTime(
            widget.examInstruction.quizMinute -
                int.parse(context.read<ExamCubit>().minute),
            context,
            widget.examInstruction.exam_type);
      } else {
        myDuration = Duration(seconds: seconds);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    String strDigits(int n) => n.toString().padLeft(2, '0');
    ExamCubit cubit = context.read<ExamCubit>();
    if (cubit.minutes != -1 || cubit.seconed != -1) {
      myDuration = Duration(minutes: cubit.minutes, seconds: cubit.seconed);
      cubit.updateTime();
    }
    checkInternet(cubit);
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

  void checkInternet(ExamCubit cubit) async {
    bool result = await InternetConnectionChecker().hasConnection;
    if (result == false) {
      cubit.saveExam(cubit.minute + ":" + cubit.second);
    }
  }
}
