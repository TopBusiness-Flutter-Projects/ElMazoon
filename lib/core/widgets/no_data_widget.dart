import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../utils/app_colors.dart';

class NoDataWidget extends StatelessWidget {
  const NoDataWidget({Key? key, required this.onclick}) : super(key: key);

  final VoidCallback onclick;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onclick,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'no_date'.tr(),
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: AppColors.secondPrimary,
            ),
          ),
          SizedBox(
            height: 12,
            width: MediaQuery.of(context).size.width,
          ),
          Icon(
            Icons.refresh,
            color: AppColors.primary,
          ),
        ],
      ),
    );
  }
}
