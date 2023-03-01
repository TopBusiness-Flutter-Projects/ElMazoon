import 'package:easy_localization/easy_localization.dart';
import 'package:elmazoon/core/widgets/custom_textfield.dart';
import 'package:elmazoon/feature/mainscreens/study_page/cubit/study_page_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/models/lessons_details_model.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/widgets/network_image.dart';

class AddCommentWidget extends StatelessWidget {
  AddCommentWidget({Key? key, required this.lessons}) : super(key: key);
  final Lessons lessons;

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
                  controller: cubit.commentController,
                  isEnable: cubit.isCommentFieldEnable,
                  title: 'add_comment'.tr(),
                  validatorMessage: 'add_comment_valid'.tr(),
                  backgroundColor: AppColors.commentBackground,
                  image: 'null',
                  textInputType: TextInputType.text,
                ),
              ),
              state is StudyPageAddCommentLoading
                  ? CircularProgressIndicator(color: AppColors.secondPrimary)
                  : IconButton(
                      onPressed: () {
                        if (cubit.formKey.currentState!.validate()) {
                          cubit.addComment(lessons.id, 'text');
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
