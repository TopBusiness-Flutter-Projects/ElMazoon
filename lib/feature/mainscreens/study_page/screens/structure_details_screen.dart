import 'package:elmazoon/core/utils/app_colors.dart';
import 'package:flutter/material.dart';

import '../../../../core/utils/assets_manager.dart';
import '../models/all_classes_model.dart';
import '../widgets/structure_details_widget.dart';

class StructureDetailsScreen extends StatelessWidget {
  StructureDetailsScreen({Key? key, required this.titleOfPage, required this.model})
      : super(key: key);
  final String titleOfPage;
  final Lesson model;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
          child: Text(model.name),
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(ImageAssets.appBarImage),
              fit: BoxFit.fill,
            ),
          ),
        ),
      ),
      body: ListView(
        children: [
          ...List.generate(
            model.videosCount,
            (index) => StructureDetailsWidget(
              title: 'Lecture Part ${index+1}',
              titleIcon: Icons.video_collection_rounded,
              color2: AppColors.blueColor1,
              color1: AppColors.blueColor2,
            ),
          ),
          StructureDetailsWidget(
            title: 'PDF',
            titleIcon: Icons.picture_as_pdf,
            color2: AppColors.blueLiteColor1,
            color1: AppColors.blueLiteColor2,
          ),
          StructureDetailsWidget(
            title: 'Voice',
            titleIcon: Icons.mic,
            color2: AppColors.primary,
            color1: AppColors.primary.withOpacity(0.5),
          ),
        ],
      ),
    );
  }
}
