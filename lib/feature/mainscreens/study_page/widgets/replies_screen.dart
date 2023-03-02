import 'package:easy_localization/easy_localization.dart';
import 'package:elmazoon/feature/mainscreens/study_page/cubit/study_page_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/models/comments_model.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/widgets/custom_appbar_widget.dart';
import '../../../../core/widgets/network_image.dart';
import 'add_comment_widget.dart';

class RepliesScreen extends StatefulWidget {
  const RepliesScreen(
      {Key? key, required this.commentDatum, required this.index})
      : super(key: key);
  final CommentDatum commentDatum;
  final int index;

  @override
  State<RepliesScreen> createState() => _RepliesScreenState();
}

class _RepliesScreenState extends State<RepliesScreen> {
  @override
  void initState() {
    super.initState();
    context.read<StudyPageCubit>().index = widget.index;
  }

  @override
  Widget build(BuildContext context) {
    timeDilation = 1.5;
    return Scaffold(
      appBar: CustomAppBarWidget(appBarTitle: 'replies'.tr()),
      body: BlocBuilder<StudyPageCubit, StudyPageState>(
        builder: (context, state) {
          StudyPageCubit cubit = context.read<StudyPageCubit>();
          return Form(
            key: cubit.replyFormKey,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Card(
                        color: AppColors.commentBackground,
                        child: Column(
                          children: [
                            Hero(
                              tag: '${widget.commentDatum.id}',
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 3),
                                child: Card(
                                  elevation: 0,
                                  color: AppColors.commentBackground,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 16,
                                      vertical: 8,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width: 60,
                                          height: 60,
                                          child: CircleAvatar(
                                            radius: 60,
                                            backgroundColor:
                                                AppColors.transparent,
                                            child: ManageNetworkImage(
                                              imageUrl: widget
                                                  .commentDatum.user!.image,
                                              width: 60,
                                              height: 60,
                                              borderRadius: 60,
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 16),
                                        Expanded(
                                          child: SingleChildScrollView(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceBetween,
                                              children: [
                                                Row(
                                                  children: [
                                                    Expanded(
                                                      child: Text(
                                                        widget.commentDatum.user!
                                                            .name,
                                                        style: TextStyle(
                                                          color: AppColors
                                                              .secondPrimary,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 18,
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              4.0),
                                                      child: Text(
                                                        '${widget.commentDatum.createdAt!.year}-${widget.commentDatum.createdAt!.month}-${widget.commentDatum.createdAt!.day}',
                                                        style: TextStyle(
                                                            color:
                                                                AppColors.primary,
                                                            fontSize: 12),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                                SizedBox(height: 8),
                                                widget.commentDatum.type == 'text'
                                                    ? Text(
                                                  widget.commentDatum.comment!,
                                                  style: TextStyle(
                                                    color: AppColors.textBackground,
                                                    fontSize: 14,
                                                  ),
                                                )
                                                    :  widget.commentDatum.type ==
                                                    'file'
                                                    ? ManageNetworkImage(
                                                  imageUrl:  widget.commentDatum.image!,
                                                )
                                                    : SizedBox(),
                                                SizedBox(height: 4),
                                                SizedBox(
                                                  height: 20,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      SizedBox(),
                                                      SizedBox(height: 23,),
                                                      Opacity(
                                                        opacity: 0,
                                                        child: Text('reply'.tr()),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Column(
                              children: [
                                ...List.generate(
                                  cubit.commentsList[widget.index].replies!.length,
                                  (index) => Padding(
                                    padding: const EdgeInsets.only(right: 30),
                                    child: Card(
                                      color: AppColors.commentBackground,
                                      elevation: 0,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 0,
                                          vertical: 8,
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              width: 40,
                                              height: 40,
                                              child: CircleAvatar(
                                                radius: 40,
                                                backgroundColor:
                                                    AppColors.transparent,
                                                child: ManageNetworkImage(
                                                  imageUrl: cubit
                                                      .commentsList[
                                                          widget.index]
                                                      .replies![index]
                                                      .user!
                                                      .image,
                                                  width: 40,
                                                  height: 40,
                                                  borderRadius: 40,
                                                ),
                                              ),
                                            ),
                                            SizedBox(width: 16),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Expanded(
                                                        child: Text(
                                                          cubit
                                                              .commentsList[
                                                                  widget.index]
                                                              .replies![index]
                                                              .user!
                                                              .name,
                                                          style: TextStyle(
                                                            color: AppColors
                                                                .secondPrimary,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 16,
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(2.0),
                                                        child: Text(
                                                          '${cubit.commentsList[widget.index].replies![index].createdAt!.year}-${cubit.commentsList[widget.index].replies![index].createdAt!.month}-${cubit.commentsList[widget.index].replies![index].createdAt!.day}',
                                                          style: TextStyle(
                                                            color: AppColors
                                                                .primary,
                                                            fontSize: 10,
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                  SizedBox(height: 6),
                                                  cubit
                                                              .commentsList[
                                                                  widget.index]
                                                              .replies![index]
                                                              .type ==
                                                          'text'
                                                      ? Text(
                                                          cubit
                                                                  .commentsList[
                                                                      widget
                                                                          .index]
                                                                  .replies![
                                                                      index]
                                                                  .comment ??
                                                              '',
                                                          style: TextStyle(
                                                            color: AppColors
                                                                .textBackground,
                                                            fontSize: 12,
                                                          ),
                                                        )
                                                      : cubit
                                                                  .commentsList[
                                                                      widget
                                                                          .index]
                                                                  .replies![
                                                                      index]
                                                                  .type ==
                                                              'file'
                                                          ? ManageNetworkImage(
                                                              imageUrl: cubit
                                                                  .commentsList[
                                                                      widget
                                                                          .index]
                                                                  .replies![
                                                                      index]
                                                                  .image!,
                                                            )
                                                          : SizedBox(),
                                                  SizedBox(height: 2),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  AddCommentWidget(
                      id: cubit.commentsList[widget.index].id!, type: 'reply',),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
