import 'package:flutter/material.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/widgets/container_text_with_two_color_widget.dart';

class Partialexams extends StatelessWidget {
  const Partialexams({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return ContainerTextWithTwoColorWidget(
            title: "امتحان شامل على المحاضرة الاولى",
            color1: AppColors.primary,
            color2: AppColors.primary,
            degree: "20/30",
            textColor: AppColors.secondPrimary,
            colorOpacity: 0.5,
          );
        },
      ),
    );
  }
}
