import 'package:easy_localization/easy_localization.dart';
import 'package:elmazoon/core/utils/toast_message_method.dart';
import 'package:elmazoon/core/widgets/custom_button.dart';
import 'package:elmazoon/core/widgets/show_loading_indicator.dart';
import 'package:elmazoon/feature/mainscreens/profilePage/cubit/profile_cubit.dart';
import 'package:elmazoon/feature/mainscreens/profilePage/cubit/profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/assets_manager.dart';
import '../../../../core/widgets/brown_line_widget.dart';
import '../../../../core/widgets/custom_textfield.dart';

class SuggestScreen extends StatelessWidget {
  SuggestScreen({Key? key}) : super(key: key);

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'suggest'.tr(),
                style: TextStyle(
                  color: AppColors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'send_suggest'.tr(),
                style: TextStyle(
                  color: AppColors.primary,
                  fontSize: 18,
                ),
              ),
            ],
          ),
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(ImageAssets.appBarImage),
              fit: BoxFit.fill,
            ),
          ),
        ),
      ),
      body: BlocBuilder<ProfileCubit, ProfileState>(
        builder: (context, state) {
          ProfileCubit cubit = context.read<ProfileCubit>();

          if (state is ProfileSendSuggestLoading) {
            return ShowLoadingIndicator();
          }
          if (state is ProfileSendSuggestLoaded) {
            Future.delayed(Duration(milliseconds: 350), () {
              toastMessage(
                'send_success'.tr(),
                context,
                color: AppColors.success,
              );
              Future.delayed(Duration(milliseconds: 350), () {
                Navigator.pop(context);
              });
            });
            return ShowLoadingIndicator();
          }

          if (state is ProfileSendSuggestLoaded) {
            Future.delayed(Duration(milliseconds: 350), () {
              toastMessage(
                'send_failure'.tr(),
                context,
                color: AppColors.error,
              );
            });
          }

          return SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height / 12),
                  Image.asset(
                    ImageAssets.suggestImage,
                    fit: BoxFit.cover,
                    height: 300,
                  ),
                  CustomTextField(
                    controller: cubit.studentName,
                    suffixWidget : null,
                    isEnable: false,
                    imageColor: AppColors.secondPrimary,
                    backgroundColor: AppColors.transparent,
                    title: 'student_name'.tr(),
                    validatorMessage: 'student_name_valid'.tr(),
                    textInputType: TextInputType.text,
                  ),
                  const BrownLineWidget(),
                  CustomTextField(
                    controller: cubit.cityName,
                    suffixWidget : null,
                    isEnable: false,
                    imageColor: AppColors.secondPrimary,
                    backgroundColor: AppColors.transparent,
                    title: 'city_name'.tr(),
                    validatorMessage: 'city_name_valid'.tr(),
                    textInputType: TextInputType.text,
                  ),
                  const BrownLineWidget(),
                  CustomTextField(
                    controller: cubit.studentCode,
                    suffixWidget : null,
                    isEnable: false,
                    imageColor: AppColors.secondPrimary,
                    backgroundColor: AppColors.transparent,
                    title: 'student_code'.tr(),
                    validatorMessage: 'student_code_valid'.tr(),
                    textInputType: TextInputType.number,
                  ),
                  const BrownLineWidget(),
                  CustomTextField(
                    controller: cubit.suggest,
                    suffixWidget : null,
                    isEnable: true,
                    imageColor: AppColors.secondPrimary,
                    backgroundColor: AppColors.transparent,
                    title: 'suggest'.tr(),
                    validatorMessage: 'suggest_valid'.tr(),
                    minLine: 5,
                    textInputType: TextInputType.text,
                  ),
                  const BrownLineWidget(),
                  SizedBox(height: 100),
                  CustomButton(
                    text: 'sent'.tr(),
                    paddingHorizontal: 80,
                    color: AppColors.primary,
                    onClick: () {
                      if (formKey.currentState!.validate()) {
                        print('OK');
                        cubit.sendSuggest();
                      }
                    },
                  ),
                  SizedBox(height: 25),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
