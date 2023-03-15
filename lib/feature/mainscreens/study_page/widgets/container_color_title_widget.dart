import 'package:easy_localization/easy_localization.dart';
import 'package:elmazoon/feature/mainscreens/study_page/models/all_classes_model.dart';
import 'package:flutter/material.dart';

import '../../../../core/utils/app_colors.dart';

class ContainerColorTitleWidget extends StatelessWidget {
  const ContainerColorTitleWidget({
    Key? key,
    required this.title,
    required this.subTitle,
    required this.titleIcon,
    required this.color1,
    required this.color2,
    required this.titleBackground,
     this.lesson,
  }) : super(key: key);

  final String title;
  final String subTitle;
  final Lesson? lesson;
  final IconData titleIcon;
  final Color color1;
  final Color color2;
  final Color titleBackground;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [
              color2,
              color1,
            ],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: titleBackground,
                  ),
                  child: Row(
                    children: [
                      Icon(
                        titleIcon,
                        color: AppColors.white,
                      ),
                      SizedBox(width: 12),
                      Text(
                        title,
                        style: TextStyle(
                            color: AppColors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    subTitle,
                    style: TextStyle(
                      color: AppColors.secondPrimary,
                      fontSize: 18,
                    ),
                  ),
                  titleIcon != Icons.video_collection
                      ? SizedBox()
                      : Text(
                          'number_of_videos'.tr() + '  ${lesson!.videosCount}',
                          style: TextStyle(
                            color: AppColors.secondPrimary,
                            fontSize: 18,
                          ),
                        ),
                  titleIcon != Icons.video_collection
                      ? SizedBox()
                      : Text(
                          'total_time_of_videos'.tr() + '  ${lesson!.videosTime}',
                          style: TextStyle(
                            color: AppColors.secondPrimary,
                            fontSize: 18,
                          ),
                        ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
