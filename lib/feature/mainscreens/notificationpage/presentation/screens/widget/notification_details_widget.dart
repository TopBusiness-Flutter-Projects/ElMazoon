import 'package:elmazoon/core/models/notifications_model.dart';
import 'package:flutter/material.dart';

import '../../../../../../core/utils/app_colors.dart';


class NotificationDetailsWidget extends StatelessWidget {
   NotificationDetailsWidget({
    Key? key,
    required this.notificationModel,

  }) : super(key: key);

  final NotificationModel notificationModel;


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.access_time_filled_rounded,
                  color: AppColors.primary,
                ),
                SizedBox(width: 12),
                Text(
                  notificationModel.createdAt!,
                  style: TextStyle(
                    // color: AppColors.gray1,
                    fontSize: 20,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ],
            ),
            Text(
              notificationModel.title!,
              style: TextStyle(
                // color: AppColors.gray1,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              notificationModel.body!,
              style: TextStyle(
                // color: AppColors.gray1,
                fontSize: 20,
                fontWeight: FontWeight.normal,
              ),
            ),
            SizedBox(height: 5,),
            Divider(
              height: 1,
              thickness: 1,
              color: AppColors.unselectedTab

            )
          ],
        ),
      ),
    );
  }
}
