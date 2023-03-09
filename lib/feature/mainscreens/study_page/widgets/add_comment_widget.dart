import 'package:easy_localization/easy_localization.dart';
import 'package:elmazoon/core/widgets/custom_textfield.dart';
import 'package:elmazoon/feature/mainscreens/study_page/cubit/study_page_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/widgets/dialog_choose_screen.dart';
import '../../../../core/widgets/network_image.dart';
import 'choose_icon_dialog.dart';

class AddCommentWidget extends StatelessWidget {
  AddCommentWidget({Key? key, required this.id, required this.type})
      : super(key: key);
  final int id;
  final String type;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StudyPageCubit, StudyPageState>(
      builder: (context, state) {
        StudyPageCubit cubit = context.read<StudyPageCubit>();
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
                      imageUrl: cubit.userModel.data!.image,
                      width: 40,
                      height: 40,
                      borderRadius: 40,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: CustomTextField(
                  controller: type == 'comment'
                      ? cubit.commentController
                      : cubit.replyController,
                  isEnable: cubit.isCommentFieldEnable,
                  title: 'add_comment'.tr(),
                  validatorMessage: 'add_comment_valid'.tr(),
                  backgroundColor: AppColors.commentBackground,
                  suffixWidget: IconButton(
                    icon: Icon(Icons.attach_file),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (ctx) => AlertDialog(
                          title: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: Text('choose'.tr()),
                          ),
                          contentPadding: EdgeInsets.zero,
                          content: SizedBox(
                            width: MediaQuery.of(context).size.width - 60,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                ChooseIconDialog(
                                  title: 'camera'.tr(),
                                  icon: Icons.camera_alt,
                                  onTap: () {
                                    cubit.pickImage(type: 'camera');
                                    Navigator.of(context).pop();
                                    Future.delayed(Duration(milliseconds: 500),
                                        () {
                                      showDialog(
                                        context: context,
                                        barrierDismissible: false,
                                        builder: (ctx) => AlertDialog(
                                          title: Padding(
                                            padding: const EdgeInsets.symmetric(
                                              vertical: 5,
                                            ),
                                            child: Text('photo'.tr()),
                                          ),
                                          contentPadding: EdgeInsets.zero,
                                          content: RecordWidget(
                                            type: 'image',
                                            sendType: type,
                                            id: id,
                                          ),
                                        ),
                                      );
                                    });
                                  },
                                ),
                                ChooseIconDialog(
                                  title: 'photo'.tr(),
                                  icon: Icons.photo,
                                  onTap: () {
                                    cubit.pickImage(type: 'photo');
                                    Navigator.of(context).pop();
                                    Future.delayed(Duration(milliseconds: 500),
                                        () {
                                      showDialog(
                                        context: context,
                                        barrierDismissible: false,
                                        builder: (ctx) => AlertDialog(
                                          title: Padding(
                                            padding: const EdgeInsets.symmetric(
                                              vertical: 5,
                                            ),
                                            child: Text('photo'.tr()),
                                          ),
                                          contentPadding: EdgeInsets.zero,
                                          content: RecordWidget(
                                            type: 'image',
                                            sendType: type,
                                            id: id,
                                          ),
                                        ),
                                      );
                                    });
                                  },
                                ),
                                ChooseIconDialog(
                                  title: 'voice'.tr(),
                                  icon: Icons.mic,
                                  onTap: () {
                                    Navigator.pop(context);
                                    Future.delayed(Duration(milliseconds: 500),
                                        () {
                                      showDialog(
                                        context: context,
                                        barrierDismissible: false,
                                        builder: (ctx) => AlertDialog(
                                          title: Padding(
                                            padding: const EdgeInsets.symmetric(
                                              vertical: 5,
                                            ),
                                            child: Text('voice'.tr()),
                                          ),
                                          contentPadding: EdgeInsets.zero,
                                          content: RecordWidget(
                                            type: 'voice',
                                            sendType: type,
                                            id: id,
                                          ),
                                        ),
                                      );
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text('cancel'.tr()),
                            )
                          ],
                        ),
                      );
                    },
                  ),
                  textInputType: TextInputType.text,
                ),
              ),
              state is StudyPageAddCommentLoading
                  ? CircularProgressIndicator(color: AppColors.secondPrimary)
                  : IconButton(
                      onPressed: () {
                        if (type == 'comment') {
                          if (cubit.formKey.currentState!.validate()) {
                            cubit.addComment(id, 'text');
                          }
                        } else {
                          if (cubit.replyFormKey.currentState!.validate()) {
                            cubit.addReply(id, 'text');
                          }
                        }
                      },
                      icon: Icon(
                        Icons.send,
                        color: AppColors.secondPrimary,
                      ),
                    ),
            ],
          ),
        );
      },
    );
  }
}

/*






*/
