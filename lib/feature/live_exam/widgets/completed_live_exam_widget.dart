import 'package:easy_localization/easy_localization.dart' as tr;
import 'package:elmazoon/core/widgets/custom_button.dart';
import 'package:flutter/material.dart';

import '../../../core/utils/app_colors.dart';
import '../../../core/utils/restart_app_class.dart';

class CompletedLiveExamWidget extends StatelessWidget {
  const CompletedLiveExamWidget(
      {Key? key, required this.degree, required this.pre})
      : super(key: key);

  final String degree;
  final String pre;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.width / 5,
        ),
        Text(
          'completed_live_exam'.tr(),
          style: TextStyle(
            color: AppColors.secondPrimary,
            fontWeight: FontWeight.bold,
            fontSize: 30,
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.width / 10,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  'degree'.tr(),
                  style: TextStyle(
                    color: AppColors.secondPrimary,
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),
                ),
              ),
              Expanded(
                child: Center(
                  child: Container(
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: AppColors.primary),
                    padding: EdgeInsets.all(22),
                    child: Directionality(
                      textDirection: TextDirection.ltr,
                      child: Text(
                        '$degree',
                        style: TextStyle(
                          color: AppColors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.width / 10,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  'percentage'.tr(),
                  style: TextStyle(
                    color: AppColors.secondPrimary,
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),
                ),
              ),
              Expanded(
                child: Center(
                  child: Container(
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: AppColors.primary),
                    padding: EdgeInsets.all(22),
                    child: Directionality(
                      textDirection: TextDirection.ltr,
                      child: Text(
                        '$pre',
                        style: TextStyle(
                          color: AppColors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Spacer(),
        Spacer(),
        CustomButton(
          paddingHorizontal: 80,
          text: 'done'.tr(),
          color: AppColors.primary,
          onClick: () {
            HotRestartController.performHotRestart(context);
          },
        ),
        Spacer(),
      ],
    );
  }
}
