import 'package:elmazoon/core/utils/app_colors.dart';
import 'package:flutter/material.dart';

import '../../../../core/utils/assets_manager.dart';
import '../widgets/structure_details_widget.dart';

class StructureDetailsScreen extends StatelessWidget {
  StructureDetailsScreen({Key? key, required this.titleOfPage})
      : super(key: key);
  final String titleOfPage;

  List<String> title = [
    'Lecture Part 1',
    'Lecture Part 2',
    'Voice',
    'PDF',
    'Exam'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
          child: Text(titleOfPage),
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
            title.length,
            (index) => StructureDetailsWidget(
              title: title[index],
              titleIcon: title[index] == 'Voice'
                  ? Icons.mic
                  : title[index] == 'PDF'
                      ? Icons.picture_as_pdf
                      : title[index] == 'Exam'
                          ? Icons.article
                          : Icons.video_collection_rounded,
              color2: title[index] == 'Exam'
                  ? AppColors.primary
                  : (title[index] == 'Voice' || title[index] == 'PDF')
                      ? AppColors.blueLiteColor1
                      : AppColors.blueColor1,
              color1: title[index] == 'Exam'
                  ? AppColors.primary.withOpacity(0.5)
                  : (title[index] == 'Voice' || title[index] == 'PDF')
                  ? AppColors.blueLiteColor2
                  : AppColors.blueColor2,
            ),
          )
        ],
      ),
    );
  }
}
