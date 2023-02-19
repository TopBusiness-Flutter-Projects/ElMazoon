import 'package:flutter/material.dart';

import '../../../../core/utils/app_colors.dart';

class StructureDetailsWidget extends StatelessWidget {
  const StructureDetailsWidget({
    Key? key,
    required this.title,
    required this.titleIcon,
    required this.color1,
    required this.color2,
  }) : super(key: key);

  final String title;
  final IconData titleIcon;
  final Color color1;
  final Color color2;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 18),
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
                SizedBox(width: 12),
                Text(
                  title,
                  style: TextStyle(
                    color: AppColors.secondPrimary,
                    fontSize: 20,
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
