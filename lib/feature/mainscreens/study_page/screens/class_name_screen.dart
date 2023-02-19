import 'package:elmazoon/core/utils/app_colors.dart';
import 'package:elmazoon/feature/mainscreens/study_page/screens/structure_details_screen.dart';
import 'package:flutter/material.dart';

import '../../../../core/utils/assets_manager.dart';
import '../widgets/container_color_title_widget.dart';

class ClassNameScreen extends StatelessWidget {
  ClassNameScreen({Key? key}) : super(key: key);

  List<String> title = [
    'Lecture',
    'Exam',
    'Lecture',
    'Exam',
    'Exam',
    'Lecture',
    'Exam',
    'Lecture',
    'Lecture',
    'Exam'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
          child: Text('Class Name'),
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
            10,
            (index) => InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => StructureDetailsScreen(
                      titleOfPage: title[index],
                    ),
                  ),
                );
              },
              child: ContainerColorTitleWidget(
                title: title[index],
                subTitle: 'Structure Name',
                titleBackground: title[index] == 'Lecture'
                    ? AppColors.primary
                    : AppColors.secondPrimary,
                color1: title[index] == 'Lecture'
                    ? AppColors.blueColor2
                    : AppColors.primary,
                color2: title[index] == 'Lecture'
                    ? AppColors.blueColor1
                    : AppColors.primary.withOpacity(0.5),
                titleIcon: title[index] == 'Lecture'
                    ? Icons.video_collection
                    : Icons.newspaper,
              ),
            ),
          )
        ],
      ),
    );
  }
}
