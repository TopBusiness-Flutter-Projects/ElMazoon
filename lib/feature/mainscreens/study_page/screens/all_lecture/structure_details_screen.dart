import 'package:easy_localization/easy_localization.dart';
import 'package:elmazoon/core/utils/app_colors.dart';
import 'package:elmazoon/core/utils/toast_message_method.dart';
import 'package:elmazoon/feature/mainscreens/study_page/cubit/study_page_cubit.dart';
import 'package:elmazoon/feature/mainscreens/study_page/screens/all_lecture/pdf_screen.dart';
import 'package:elmazoon/feature/mainscreens/study_page/screens/all_lecture/video_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/widgets/audio_player_widget.dart';
import '../../../../../core/widgets/custom_appbar_widget.dart';
import '../../../../../core/widgets/show_loading_indicator.dart';
import '../../models/all_classes_model.dart';
import '../../widgets/structure_details_widget.dart';
import '../full_exam/stucture_of_exam.dart';

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
    context.read<StudyPageCubit>().accessFirstVideo(widget.model.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarWidget(appBarTitle: widget.model.name),
      body: BlocBuilder<StudyPageCubit, StudyPageState>(
        builder: (context, state) {
          StudyPageCubit cubit = context.read<StudyPageCubit>();
          if (state is StudyPageAccessFirstVideoLoading ||
              state is StudyPageLessonsLoading) {
            return ShowLoadingIndicator();
          }
          if (state is StudyPageAccessFirstVideoLoaded) {
            cubit.getLessonsDetails(widget.model.id);
            return ShowLoadingIndicator();
          }
          return ListView(
            children: [
              ...List.generate(
                cubit.lessonsDetailsModel.data.videos.length,
                (index) => InkWell(
                  onTap: () {
                    if (cubit.lessonsDetailsModel.data.videos[index].status !=
                        'lock') {
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
                      } else if (cubit
                              .lessonsDetailsModel.data.videos[index].type ==
                          'pdf') {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PdfScreen(
                              pdfLink: cubit
                                  .lessonsDetailsModel.data.videos[index].link,
                              pdfTitle: cubit
                                  .lessonsDetailsModel.data.videos[index].name,
                            ),
                          ),
                        );
                      } else if (cubit
                              .lessonsDetailsModel.data.videos[index].type ==
                          'audio') {
                        showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (ctx) => AlertDialog(
                            title: Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 5,
                              ),
                              child: Text(
                                cubit.lessonsDetailsModel.data.videos[index]
                                    .name,
                              ),
                            ),
                            contentPadding: EdgeInsets.zero,
                            content: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 16,
                              ),
                              child: AudioPlayer(
                                source: cubit.lessonsDetailsModel.data
                                    .videos[index].link,
                                onDelete: () {},
                                type: 'no',
                              ),
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text('cancel'.tr()),
                              ),
                            ],
                          ),
                        );
                      }
                    } else {
                      toastMessage(
                        'Please Watch The Previous Video First',
                        context,
                        color: AppColors.error,
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
                (index) => InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            ExamInstruction(
                              examInstruction:
                              cubit.lessonsDetailsModel.data.exams[index]
                                  .instruction!,
                            ),
                      ),
                    );
                  },
                  child: StructureDetailsWidget(
                    title: cubit.lessonsDetailsModel.data.exams[index].name,
                    titleIcon: Icons.newspaper,
                    color2: AppColors.primary,
                    color1: AppColors.primary.withOpacity(0.5),
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
