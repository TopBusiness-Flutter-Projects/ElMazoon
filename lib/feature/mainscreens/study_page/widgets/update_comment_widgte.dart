import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/models/comments_model.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/show_dialog.dart';
import '../../../../core/widgets/custom_appbar_widget.dart';
import '../../../../core/widgets/custom_textfield.dart';
import '../../../../core/widgets/dialog_choose_screen.dart';
import '../../../../core/widgets/network_image.dart';
import '../cubit/study_page_cubit.dart';

class UpdateComment extends StatefulWidget {
  const UpdateComment({
    Key? key,
    required this.type,
    required this.comment,
    required this.commentIndex,
  }) : super(key: key);

  final String type;
  final int commentIndex;
  final CommentDatum comment;

  @override
  State<UpdateComment> createState() => _UpdateCommentState();
}

class _UpdateCommentState extends State<UpdateComment> {
  @override
  void initState() {
    super.initState();
    context.read<StudyPageCubit>().isValidUpdate = false;
    if (widget.type == 'comment') {
      context.read<StudyPageCubit>().updateCommentController.text =
          widget.comment.comment!;
    } else {
      context.read<StudyPageCubit>().updateReplyController.text =
          widget.comment.comment!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarWidget(appBarTitle: 'update'.tr()),
      body: BlocBuilder<StudyPageCubit, StudyPageState>(
        builder: (context, state) {
          StudyPageCubit cubit = context.read<StudyPageCubit>();
          if (state is StudyPageUpdateCommentLoaded) {
            Navigator.pop(context);
            Future.delayed(Duration(milliseconds: 300), () {
              Navigator.pop(context);
            });
          }
          return SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        elevation: 5,
                        color: AppColors.secondPrimary.withOpacity(.7),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 40,
                                height: 40,
                                child: Center(
                                  child: CircleAvatar(
                                    radius: 40,
                                    backgroundColor: AppColors.transparent,
                                    child: ManageNetworkImage(
                                      imageUrl: cubit.userModel!.data!.image,
                                      width: 40,
                                      height: 40,
                                      borderRadius: 40,
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: CustomTextField(
                                  controller: widget.type == 'comment'
                                      ? cubit.updateCommentController
                                      : cubit.updateReplyController,
                                  isEnable: cubit.isCommentFieldEnable,
                                  title: 'add_comment'.tr(),
                                  validatorMessage: 'add_comment_valid'.tr(),
                                  backgroundColor: AppColors.commentBackground,
                                  textInputType: TextInputType.text,
                                  onchange: (change) {
                                    if (change.length <= 0 ||
                                        change == widget.comment.comment) {
                                      cubit.changeValidUpdate(false);
                                    } else {
                                      cubit.changeValidUpdate(true);
                                    }
                                  },
                                ),
                              ),
                              MaterialButton(
                                onPressed: cubit.isValidUpdate
                                    ? () {
                                        print(
                                          '*****************************************',
                                        );
                                        createProgressDialog(
                                          context,
                                          'wait'.tr(),
                                        );
                                        cubit.updateCommentAndReply(
                                          widget.comment.id!,
                                          widget.type,
                                          widget.commentIndex,
                                        );
                                      }
                                    : null,
                                height: 56.0,
                                disabledColor: AppColors.gray4,
                                minWidth: 75,
                                child: Text(
                                  'update'.tr(),
                                  style: TextStyle(
                                      color: AppColors.white, fontSize: 16.0),
                                ),
                                color: cubit.isValidUpdate
                                    ? AppColors.primary
                                    : AppColors.gray4,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 5,
                      left: 5,
                      child: InkWell(
                        onTap: () => Navigator.pop(context),
                        child: Container(
                          width: 25,
                          height: 25,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.primary,
                          ),
                          child: Icon(
                            Icons.close,
                            color: AppColors.white,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
