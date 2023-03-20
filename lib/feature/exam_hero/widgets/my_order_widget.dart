import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../core/models/exam_hero_model.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/widgets/network_image.dart';

class MyOrderWidget extends StatelessWidget {
  const MyOrderWidget({Key? key, required this.heroData}) : super(key: key);

  final HeroData heroData;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.secondPrimary,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(25),
          topLeft: Radius.circular(25),
        ),
      ),
      child: heroData.isOrdered!
          ? Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.primary,
                  ),
                  padding: EdgeInsets.all(15),
                  child: Text(
                    heroData.ordered.toString(),
                    style: TextStyle(
                      color: AppColors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(width: 20),
                Expanded(
                  child: Row(
                    children: [
                      SizedBox(
                        width: 60,
                        height: 60,
                        child: ManageNetworkImage(
                          imageUrl: heroData.image!,
                          width: 60,
                          height: 60,
                          borderRadius: 80,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 20),
                Text(
                  heroData.percentage!,
                  style: TextStyle(
                    color: AppColors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 0),
                  child: Text(
                    'no_order'.tr(),
                    style: TextStyle(
                        color: AppColors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 22),
                  ),
                )
              ],
            ),
    );
  }
}
