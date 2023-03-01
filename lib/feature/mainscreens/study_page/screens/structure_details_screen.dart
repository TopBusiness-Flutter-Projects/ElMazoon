import 'package:elmazoon/core/utils/app_colors.dart';
import 'package:elmazoon/feature/mainscreens/study_page/cubit/study_page_cubit.dart';
import 'package:elmazoon/feature/mainscreens/study_page/screens/video_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/assets_manager.dart';
import '../../../../core/widgets/custom_appbar_widget.dart';
import '../../../../core/widgets/show_loading_indicator.dart';
import '../models/all_classes_model.dart';
import '../widgets/structure_details_widget.dart';

class StructureDetailsScreen extends StatefulWidget {
  StructureDetailsScreen(
      {Key? key, required this.titleOfPage, required this.model})
      : super(key: key);
  final String titleOfPage;
  final Lesson model;

  @override
  State<StructureDetailsScreen> createState() => _StructureDetailsScreenState();
}

class _StructureDetailsScreenState extends State<StructureDetailsScreen> {
  @override
  void initState() {
    super.initState();
    context.read<StudyPageCubit>().getLessonsDetails(widget.model.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarWidget(appBarTitle: widget.model.name),
      body: BlocBuilder<StudyPageCubit, StudyPageState>(
        builder: (context, state) {
          StudyPageCubit cubit = context.read<StudyPageCubit>();
          if (state is StudyPageLessonsLoading) {
            return ShowLoadingIndicator();
          }
          return ListView(
            children: [
              ...List.generate(
                cubit.lessonsDetailsModel.data.videos.length,
                (index) => InkWell(
                  onTap: () {
                    if (cubit.lessonsDetailsModel.data.videos[index].type ==
                        'video') {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => VideoScreen(
                            lessons:
                                cubit.lessonsDetailsModel.data.videos[index],
                          ),
                        ),
                      );
                    }
                  },
                  child: StructureDetailsWidget(
                    title: cubit.lessonsDetailsModel.data.videos[index].name,
                    titleIcon: cubit
                                .lessonsDetailsModel.data.videos[index].type ==
                            'video'
                        ? Icons.video_collection_rounded
                        : cubit.lessonsDetailsModel.data.videos[index].type ==
                                'pdf'
                            ? Icons.picture_as_pdf
                            : Icons.mic,
                    color2: cubit.lessonsDetailsModel.data.videos[index].type ==
                            'video'
                        ? AppColors.blueColor1
                        : AppColors.blueLiteColor1,
                    color1: cubit.lessonsDetailsModel.data.videos[index].type ==
                            'video'
                        ? AppColors.blueColor2
                        : AppColors.blueLiteColor2,
                  ),
                ),
              ),
              SizedBox(height: 25),
              ...List.generate(
                cubit.lessonsDetailsModel.data.exams.length,
                (index) => StructureDetailsWidget(
                  title: cubit.lessonsDetailsModel.data.exams[index].name,
                  titleIcon: Icons.newspaper,
                  color2: AppColors.primary,
                  color1: AppColors.primary.withOpacity(0.5),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
