import 'package:elmazoon/feature/mainscreens/study_page/cubit/study_page_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/models/lessons_details_model.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/widgets/custom_appbar_widget.dart';

import '../../widgets/add_comment_widget.dart';
import '../../widgets/comments_widget.dart';
import '../../widgets/structure_details_widget.dart';
import '../../widgets/video_widget.dart';
import '../full_exam/stucture_of_exam.dart';

class VideoScreen extends StatelessWidget {
  const VideoScreen({Key? key, required this.lessons}) : super(key: key);
  final Lessons lessons;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarWidget(appBarTitle: lessons.name),
      body: Form(
        key: context.read<StudyPageCubit>().formKey,
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      VideoWidget(videoLink: lessons.link, videoId: lessons.id),
                      Text(lessons.note),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              ...List.generate(
                                lessons.exams.length,
                                (index) => SizedBox(
                                  width: MediaQuery.of(context).size.width / 2 -
                                      12,
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              ExamInstruction(
                                                examInstruction:
                                                lessons.exams[index]
                                                    .instruction!,
                                              ),
                                        ),
                                      );
                                    },
                                    child: StructureDetailsWidget(
                                      title: lessons.exams[index].name,
                                      isSmall: true,
                                      titleIcon: Icons.newspaper,
                                      color2: AppColors.primary,
                                      color1: AppColors.primary.withOpacity(0.5),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 12),
                        child: CommentsWidget(lessonsId: lessons.id),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            AddCommentWidget(id: lessons.id, type: 'comment'),
          ],
        ),
      ),
    );
  }
}
