import 'package:easy_localization/easy_localization.dart';
import 'package:elmazoon/core/models/times_model.dart';
import 'package:elmazoon/core/utils/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../core/models/exam_model.dart';
import '../../../../core/utils/assets_manager.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../../../core/widgets/custom_appbar_widget.dart';
import '../../../../core/widgets/custom_button.dart';

class ConfirmExamRegister extends StatelessWidget {
  final ExamModel examModel;

  const ConfirmExamRegister({
    Key? key,
    required this.examModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarWidget(appBarTitle: 'confirm_exam'),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Center(
              child: Image.asset(
                ImageAssets.correctImage,
                fit: BoxFit.cover,
                height: 30,
                width: 30,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Center(
              child: Text(
                'success_register'.tr(),
                style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Center(
              child: Container(
                width: MediaQuery.of(context).size.width - 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18),
                  gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [
                      AppColors.blueLiteColor1,
                      AppColors.blueLiteColor2,
                    ],
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Text(
                        "exam_num".tr() +
                            ":" +
                            examModel.data!.exam!.id.toString(),
                        style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color: AppColors.secondPrimary),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        "exam_time".tr() + ":" + examModel.dateExam.toString(),
                        style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color: AppColors.secondPrimary),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        "address".tr() + ":" + examModel.address!,
                        style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color: AppColors.secondPrimary),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        "exam_hall".tr() + ":" + examModel.sectionName!,
                        style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color: AppColors.secondPrimary),
                      ),
                      SizedBox(
                        height: 50,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            CustomButton(
              paddingHorizontal: 50,
              text: 'confirm'.tr(),
              color: AppColors.primary,
              onClick: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
