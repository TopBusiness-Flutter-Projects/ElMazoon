import 'package:flutter/material.dart';

import '../../../core/utils/app_colors.dart';

class ItemOfFinalReviewWidget extends StatelessWidget {
  const ItemOfFinalReviewWidget({
    Key? key,
    required this.classNum,
    required this.imagePath,
    required this.mainColor,
  }) : super(key: key);
  final String classNum;
  final String imagePath;
  final Color mainColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180,
      width: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: mainColor,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Text(
              classNum,
              style: TextStyle(color: AppColors.white, fontSize: 20,fontWeight: FontWeight.bold),
            ),
          ),
          Spacer(),
          Align(
            alignment: Alignment.bottomRight,
            child: SizedBox(
              width: 85,
              height: 85,
              child: Image.asset(imagePath),
            ),
          ),
        ],
      ),
    );
  }
}
