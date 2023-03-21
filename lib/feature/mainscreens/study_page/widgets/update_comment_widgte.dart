import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/widgets/custom_appbar_widget.dart';
import '../../../../core/widgets/custom_textfield.dart';
import '../../../../core/widgets/dialog_choose_screen.dart';
import '../../../../core/widgets/network_image.dart';
import '../cubit/study_page_cubit.dart';

class UpdateComment extends StatelessWidget {
  const UpdateComment({Key? key, required this.type}) : super(key: key);

  final String type;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarWidget(appBarTitle: 'edit'.tr()),
      body: BlocBuilder<StudyPageCubit, StudyPageState>(
        builder: (context, state) {
          StudyPageCubit cubit = context.read<StudyPageCubit>();
          return Column(
            children: [
              Padding(
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
                        controller: type == 'comment'
                            ? cubit.commentController
                            : cubit.replyController,
                        isEnable: cubit.isCommentFieldEnable,
                        title: 'add_comment'.tr(),
                        validatorMessage: 'add_comment_valid'.tr(),
                        backgroundColor: AppColors.commentBackground,
                        textInputType: TextInputType.text,
                      ),
                    ),
                  ],
                ),
              ),
              state is StudyPageAddCommentLoading
                  ? CircularProgressIndicator(color: AppColors.secondPrimary)
                  : IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.send,
                  color: AppColors.secondPrimary,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
