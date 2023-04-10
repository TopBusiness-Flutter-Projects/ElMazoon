import 'package:easy_localization/easy_localization.dart';
import 'package:elmazoon/core/utils/toast_message_method.dart';
import 'package:elmazoon/core/widgets/no_data_widget.dart';
import 'package:elmazoon/core/widgets/show_loading_indicator.dart';
import 'package:elmazoon/feature/live_exam/cubit/live_exam_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/models/ads_model.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/assets_manager.dart';
import '../../../core/utils/restart_app_class.dart';
import '../../../core/widgets/custom_app_bar.dart';
import '../../../core/widgets/custom_button.dart';
import '../../exam/widget/add_question_replay_widget.dart';
import '../../exam/widget/time_widget.dart';
import '../widgets/completed_live_exam_widget.dart';
import '../widgets/live_exam_timer_widget.dart';

class LiveExamScreen extends StatefulWidget {
  final LifeExam lifeExam;
  const LiveExamScreen({Key? key, required this.lifeExam}) : super(key: key);

  @override
  State<LiveExamScreen> createState() => _LiveExamScreenState();
}

class _LiveExamScreenState extends State<LiveExamScreen> {
  @override
  void deactivate() {
    super.deactivate();
    context.read<LiveExamCubit>().pendingList.clear();
    context.read<LiveExamCubit>().pendingListNumber.clear();

  }

  @override
  void initState() {
    super.initState();
    context.read<LiveExamCubit>().accessQuestionOfLiveExam(widget.lifeExam.id!);
  }

  @override
  Widget build(BuildContext context) {
    LiveExamCubit cubit = context.read<LiveExamCubit>();


    return BlocBuilder<LiveExamCubit, LiveExamState>(
      builder: (context, state) {
        // print("dddd");
        // print(cubit.liveExamModel.data!.questions!.length);
        return Scaffold(
          appBar: AppBar(
            toolbarHeight: 160,
            titleSpacing: 0,
            title: Column(
              children: [
                CustomAppBar(
                  title: widget.lifeExam.name??' ',
                  subtitle: ''.tr(),
                ),
                Container(
                  width: double.infinity,
                  height: 50,
                  child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: cubit.liveExamModel.data!=null?cubit.liveExamModel.data!.questions!.length:0,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Container(
                          width: 40,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: cubit.liveExamModel.data!.questions!
                                .elementAt(index)
                                .status ==
                                'pending'
                                ? AppColors.error
                                : cubit.liveExamModel.data!.questions!
                                .elementAt(index)
                                .status ==
                                'answered'
                                ? AppColors.success
                                : cubit.index == index
                                ? AppColors.primary
                                : AppColors.white,
                          ),
                          child: InkWell(
                            onTap: () {
                              cubit.updateIndex(index);
                            },
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "${index + 1}",
                                  style: TextStyle(
                                    color: cubit.index == index
                                        ? AppColors.white
                                        : cubit.liveExamModel!.data!.questions!
                                        .elementAt(index)
                                        .status !=
                                        ''
                                        ? AppColors.white
                                        : AppColors.primary,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
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
          body: cubit.liveExamModel.data!=null&&cubit.liveExamModel!.data!.questions!.length > 0
              ? Form(
            key: cubit.formKey,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    LiveExamTimerWidget( examTime: widget.lifeExam.quizMinute!,),
                    Container(
                      width: double.infinity,
                      child: Padding(
                        padding:
                        const EdgeInsets.symmetric(vertical: 30.0),
                        child: Text(
                          cubit.liveExamModel!.data!.questions![cubit.index]
                              .question!,
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ),


                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: cubit.liveExamModel!.data!.questions![cubit.index].answers!.length,
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
                                      index,
                                    );
                                  },
                                  child: Container(
                                    width: double.maxFinite,
                                    height: 60,
                                    decoration: BoxDecoration(
                                        color: cubit.liveExamModel!.data!.questions![
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
                                          cubit.liveExamModel!.data!.questions![
                                          cubit.index]
                                              .answers![index]
                                              .answer!,
                                          style: TextStyle(
                                            fontWeight:
                                            FontWeight.bold,
                                            fontSize: 14,
                                            color: cubit.liveExamModel!.data!.questions![
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
                      ,

                    SizedBox(height: 50),

                    Visibility(
                      visible: cubit.pendingList.isNotEmpty,
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
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                ...List.generate(
                                    cubit.pendingListNumber.length,
                                        (index) => Padding(
                                      padding:
                                      const EdgeInsets.all(8.0),
                                      child: Align(
                                        alignment:
                                        Alignment.centerRight,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: AppColors.primary,
                                          ),
                                          child: Padding(
                                            padding:
                                            const EdgeInsets.all(
                                              14.0,
                                            ),
                                            child: Text(
                                              cubit.pendingListNumber[
                                              index]
                                                  .toString(),
                                              style: TextStyle(
                                                fontWeight:
                                                FontWeight.bold,
                                                fontSize: 14,
                                                color:
                                                AppColors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ))
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 12),



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
                                cubit.postponeQuestion(
                                  cubit.index
                                );
                                // cubit.updateSelectAnswer(
                                //   55,
                                // );
                                if (cubit.liveExamModel.data!.questions!
                                    .length -
                                    1 !=
                                    cubit.index) {
                                  cubit.updateIndex(cubit.index + 1);
                                } else {
                                  toastMessage(
                                    'lastQuestion'.tr(),
                                    context,
                                    color: AppColors.primary,
                                  );
                                }
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
                                  cubit.index
                                );
                                if (cubit.liveExamModel!.data!.questions!
                                    .length -
                                    1 !=
                                    cubit.index) {
                                  cubit.updateIndex(cubit.index + 1);
                                } else {
                                  toastMessage(
                                    'last_question'.tr(),
                                    context,
                                    color: AppColors.primary,
                                  );
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      child: CustomButton(
                        paddingHorizontal: 50,
                        text: 'end_exam'.tr(),
                        color: AppColors.secondPrimary,
                        onClick: () {
                          cubit.endExam(

                                int.parse(
                                    context.read<LiveExamCubit>().minute),
                            context
                          );
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
}
