import 'dart:async';
import 'dart:core';
import 'dart:core';
import 'dart:io';
import '../../../../core/models/exam_answer_list_model.dart';
import '../../../../core/preferences/preferences.dart';
import '../../../../core/widgets/audio_player_widget.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import 'package:calendar_view/calendar_view.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:elmazoon/core/utils/app_colors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';

import '../../../../core/models/lessons_details_model.dart';
import '../../../../core/models/month_plan_model.dart';
import '../../../../core/utils/assets_manager.dart';
import '../../../../core/widgets/audio_recorder_widget.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../widget/add_question_replay_widget.dart';
import '../../cubit/exam_cubit.dart';

class ExamScreen extends StatefulWidget {
  final Instruction examInstruction;

  const ExamScreen({
    Key? key,
    required this.examInstruction,
  }) : super(key: key);

  @override
  State<ExamScreen> createState() => _ExamScreenState();
}

class _ExamScreenState extends State<ExamScreen> {
  //CountdownTimerController? controller;
  Timer? countdownTimer;
  Duration? myDuration;

  var minutes = "0";
  var seconds = "0";

  @override
  void initState() {
    super.initState();
    print("object");
    print(widget.examInstruction.quizMinute);
    // controller = CountdownTimerController(
    //     endTime: widget.examInstruction.quizMinute, onEnd: onEnd);
    myDuration = Duration(minutes: widget.examInstruction.quizMinute);
    startTimer();
  }

  void startTimer() {
    countdownTimer =
        Timer.periodic(Duration(seconds: 1), (_) => setCountDown());
  }

  // Step 4
  void stopTimer() {
    setState(() => countdownTimer!.cancel());
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
            widget.examInstruction.quizMinute - int.parse(minutes),
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

    minutes = strDigits(myDuration!.inMinutes.remainder(60));
    seconds = strDigits(myDuration!.inSeconds.remainder(60));
    checkInternet(cubit);
    if (cubit.questionesDataModel!.questions.length == 0) {
      cubit.getExam(
          widget.examInstruction.online_exam_id != 0
              ? widget.examInstruction.online_exam_id
              : widget.examInstruction.all_exam_id,
          widget.examInstruction.exam_type);
    }
    String lang = EasyLocalization.of(context)!.locale.languageCode;

    return BlocBuilder<ExamCubit, ExamState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            toolbarHeight: 160,
            titleSpacing: 0,
            title: Column(
              children: [
                CustomAppBar(
                  title: 'month_plan'.tr(),
                  subtitle: ''.tr(),
                ),
                Container(
                  width: double.infinity,
                  height: 50,
                  child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: cubit.questionesDataModel!.questions.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Container(
                          width: 40,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: cubit.index == index
                                ? AppColors.primary
                                : cubit.questionesDataModel!.questions
                                            .elementAt(index)
                                            .status ==
                                        'pending'
                                    ? AppColors.error
                                    : AppColors.white,
                          ),
                          child: InkWell(
                            onTap: () {
                              cubit.updateindex(index);
                            },
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "${index + 1}",
                                  style: TextStyle(
                                      color: cubit.index == index
                                          ? AppColors.white
                                          : AppColors.primary,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                )
              ],
            ),
            flexibleSpace: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(ImageAssets.appBarImage),
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
          body: cubit.questionesDataModel!.questions.length > 0
              ? Form(
                  key: cubit.formKey,
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        //   crossAxisAlignment: CrossAxisAlignment.stretch,
                        //      /mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        //  crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: double.infinity,
                            child: Text(
                              'remind_time'.tr(),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.success,
                                  fontSize: 13),
                            ),
                          ),
                          Container(
                            width: double.infinity,
                            child: Text(
                              '$minutes:$seconds',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.success,
                                  fontSize: 13),
                            ),
                          ),
                          Container(
                            width: double.infinity,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 30.0),
                              child: Text(
                                cubit.questionesDataModel!
                                    .questions[cubit.index].question!,
                                style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ),
                          cubit.questionesDataModel!.questions[cubit.index]
                                      .answers!.length >
                                  0
                              ? ListView.builder(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: cubit.questionesDataModel!
                                      .questions[cubit.index].answers!.length,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0),
                                      child: Container(
                                        child: Center(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: InkWell(
                                              onTap: () {
                                                cubit.updateSelectAnswer(
                                                    cubit.index, index);
                                              },
                                              child: Container(
                                                width: double.maxFinite,
                                                height: 60,
                                                decoration: BoxDecoration(
                                                    color: cubit
                                                                .questionesDataModel!
                                                                .questions[
                                                                    cubit.index]
                                                                .answers![index]
                                                                .status ==
                                                            'select'
                                                        ? AppColors.blueColor3
                                                        : AppColors
                                                            .unselectedTab,
                                                    shape: BoxShape.rectangle,
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                10))),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Align(
                                                    alignment:
                                                        Alignment.centerRight,
                                                    child: Text(
                                                      cubit
                                                          .questionesDataModel!
                                                          .questions[
                                                              cubit.index]
                                                          .answers![index]
                                                          .answer!,
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 14,
                                                        color: cubit
                                                                    .questionesDataModel!
                                                                    .questions[
                                                                        cubit
                                                                            .index]
                                                                    .answers![
                                                                        index]
                                                                    .status ==
                                                                'select'
                                                            ? AppColors.white
                                                            : AppColors
                                                                .secondPrimary,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                )
                              : Container(
                                  width: double.infinity,
                                  child: AddAnswerWidget(
                                    id: cubit.questionesDataModel!
                                        .questions[cubit.index].id!,
                                    type: 'question',
                                    index: cubit.index,
                                  ),
                                ),
                          Visibility(
                            visible: cubit.imagePath[cubit.index].isNotEmpty ||
                                cubit.audioPath[cubit.index].isNotEmpty,
                            child: cubit.imagePath.isNotEmpty
                                ? Image.file(
                                    File(
                                      cubit.imagePath[cubit.index],
                                    ),
                                    width: 140.0,
                                    height: 140.0,
                                    fit: BoxFit.cover,
                                  )
                                : AudioPlayer(
                                    source: cubit.audioPath[cubit.index],
                                    onDelete: () {},
                                    type: 'onlyShow',
                                  ),
                          ),
                          Visibility(
                            visible: cubit.pendinglist.isNotEmpty,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                width: double.maxFinite,
                                height: 60,
                                decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.centerLeft,
                                      end: Alignment.centerRight,
                                      colors: [
                                        AppColors.blueLiteColor1,
                                        AppColors.blueLiteColor2,
                                      ],
                                    ),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    child: Container(
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: AppColors.primary),
                                      child: Padding(
                                        padding: const EdgeInsets.all(14.0),
                                        child: Text(
                                          cubit.pendinglist.length.toString(),
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14,
                                            color: AppColors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            height: 70,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Expanded(
                                  child: CustomButton(
                                    paddingHorizontal: 10,
                                    text: 'postpone_question'.tr(),
                                    color: AppColors.primary,
                                    onClick: () {
                                      cubit.postponeQuestion(cubit.index);
                                      // Navigator.pop(context);
                                      //  Navigator.pop(context);
                                    },
                                  ),
                                ),
                                Expanded(
                                  child: CustomButton(
                                    paddingHorizontal: 10,
                                    text: 'solution_done'.tr(),
                                    color: AppColors.success,
                                    onClick: () {
                                      cubit.answerQuestion(
                                          cubit.index,
                                          cubit
                                                      .questionesDataModel!
                                                      .questions[cubit.index]
                                                      .answers!
                                                      .length >
                                                  0
                                              ? 'choice'
                                              : cubit.questionesDataModel!
                                                  .questions[cubit.index].type);
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: CustomButton(
                              paddingHorizontal: 50,
                              text: 'end_exam'.tr(),
                              color: AppColors.secondPrimary,
                              onClick: () {
                                cubit.endExam(
                                    widget.examInstruction.quizMinute -
                                        int.parse(minutes),
                                    context,
                                    widget.examInstruction.exam_type);
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                )
              : Container(),
        );
      },
    );
  }

  void onEnd() {}

  @override
  void dispose() {
    super.dispose();
    stopTimer();
  }

  void checkInternet(ExamCubit cubit) async {
    bool result = await InternetConnectionChecker().hasConnection;
    print("D;ldldldl");
    print(result);
    if (result == false) {
      cubit.saveExam(minutes + ":" + seconds);
    } else {
      //  Preferences.instance
      //  .setexam(new ExamAnswerListModel(answers: null, id: 0, time: ''));
    }
  }
}
