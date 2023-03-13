import 'dart:async';
import 'dart:core';
import 'dart:core';

import 'package:calendar_view/calendar_view.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:elmazoon/core/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';

import '../../../../core/models/lessons_details_model.dart';
import '../../../../core/models/month_plan_model.dart';
import '../../../../core/utils/assets_manager.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../cubit/exam_cubit.dart';

class ExamScreen extends StatefulWidget {
  final Instruction examInstruction;

  const ExamScreen({Key? key, required this.examInstruction, }) : super(key: key);

  @override
  State<ExamScreen> createState() => _ExamScreenState();
}

class _ExamScreenState extends State<ExamScreen> {

  CountdownTimerController? controller;
  Timer? countdownTimer;
  Duration?  myDuration;
  @override
  void initState() {
    super.initState();
    print("object");
    print(widget.examInstruction.quizMinute);
    controller = CountdownTimerController(endTime: widget.examInstruction.quizMinute, onEnd: onEnd);
    myDuration = Duration(minutes: widget.examInstruction.quizMinute);

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
      } else {
        myDuration = Duration(seconds: seconds);
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    String strDigits(int n) => n.toString().padLeft(2, '0');

    final minutes = strDigits(myDuration!.inMinutes.remainder(60));
    final seconds = strDigits(myDuration!.inSeconds.remainder(60));
    ExamCubit cubit = context.read<ExamCubit>();

    cubit.getExam(widget.examInstruction.online_exam_id!=0?widget.examInstruction.online_exam_id:widget.examInstruction.all_exam_id,widget.examInstruction.exam_type);
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
                            color:cubit.index==index? AppColors.primary:cubit.questionesDataModel!.questions.elementAt(index).status=='pending'?AppColors.error:AppColors.white,
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
                                      color:cubit.index==index? AppColors.white:AppColors.primary,
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
          body:cubit.questionesDataModel!.questions.length>0?
          cubit.questionesDataModel!.questions[cubit.index].answers!.length>0?
          Container(

            child: Column(
              children: [
            Text(
            '$minutes:$seconds',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 50),
            ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(cubit.questionesDataModel!.questions[cubit.index].question!,
                  style: TextStyle(fontWeight: FontWeight.normal,fontSize: 15,),),
                ),

                ListView.builder(
                  shrinkWrap: true,
                  itemCount: cubit.questionesDataModel!.questions[cubit.index].answers!.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Container(

                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: InkWell(
                              onTap: () {
                                cubit.updateSelectAnswer(cubit.index,index);
                              },
                              child: Container(
                                width: double.maxFinite,
                                height: 40,
                                decoration: BoxDecoration(
                                    color: cubit.questionesDataModel!.questions[cubit.index].answers![index].status=='select'?AppColors.primary:AppColors.unselectedTab,
                                    shape: BoxShape.rectangle,borderRadius: BorderRadius.all(Radius.circular(10))),
                           child:  Padding(
                             padding: const EdgeInsets.all(8.0),
                             child: Text(cubit.questionesDataModel!.questions[cubit.index].answers![index].answer!),
                           ),

                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ):
              Container()
              :   Container()
          ,
        );
      },
    );
  }

  void onEnd() {
    print('onEnd');
  }

}
