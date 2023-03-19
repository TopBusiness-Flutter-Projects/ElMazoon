import 'package:easy_localization/easy_localization.dart';
import 'package:elmazoon/core/utils/assets_manager.dart';
import 'package:elmazoon/core/widgets/custom_button.dart';
import 'package:elmazoon/core/widgets/my_svg_widget.dart';
import 'package:elmazoon/feature/mainscreens/profilePage/cubit/profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/widgets/custom_appbar_widget.dart';
import '../../../../core/widgets/network_image.dart';
import '../../../../core/widgets/show_loading_indicator.dart';
import '../../../payment/screen/payment_screen.dart';
import '../widgets/change_profile_photo.dart';

class ProfilePageDetails extends StatelessWidget {
  const ProfilePageDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String lang = EasyLocalization.of(context)!.locale.languageCode;
    return Scaffold(
      appBar: CustomAppBarWidget(appBarTitle: 'profile'.tr()),
      body: BlocBuilder<ProfileCubit, ProfileState>(
        builder: (context, state) {
          ProfileCubit cubit = context.read<ProfileCubit>();
          return cubit.userModel == null
              ? ShowLoadingIndicator()
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: 150,
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          color: AppColors.success,
                        ),
                        child: Row(
                          children: [
                            MySvgWidget(
                              path: ImageAssets.reportIcon,
                              imageColor: AppColors.white,
                              size: 25,
                            ),
                            Spacer(),
                            Text(
                              'report'.tr(),
                              style: TextStyle(color: AppColors.white),
                            ),
                            Spacer(),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 25,
                    ),
                    Expanded(
                      child: Stack(
                        children: [
                          Positioned(
                            bottom: 0,
                            left: 0,
                            right: 0,
                            child: Container(
                              height: MediaQuery.of(context).size.height - 265,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                  colors: [
                                    AppColors.blueColor1,
                                    AppColors.blueColor2,
                                  ],
                                ),
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(80),
                                  topRight: Radius.circular(80),
                                ),
                              ),
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    SizedBox(height: 70),
                                    Text(
                                      cubit.userModel!.data!.name,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 25,
                                        color: AppColors.secondPrimary,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 25,
                                        vertical: 12,
                                      ),
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                'phone'.tr(),
                                                style: TextStyle(
                                                  color:
                                                      AppColors.secondPrimary,
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              Text(
                                                cubit.userModel!.data!.phone,
                                                style: TextStyle(
                                                  color: AppColors.primary,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 18),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                'father_phone'.tr(),
                                                style: TextStyle(
                                                  color:
                                                      AppColors.secondPrimary,
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              Text(
                                                cubit.userModel!.data!
                                                    .fatherPhone,
                                                style: TextStyle(
                                                  color: AppColors.primary,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 18),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                'end_code'.tr(),
                                                style: TextStyle(
                                                  color:
                                                      AppColors.secondPrimary,
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              Text(
                                                cubit.userModel!.data!
                                                    .dateEndCode
                                                    .toString()
                                                    .split(' ')[0],
                                                style: TextStyle(
                                                  color: AppColors.primary,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 18),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                'student_code'.tr(),
                                                style: TextStyle(
                                                  color:
                                                      AppColors.secondPrimary,
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              Text(
                                                cubit.userModel!.data!.code,
                                                style: TextStyle(
                                                  color: AppColors.primary,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 18),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                'government'.tr(),
                                                style: TextStyle(
                                                  color:
                                                      AppColors.secondPrimary,
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              Text(
                                                lang == 'ar'
                                                    ? cubit.userModel!.data!
                                                        .country!.nameAr
                                                    : cubit.userModel!.data!
                                                        .country!.nameEn,
                                                style: TextStyle(
                                                  color: AppColors.primary,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 18),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                'season'.tr(),
                                                style: TextStyle(
                                                  color:
                                                      AppColors.secondPrimary,
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              Text(
                                                lang == 'ar'
                                                    ? cubit.userModel!.data!
                                                        .season.nameAr
                                                    : cubit.userModel!.data!
                                                        .season.nameEn,
                                                style: TextStyle(
                                                  color: AppColors.primary,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 18),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                'term'.tr(),
                                                style: TextStyle(
                                                  color:
                                                      AppColors.secondPrimary,
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              Text(
                                                lang == 'ar'
                                                    ? cubit.userModel!.data!
                                                        .term.nameAr
                                                    : cubit.userModel!.data!
                                                        .term.nameEn,
                                                style: TextStyle(
                                                  color: AppColors.primary,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 18),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                              vertical: 20,
                                            ),
                                            child: CustomButton(
                                              text: 'renew'.tr(),
                                              color: AppColors.primary,
                                              onClick: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        PaymentScreen(),
                                                  ),
                                                );
                                              },
                                              paddingHorizontal: 50,
                                              borderRadius: 18,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            top: 0,
                            right: 0,
                            left: 0,
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  Stack(
                                    children: [
                                      ManageNetworkImage(
                                        imageUrl: cubit.userModel!.data!.image,
                                        width: 120,
                                        height: 120,
                                        borderRadius: 80,
                                      ),
                                      Positioned(
                                        bottom: 0,
                                        right: 0,
                                        child: InkWell(
                                          onTap: () {
                                            showDialog(
                                              context: context,
                                              builder: (ctx) => AlertDialog(
                                                title: Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(vertical: 5),
                                                  child:
                                                      Text('change_photo'.tr()),
                                                ),
                                                contentPadding: EdgeInsets.zero,
                                                content: ChangeProfilePhoto(),
                                                actions: [
                                                  TextButton(
                                                    onPressed: () {
                                                      context
                                                          .read<ProfileCubit>()
                                                          .pickImage(
                                                              type: 'none');
                                                      Navigator.pop(context);
                                                    },
                                                    child: Text('cancel'.tr()),
                                                  )
                                                ],
                                              ),
                                            );
                                          },
                                          child: Container(
                                            width: 35,
                                            height: 35,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(28),
                                              color: AppColors.primary,
                                            ),
                                            child: Icon(
                                              Icons.camera_alt,
                                              color: AppColors.white,
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
                        ],
                      ),
                    )
                  ],
                );
        },
      ),
    );
  }
}
