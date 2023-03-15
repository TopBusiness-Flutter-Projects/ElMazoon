import 'package:easy_localization/easy_localization.dart';
import 'package:elmazoon/core/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../../core/utils/assets_manager.dart';

class NoExamWidget extends StatelessWidget {
  const NoExamWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Lottie.asset(
          ImageAssets.noExam,
          width: 120,
          height: 120,
        ),
        SizedBox(height: 50),
        Text(
          'no_exam'.tr(),
          style: TextStyle(
            color: AppColors.secondPrimary,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        )
      ],
    );
  }
}
