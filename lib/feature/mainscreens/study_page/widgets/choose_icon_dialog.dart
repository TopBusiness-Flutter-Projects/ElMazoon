import 'package:flutter/material.dart';

import '../../../../core/utils/app_colors.dart';

class ChooseIconDialog extends StatelessWidget {
  const ChooseIconDialog(
      {Key? key, required this.title, required this.icon, required this.onTap})
      : super(key: key);

  final String title;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 25,
          vertical: 12,
        ),
        child: Row(
          children: [
            Icon(
              icon,
              size: 35,
              color: AppColors.gray,
            ),
            SizedBox(width: 25),
            Text(title),
          ],
        ),
      ),
    );
  }
}
