import 'package:elmazoon/core/utils/app_colors.dart';
import 'package:elmazoon/core/widgets/show_loading_indicator.dart';
import 'package:elmazoon/feature/mainscreens/study_page/cubit/study_page_cubit.dart';
import 'package:elmazoon/feature/mainscreens/study_page/screens/structure_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/assets_manager.dart';
import '../models/all_classes_model.dart';
import '../widgets/container_color_title_widget.dart';

class ClassNameScreen extends StatefulWidget {
  ClassNameScreen({Key? key, required this.model}) : super(key: key);
  final AllClassesDatum model;

  @override
  State<ClassNameScreen> createState() => _ClassNameScreenState();
}

class _ClassNameScreenState extends State<ClassNameScreen> {
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
  void initState() {
    super.initState();
    context.read<StudyPageCubit>().getLessonsClass(widget.model.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
          child: Text(widget.model.name),
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
      body: BlocBuilder<StudyPageCubit, StudyPageState>(
        builder: (context, state) {
          StudyPageCubit cubit = context.read<StudyPageCubit>();
          return state is StudyPageLessonsLoading
              ? ShowLoadingIndicator()
              : ListView(
                  children: [
                    ...List.generate(
                      cubit.listLessons.length,
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
                          title: cubit.listLessons[index].nameAr,
                          subTitle: cubit.listLessons[index].note,
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
                );
        },
      ),
    );
  }
}
