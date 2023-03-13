import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:elmazoon/core/widgets/custom_button.dart';
import 'package:elmazoon/feature/navigation_bottom/cubit/navigation_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/widgets/show_loading_indicator.dart';
import '../cubit/profile_cubit.dart';

class ChangeProfilePhoto extends StatelessWidget {
  const ChangeProfilePhoto({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        ProfileCubit cubit = context.read<ProfileCubit>();
        if (state is ProfileUpdateLoading) {
          return SizedBox(
            width: MediaQuery.of(context).size.width - 60,
            height: 150,
            child: Center(
              child: CircularProgressIndicator(
                color: AppColors.primary,
              ),
            ),
          );
        }
        if (state is ProfileSendSuggestLoaded) {
          context.read<NavigationCubit>().getUserData();
          Future.delayed(Duration(milliseconds: 300), () {
            Navigator.pop(context);
          });
        }
        return SizedBox(
          width: MediaQuery.of(context).size.width - 60,
          child: cubit.imagePath.isEmpty
              ? Row(
                  children: [
                    const Spacer(),
                    InkWell(
                      onTap: () {
                        cubit.pickImage(type: 'camera');
                      },
                      child: SizedBox(
                        height: 80,
                        width: 80,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.camera_alt,
                              size: 45,
                              color: AppColors.gray,
                            ),
                            Text('camera'.tr())
                          ],
                        ),
                      ),
                    ),
                    const Spacer(),
                    InkWell(
                      onTap: () {
                        cubit.pickImage(type: 'photo');
                      },
                      child: SizedBox(
                        height: 80,
                        width: 80,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.photo, size: 45, color: AppColors.gray),
                            Text('photo'.tr())
                          ],
                        ),
                      ),
                    ),
                    const Spacer(),
                  ],
                )
              : Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Stack(
                      children: [
                        SizedBox(
                          width: 140,
                          height: 140,
                          child: ClipOval(
                            child: Image.file(
                              File(cubit.imagePath),
                              width: 90.0,
                              height: 90.0,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Positioned(
                          top: 8,
                          right: 8,
                          child: InkWell(
                            onTap: () => cubit.pickImage(type: 'none'),
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25),
                                  color: AppColors.primary),
                              child: Icon(
                                Icons.close,
                                color: AppColors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 25),
                    CustomButton(
                      text: 'update'.tr(),
                      color: AppColors.primary,
                      onClick: () {
                        cubit.updateProfileImage();
                      },
                      paddingHorizontal: 100,
                    ),
                  ],
                ),
        );
      },
    );
  }
}
