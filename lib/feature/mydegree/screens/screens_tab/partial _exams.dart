import 'package:flutter/material.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/widgets/container_text_with_two_color_widget.dart';
import '../../../../core/models/my_degree_model.dart';

class PartialExams extends StatelessWidget {
  const PartialExams({Key? key, required this.examList}) : super(key: key);
  final List<ExamDetailsModel> examList ;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        itemCount: examList.length,
        itemBuilder: (context, index) {
          return ContainerTextWithTwoColorWidget(
            title: examList[index].name!,
            color1: AppColors.primary,
            color2: AppColors.primary,
            degree: examList[index].degree!,
            textColor: AppColors.secondPrimary,
            colorOpacity: 0.5,
          );
        },
      ),
    );
  }
}
