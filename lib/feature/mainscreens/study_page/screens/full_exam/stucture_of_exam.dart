import 'package:easy_localization/easy_localization.dart';
import 'package:elmazoon/core/models/questiones_data_model.dart';
import 'package:elmazoon/core/utils/app_colors.dart';
import 'package:elmazoon/core/widgets/custom_appbar_widget.dart';
import 'package:elmazoon/core/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/models/exam_answer_list_model.dart';
import '../../../../../core/models/lessons_details_model.dart';
import '../../../../../core/preferences/preferences.dart';
import '../../../../../core/utils/app_routes.dart';
import '../../../../../core/utils/toast_message_method.dart';
import '../../../../exam/cubit/exam_cubit.dart';

class ExamInstruction extends StatelessWidget {
  const ExamInstruction({Key? key, required this.examInstruction})
      : super(key: key);
  final Instruction examInstruction;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarWidget(appBarTitle: 'instruction_before_eXam'.tr()),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 25),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            'exam_instruction_note'.tr(),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: AppColors.primary,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 25),
                    Container(
                      width: MediaQuery
                          .of(context)
                          .size
                          .width,
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        gradient: LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [
                            AppColors.blueLiteColor1,
                            AppColors.blueLiteColor2,
                          ],
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            examInstruction.instruction,
                            style: TextStyle(
                              color: AppColors.secondPrimary,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          SizedBox(height: 40),
                        ],
                      ),
                    ),
                    SizedBox(height: 25),
                    Text(
                      '${'try_numbers'.tr()} :     ${examInstruction
                          .tryingNumber}',
                      style: TextStyle(
                        color: AppColors.secondPrimary,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    SizedBox(height: 12),
                    Text(
                      '${'number_of_question'.tr()} :    ${examInstruction
                          .numberOfQuestion}',
                      style: TextStyle(
                        color: AppColors.secondPrimary,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    SizedBox(height: 12),
                    Text(
                      '${'quiz_minute'.tr()} :    ${examInstruction
                          .quizMinute}  ${'min'.tr()}',
                      style: TextStyle(
                        color: AppColors.secondPrimary,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          CustomButton(
            text: 'start'.tr(),
            color: AppColors.primary,
            onClick: () async {
              if (context
                  .read<ExamCubit>()
                  .questionesDataModel!
                  .questions
                  .length >
                  0) {
                context
                    .read<ExamCubit>()
                    .getExam(examInstruction.id, examInstruction.exam_type);
                context
                    .read<ExamCubit>()
                    .answerController!
                    .text = '';
                context
                    .read<ExamCubit>()
                    .questionesDataModel = QuestionData();
                context
                    .read<ExamCubit>()
                    .index = 0;
              }

              if (examInstruction.tryingNumber > 0) {
                ExamAnswerListModel examAnswerListModel =
                await Preferences.instance.getExamModel();
                print("lldld");
                print(examInstruction.all_exam_id);
                print(examInstruction.online_exam_id);

                if (examAnswerListModel.id != 0 &&
                    ((examInstruction.all_exam_id != 0 &&
                        examInstruction.all_exam_id !=
                            examAnswerListModel.id) ||
                        (examInstruction.online_exam_id != 0 &&
                            examInstruction.online_exam_id !=
                                examAnswerListModel.id))) {
                  toastMessage(
                    "please_complete_other_exam".tr() +
                        examAnswerListModel.id.toString(),
                    context,
                    color: AppColors.error,
                  );
                } else {
                  Navigator.pushNamed(context, Routes.examRoute,
                      arguments: examInstruction);
                }
              } else {
                toastMessage(
                  "you_dont_open_this_exam".tr(),
                  context,
                  color: AppColors.error,
                );
              }
            },
            paddingHorizontal: 50,
          ),
          SizedBox(height: 25),
        ],
      ),
    );
  }
}
