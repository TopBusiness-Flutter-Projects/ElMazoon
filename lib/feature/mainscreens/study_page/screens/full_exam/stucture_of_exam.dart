import 'package:easy_localization/easy_localization.dart';
import 'package:elmazoon/core/utils/app_colors.dart';
import 'package:elmazoon/core/widgets/custom_appbar_widget.dart';
import 'package:elmazoon/core/widgets/custom_button.dart';
import 'package:flutter/material.dart';

import '../../../../../core/models/lessons_details_model.dart';

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
                padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 12),
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
                      width: MediaQuery.of(context).size.width,
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
                          Text(examInstruction.instruction,
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
                      '${'try_numbers'.tr()} :     ${examInstruction.tryingNumber}',
                      style: TextStyle(
                        color: AppColors.secondPrimary,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    SizedBox(height: 12),
                    Text(
                      '${'number_of_question'.tr()} :    ${examInstruction.numberOfQuestion}',
                      style: TextStyle(
                        color: AppColors.secondPrimary,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    SizedBox(height: 12),
                    Text(
                      '${'quiz_minute'.tr()} :    ${examInstruction.quizMinute}  ${'min'.tr()}',
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
          CustomButton(text: 'start'.tr(), color: AppColors.primary, onClick: (){},paddingHorizontal: 50,),
          SizedBox(height: 25),
        ],
      ),
    );
  }
}
