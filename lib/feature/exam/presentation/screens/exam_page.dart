import 'dart:core';
import 'dart:io';
import 'package:elmazoon/core/utils/toast_message_method.dart';

import '../../../../core/widgets/audio_player_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:elmazoon/core/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/models/lessons_details_model.dart';
import '../../../../core/utils/assets_manager.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../widget/add_question_replay_widget.dart';
import '../../cubit/exam_cubit.dart';
import '../../widget/time_widget.dart';

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
  @override
  void deactivate() {
    super.deactivate();
    context.read<ExamCubit>().pendingList.clear();
    context.read<ExamCubit>().pendingListNumber.clear();
  }

  @override
  Widget build(BuildContext context) {
    ExamCubit cubit = context.read<ExamCubit>();

    if (cubit.questionsDataModel!.questions.length == 0) {
      cubit.getExam(
        widget.examInstruction.online_exam_id != 0
            ? widget.examInstruction.online_exam_id
            : widget.examInstruction.all_exam_id,
        widget.examInstruction.exam_type,
      );
    }

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
                    itemCount: cubit.questionsDataModel!.questions.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Container(
                          width: 40,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: cubit.questionsDataModel!.questions
                                        .elementAt(index)
                                        .status ==
                                    'pending'
                                ? AppColors.error
                                : cubit.questionsDataModel!.questions
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
                                        : cubit.questionsDataModel!.questions
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
          body: cubit.questionsDataModel!.questions.length > 0
              ? Form(
                  key: cubit.formKey,
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TimeWidget(examInstruction: widget.examInstruction),
                          Container(
                            width: double.infinity,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 30.0),
                              child: Text(
                                cubit.questionsDataModel!.questions[cubit.index]
                                    .question!,
                                style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ),
                          cubit.questionsDataModel!.questions[cubit.index]
                                      .answers!.length >
                                  0
                              ? ListView.builder(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: cubit.questionsDataModel!
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
                                                  index,
                                                );
                                              },
                                              child: Container(
                                                width: double.maxFinite,
                                                height: 60,
                                                decoration: BoxDecoration(
                                                    color: cubit
                                                                .questionsDataModel!
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
                                                          .questionsDataModel!
                                                          .questions[
                                                              cubit.index]
                                                          .answers![index]
                                                          .answer!,
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 14,
                                                        color: cubit
                                                                    .questionsDataModel!
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
                                    id: cubit.questionsDataModel!
                                        .questions[cubit.index].id!,
                                    type: 'question',
                                    index: cubit.index,
                                  ),
                                ),
                          SizedBox(height: 50),
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
                          SizedBox(height: 12),
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
                                        cubit.index,
                                        cubit
                                                    .questionsDataModel!
                                                    .questions[cubit.index]
                                                    .answers!
                                                    .length >
                                                0
                                            ? 'choice'
                                            : cubit.questionsDataModel!
                                                .questions[cubit.index].type,
                                      );
                                      cubit.updateSelectAnswer(
                                        55,
                                      );
                                      if (cubit.questionsDataModel!.questions
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
                                        cubit.index,
                                        cubit
                                                    .questionsDataModel!
                                                    .questions[cubit.index]
                                                    .answers!
                                                    .length >
                                                0
                                            ? 'choice'
                                            : cubit.questionsDataModel!
                                                .questions[cubit.index].type,
                                      );
                                      if (cubit.questionsDataModel!.questions
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
                                  widget.examInstruction.quizMinute -
                                      int.parse(
                                          context.read<ExamCubit>().minute),
                                  context,
                                  widget.examInstruction.exam_type,
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
