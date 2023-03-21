import 'package:elmazoon/core/utils/app_colors.dart';
import 'package:elmazoon/core/widgets/show_loading_indicator.dart';
import 'package:elmazoon/feature/mainscreens/study_page/cubit/study_page_cubit.dart';
import 'package:elmazoon/feature/mainscreens/study_page/screens/all_lecture/structure_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/assets_manager.dart';
import '../../models/all_classes_model.dart';
import '../../widgets/container_color_title_widget.dart';
import '../full_exam/stucture_of_exam.dart';

class ClassNameScreen extends StatefulWidget {
  ClassNameScreen({Key? key, required this.model}) : super(key: key);
  final ClassLessons model;

  @override
  State<ClassNameScreen> createState() => _ClassNameScreenState();
}

class _ClassNameScreenState extends State<ClassNameScreen> {
  @override
  void initState() {
    super.initState();
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
          return state is StudyPageLessonsLoading
              ? ShowLoadingIndicator()
              : ListView(
                  children: [
                    ...List.generate(
                      widget.model.lessons.length,
                      (index) => InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => StructureDetailsScreen(
                                titleOfPage: 'lesson',
                                model: widget.model.lessons[index],
                              ),
                            ),
                          );
                        },
                        child: ContainerColorTitleWidget(
                          lesson: widget.model.lessons[index],
                          title: widget.model.lessons[index].name,
                          subTitle: widget.model.lessons[index].note,
                          titleBackground: AppColors.primary,
                          color1: AppColors.blueColor2,
                          color2: AppColors.blueColor1,
                          titleIcon: Icons.video_collection,
                        ),
                      ),
                    ),
                    ...List.generate(
                      widget.model.exams.length,
                      (index) => InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ExamInstruction(
                                examInstruction:
                                    widget.model.exams[index].instruction!,
                              ),
                            ),
                          );
                        },
                        child: ContainerColorTitleWidget(
                          lesson: widget.model.lessons[index],
                          title: widget.model.exams[index].name,
                          subTitle: widget.model.exams[index].note,
                          titleBackground: AppColors.secondPrimary,
                          color1: AppColors.primary,
                          color2: AppColors.primary.withOpacity(0.5),
                          titleIcon: Icons.newspaper,
                        ),
                      ),
                    ),
                  ],
                );
        },
      ),
    );
  }
}
