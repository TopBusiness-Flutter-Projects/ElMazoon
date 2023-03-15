import 'package:flutter/material.dart';

import '../../../../core/utils/app_colors.dart';

class StructureDetailsWidget extends StatelessWidget {
  const StructureDetailsWidget({
    Key? key,
    required this.title,
    required this.titleIcon,
    required this.color1,
    required this.color2,
    this.isSmall = false,
  }) : super(key: key);

  final String title;
  final IconData titleIcon;
  final Color color1;
  final Color color2;
  final bool? isSmall;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: isSmall! ? 6 : 12,
        vertical: isSmall! ? 4 : 8,
      ),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: isSmall! ? 6 : 12,
          vertical: isSmall! ? 9 : 18,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [
              color1,
              color2,
            ],
          ),
        ),
        child: Row(
          children: [
            Row(
              children: [
                Icon(
                  titleIcon,
                  color: AppColors.secondPrimary,
                ),
                SizedBox(width: isSmall! ? 6 : 12),
                Text(
                  title,
                  style: TextStyle(
                    color: AppColors.secondPrimary,
                    fontSize: isSmall! ? 12 : 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
