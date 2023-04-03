import 'package:easy_localization/easy_localization.dart';
import 'package:elmazoon/core/utils/assets_manager.dart';
import 'package:elmazoon/feature/mainscreens/study_page/cubit/study_page_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:like_button/like_button.dart';

import '../../../../../core/models/lessons_details_model.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/widgets/custom_appbar_widget.dart';

import '../../../../../core/widgets/my_svg_widget.dart';
import '../../../../exam/cubit/exam_cubit.dart';
import '../../widgets/add_comment_widget.dart';
import '../../widgets/comments_widget.dart';
import '../../widgets/structure_details_widget.dart';
import '../../widgets/video_widget.dart';
import '../full_exam/stucture_of_exam.dart';

class VideoScreen extends StatefulWidget {
  const VideoScreen({Key? key, required this.lessons}) : super(key: key);
  final Lessons lessons;

  @override
  State<VideoScreen> createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  bool isDownloaded = false;

  @override
  void initState() {
    super.initState();
    context
        .read<StudyPageCubit>()
        .getSavedDownloadedPaths(widget.lessons.downloadSavedPath!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarWidget(appBarTitle: widget.lessons.name!),
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
                      VideoWidget(
                        videoLink: widget.lessons.link!,
                        videoId: widget.lessons.id!,
                      ),
                      Row(
                        children: [
                          LikeButton(
                            size: 40,
                            circleColor: CircleColor(
                              start: Color(0xff2e7dea),
                              end: Color(0xff2e7dea),
                            ),
                            bubblesColor: BubblesColor(
                              dotPrimaryColor: Color(0xff2e7dea),
                              dotSecondaryColor: Color(0xff2e7dea),
                            ),
                            likeBuilder: (bool isLiked) {
                              return Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  MySvgWidget(
                                    path: ImageAssets.likeIcon,
                                    size: 30,
                                    imageColor: isLiked
                                        ? Color(0xff2e7dea)
                                        : Colors.grey,
                                  ),
                                ],
                              );
                            },
                            isLiked:
                                widget.lessons.rate == 'like' ? true : false,
                            onTap: (isLike) async {
                              widget.lessons.rate =
                                  (widget.lessons.rate == 'no_rate' ||
                                          widget.lessons.rate == 'dislike')
                                      ? 'like'
                                      : 'no_rate';
                              setState(() {
                                widget.lessons.likeCount =
                                    widget.lessons.rate == 'dislike'
                                        ? null
                                        : widget.lessons.rate == 'no_rate'
                                            ? widget.lessons.likeCount! - 1
                                            : widget.lessons.likeCount! + 1;

                                widget.lessons.dislikeCount =
                                    widget.lessons.rate == 'dislike'
                                        ? widget.lessons.dislikeCount! - 1
                                        : null;
                              });

                              return !isLike;
                            },
                            likeCount: widget.lessons.likeCount,
                            countBuilder:
                                (int? count, bool isLiked, String text) {
                              var color =
                                  isLiked ? Color(0xff2e7dea) : Colors.grey;
                              return Padding(
                                padding: const EdgeInsets.only(top: 10.0),
                                child: Text(
                                  text,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(color: color),
                                ),
                              );
                            },
                          ),
                          SizedBox(width: 12),
                          LikeButton(
                            size: 40,
                            circleColor: CircleColor(
                              start: Color(0xffff2c2c),
                              end: Color(0xffff2c2c),
                            ),
                            bubblesColor: BubblesColor(
                              dotPrimaryColor: Color(0xffff2c2c),
                              dotSecondaryColor: Color(0xffff2c2c),
                            ),
                            likeBuilder: (bool isLiked) {
                              return Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  MySvgWidget(
                                    path: ImageAssets.dislikeIcon,
                                    size: 30,
                                    imageColor: isLiked
                                        ? Color(0xffff2c2c)
                                        : Colors.grey,
                                  ),
                                ],
                              );
                            },
                            isLiked:
                            widget.lessons.rate == 'like' ? true : false,
                            onTap: (isLike) async {
                              widget.lessons.rate =
                              (widget.lessons.rate == 'no_rate' ||
                                  widget.lessons.rate == 'dislike')
                                  ? 'like'
                                  : 'no_rate';
                              setState(() {
                                widget.lessons.likeCount =
                                widget.lessons.rate == 'dislike'
                                    ? null
                                    : widget.lessons.rate == 'no_rate'
                                    ? widget.lessons.likeCount! - 1
                                    : widget.lessons.likeCount! + 1;

                                widget.lessons.dislikeCount =
                                widget.lessons.rate == 'dislike'
                                    ? widget.lessons.dislikeCount! - 1
                                    : null;
                              });

                              return !isLike;
                            },
                            likeCount: widget.lessons.likeCount,
                            countBuilder:
                                (int? count, bool isLiked, String text) {
                              var color =
                              isLiked ? Color(0xffff2c2c) : Colors.grey;
                              return Padding(
                                padding: const EdgeInsets.only(top: 10.0),
                                child: Text(
                                  text,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(color: color),
                                ),
                              );
                            },
                          ),

                          LikeButton(
                            size: 40,
                            circleColor: CircleColor(
                              start: Color(0xffff2c2c),
                              end: Color(0xffff2c2c),
                            ),
                            bubblesColor: BubblesColor(
                              dotPrimaryColor: Color(0xffff2c2c),
                              dotSecondaryColor: Color(0xffff2c2c),
                            ),
                            likeBuilder: (bool isLiked) {
                              return Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  MySvgWidget(
                                    path: ImageAssets.dislikeIcon,
                                    size: 25,
                                    imageColor: isLiked
                                        ? Color(0xffff2c2c)
                                        : Colors.grey,
                                  ),
                                ],
                              );
                            },
                            likeCount: widget.lessons.dislikeCount,
                            onTap: (isLike) async {
                              setState(() {
                                widget.lessons.rate = 'like';
                                if (widget.lessons.dislikeCount! > 0) {
                                  widget.lessons.dislikeCount =
                                      widget.lessons.dislikeCount! - 1;
                                }
                              });
                              return !isLike;
                            },
                            isLiked:
                                widget.lessons.rate == 'dislike' ? true : false,
                            countBuilder:
                                (int? count, bool isLiked, String text) {
                              print('--------- $text ----------');
                              print('--------- $count ----------');
                              print('--------- $isLiked ----------');

                              var color =
                                  isLiked ? Color(0xffff2c2c) : Colors.grey;
                              return Padding(
                                padding: const EdgeInsets.only(top: 10.0),
                                child: Text(
                                  text,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(color: color),
                                ),
                              );
                            },
                          ),
                          SizedBox(width: 25),
                          Text(widget.lessons.note!),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: [
                                    ...List.generate(
                                      widget.lessons.exams!.length,
                                      (index) => SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                    2 -
                                                12,
                                        child: InkWell(
                                          onTap: () {
                                            context
                                                    .read<ExamCubit>()
                                                    .examTypeId =
                                                widget.lessons.id!;
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    ExamInstruction(
                                                  examInstruction: widget
                                                      .lessons
                                                      .exams![index]
                                                      .instruction!,
                                                ),
                                              ),
                                            );
                                          },
                                          child: StructureDetailsWidget(
                                            title: widget
                                                .lessons.exams![index].name,
                                            isSmall: true,
                                            titleIcon: Icons.newspaper,
                                            color2: AppColors.primary,
                                            color1: AppColors.primary
                                                .withOpacity(0.5),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          BlocBuilder<StudyPageCubit, StudyPageState>(
                            builder: (context, state) {
                              StudyPageCubit cubit =
                                  context.read<StudyPageCubit>();
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: state is SavedDownloadedPathsLoading
                                    ? CircularProgressIndicator(
                                        color: AppColors.secondPrimary,
                                      )
                                    : Column(
                                        children: [
                                          InkWell(
                                            onTap: cubit.isDownloaded
                                                ? null
                                                : () {
                                                    cubit.getPermission(
                                                      widget.lessons.link!,
                                                      widget.lessons.name!,
                                                    );
                                                  },
                                            child: Row(
                                              children: [
                                                Icon(
                                                  cubit.isDownloaded
                                                      ? Icons.check_circle
                                                      : Icons.download,
                                                  color:
                                                      AppColors.secondPrimary,
                                                ),
                                                SizedBox(width: 8),
                                                Text(
                                                  cubit.isDownloaded
                                                      ? 'downloaded'.tr()
                                                      : 'download'.tr(),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(height: 5),
                                          Visibility(
                                            visible: cubit.percentage != 0,
                                            child: Text(
                                              '${cubit.percentage} %',
                                              style: TextStyle(
                                                color: AppColors.primary,
                                                fontSize: 12,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                              );
                            },
                          )
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 12),
                        child: CommentsWidget(lessonsId: widget.lessons.id!),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            AddCommentWidget(id: widget.lessons.id!, type: 'comment'),
          ],
        ),
      ),
    );
  }
}
