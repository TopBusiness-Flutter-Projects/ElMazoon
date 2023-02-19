import 'package:flutter/material.dart';

import '../../../../core/utils/app_colors.dart';

class ContainerColorTitleWidget extends StatelessWidget {
  const ContainerColorTitleWidget(
      {Key? key,
      required this.title,
      required this.subTitle,
      required this.titleIcon,
      required this.color1,
      required this.color2,
      required this.titleBackground})
      : super(key: key);

  final String title;
  final String subTitle;
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
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                subTitle,
                style: TextStyle(
                  color: AppColors.secondPrimary,
                  fontSize: 18,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
