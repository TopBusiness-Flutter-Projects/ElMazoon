import 'package:easy_localization/easy_localization.dart';
import 'package:elmazoon/core/utils/app_colors.dart';
import 'package:elmazoon/feature/mainscreens/study_page/cubit/study_page_cubit.dart';
import 'package:elmazoon/feature/mainscreens/study_page/widgets/replies_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/widgets/network_image.dart';
import '../../../../core/widgets/show_loading_indicator.dart';
import '../../../../testing/aduio_player.dart';

class CommentsWidget extends StatefulWidget {
  const CommentsWidget({Key? key, required this.lessonsId}) : super(key: key);

  final int lessonsId;

  @override
  State<CommentsWidget> createState() => _CommentsWidgetState();
}

class _CommentsWidgetState extends State<CommentsWidget> {
  @override
  void initState() {
    super.initState();
    context.read<StudyPageCubit>().getCommentsLesson(widget.lessonsId);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'comments'.tr(),
          style: TextStyle(
            color: AppColors.secondPrimary,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 12),
        BlocBuilder<StudyPageCubit, StudyPageState>(
          builder: (context, state) {
            StudyPageCubit cubit = context.read<StudyPageCubit>();
            if (state is StudyPageCommentsLessonsLoading) {
              return ShowLoadingIndicator();
            }
            return Column(
              children: [
                ...List.generate(
                  cubit.commentsList.length,
                  (index) => Hero(
                    tag: '${cubit.commentsList[index].id}',
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 3),
                      child: Card(
                        color: AppColors.commentBackground,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 60,
                                height: 60,
                                child: CircleAvatar(
                                  radius: 60,
                                  backgroundColor: AppColors.transparent,
                                  child: ManageNetworkImage(
                                    imageUrl:
                                        cubit.commentsList[index].user!.image,
                                    width: 60,
                                    height: 60,
                                    borderRadius: 60,
                                  ),
                                ),
                              ),
                              SizedBox(width: 18),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            cubit
                                                .commentsList[index].user!.name,
                                            style: TextStyle(
                                              color: AppColors.secondPrimary,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: Text(
                                            '${cubit.commentsList[index].createdAt!.year}-${cubit.commentsList[index].createdAt!.month}-${cubit.commentsList[index].createdAt!.day}',
                                            style: TextStyle(
                                                color: AppColors.primary,
                                                fontSize: 12),
                                          ),
                                        )
                                      ],
                                    ),
                                    SizedBox(height: 8),
                                    cubit.commentsList[index].type == 'text'
                                        ? Text(
                                            cubit.commentsList[index].comment!,
                                            style: TextStyle(
                                              color: AppColors.textBackground,
                                              fontSize: 14,
                                            ),
                                          )
                                        : cubit.commentsList[index].type ==
                                                'file'
                                            ? ManageNetworkImage(
                                                imageUrl: cubit
                                                    .commentsList[index].image!,
                                              )
                                            : Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 8),
                                                child: AudioPlayer(
                                                  source: cubit
                                                      .commentsList[index]
                                                      .audio!,
                                                  onDelete: () {},
                                                  type: 'onlyShow',
                                                ),
                                              ),
                                    SizedBox(height: 4),
                                    SizedBox(
                                      height: 20,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          cubit.commentsList[index].replies!
                                                  .isNotEmpty
                                              ? InkWell(
                                                  onTap: () {
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            RepliesScreen(
                                                          commentDatum: cubit
                                                                  .commentsList[
                                                              index],
                                                          index: index,
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                  child: Center(
                                                    child: Text(
                                                      '${'show_reply'.tr()} ${cubit.commentsList[index].replies!.length}',
                                                      style: TextStyle(
                                                        color: Colors.blue,
                                                      ),
                                                      textAlign: TextAlign.end,
                                                    ),
                                                  ),
                                                )
                                              : SizedBox(),
                                          InkWell(
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      RepliesScreen(
                                                    commentDatum: cubit
                                                        .commentsList[index],
                                                    index: index,
                                                  ),
                                                ),
                                              );
                                            },
                                            child: SizedBox(
                                              width: 40,
                                              child: Center(
                                                child: Text(
                                                  'reply'.tr(),
                                                  style: TextStyle(
                                                    color: Colors.blue,
                                                  ),
                                                  textAlign: TextAlign.end,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                cubit.comments.links.next.isNotEmpty
                    ? state is StudyPageMoreCommentsLessonsLoading
                        ? Padding(
                            padding: EdgeInsets.symmetric(vertical: 12),
                            child: SizedBox(
                              width: 25,
                              height: 25,
                              child: CircularProgressIndicator(
                                color: AppColors.secondPrimary,
                              ),
                            ),
                          )
                        : Align(
                            alignment: cubit.lan == 'en'
                                ? Alignment.centerLeft
                                : Alignment.centerRight,
                            child: TextButton(
                              onPressed: () {
                                cubit.getMoreCommentsLesson();
                              },
                              child: Text('more_comment'.tr()),
                            ),
                          )
                    : SizedBox(),
              ],
            );
          },
        ),
      ],
    );
  }
}
