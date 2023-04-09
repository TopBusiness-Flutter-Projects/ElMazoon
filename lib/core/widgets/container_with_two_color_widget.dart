import 'package:elmazoon/core/utils/app_colors.dart';
import 'package:flutter/material.dart';

import '../utils/assets_manager.dart';
import 'network_image.dart';

class ContainerWithTwoColorWidget extends StatelessWidget {
  const ContainerWithTwoColorWidget({
    Key? key,
    required this.imagePath,
    required this.title,
    required this.color1,
    required this.color2,
    required this.textColor,
    this.isHome = false,
  }) : super(key: key);

  final String imagePath;
  final String title;
  final Color color1;
  final Color color2;
  final Color textColor;
  final bool? isHome;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: isHome!
            ? null
            : LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  color1,
                  color2,
                ],
              ),
        color: isHome! ? AppColors.transparent : null,
      ),
      child: Column(
        children: [
          const Spacer(),
          imagePath.isEmpty
              ? Image.asset(ImageAssets.logoImage)
              : ManageNetworkImage(
                  imageUrl: imagePath,
                  borderRadius: 90,
                  width: 60,
                  height: 60,
                ),
          const Spacer(),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              // color: textColor,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
