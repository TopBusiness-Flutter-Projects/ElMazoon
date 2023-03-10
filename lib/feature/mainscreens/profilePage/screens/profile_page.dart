import 'package:easy_localization/easy_localization.dart';
import 'package:elmazoon/core/preferences/preferences.dart';
import 'package:elmazoon/core/utils/assets_manager.dart';
import 'package:elmazoon/feature/login/cubit/login_cubit.dart';
import 'package:elmazoon/feature/mainscreens/profilePage/cubit/profile_cubit.dart';
import 'package:elmazoon/feature/mainscreens/profilePage/widgets/profile_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/utils/app_routes.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/call_method.dart';
import '../../../../core/utils/restart_app_class.dart';
import '../../../../core/utils/show_dialog.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    String lang = EasyLocalization.of(context)!.locale.languageCode;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 30),
          child: Column(
            children: [
              InkWell(
                onTap: () {
                  context.read<ProfileCubit>().getTimes(context);
                },
                child: ProfileItemWidget(
                  image: ImageAssets.userEditIcon,
                  title: 'register_paper_exam'.tr(),
                  subTitle: 'register_data_enter_exam'.tr(),
                ),
              ),
              const SizedBox(height: 30),
              InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, Routes.myDegreeRoute);
                  },
                  child: ProfileItemWidget(
                      image: ImageAssets.degreeIcon,
                      title: 'mygards_rate'.tr(),
                      subTitle: 'grades_performance'.tr())),
              const SizedBox(height: 30),
              ProfileItemWidget(
                image: ImageAssets.cupIcon,
                title: 'exam_hero'.tr(),
                subTitle: 'first_exams'.tr(),
              ),
              const SizedBox(height: 30),
              InkWell(
                onTap: () =>
                    {Navigator.pushNamed(context, Routes.monthplansRoute)},
                child: ProfileItemWidget(
                  image: ImageAssets.calenderIcon,
                  title: 'month_plan'.tr(),
                  subTitle: 'month_course'.tr(),
                ),
              ),
              const SizedBox(height: 30),
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, Routes.suggestRoute);
                },
                child: ProfileItemWidget(
                  image: ImageAssets.suggestIcon,
                  title: 'suggest'.tr(),
                  subTitle: 'send_suggest'.tr(),
                ),
              ),
              const SizedBox(height: 30),
              InkWell(
                onTap: () {
                  createProgressDialog(context, 'wait'.tr());
                  context
                      .read<LoginCubit>()
                      .getCommunicationData()
                      .whenComplete(() {
                    Navigator.of(context).pop();
                    showDialog(
                      barrierDismissible: false,
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          backgroundColor: AppColors.white,
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(vertical: 8),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: AppColors.secondPrimary,
                                ),
                                width: double.infinity,
                                child: Center(
                                  child: Text(
                                    'contact_us_from'.tr(),
                                    style: TextStyle(
                                      color: AppColors.white,
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 25),
                              ...List.generate(
                                context
                                    .read<LoginCubit>()
                                    .communicationData
                                    .phones
                                    .length,
                                (index) => InkWell(
                                  onTap: () {
                                    phoneCallMethod(
                                      context
                                          .read<LoginCubit>()
                                          .communicationData
                                          .phones[index]
                                          .phone,
                                    );
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        Image.asset(
                                          ImageAssets.callImage,
                                          width: 30.0,
                                          height: 30.0,
                                          fit: BoxFit.cover,
                                        ),
                                        SizedBox(width: 20),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Text(context
                                                  .read<LoginCubit>()
                                                  .communicationData
                                                  .phones[index]
                                                  .phone),
                                              Text(context
                                                  .read<LoginCubit>()
                                                  .communicationData
                                                  .phones[index]
                                                  .note)
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 25),
                              InkWell(
                                onTap: () => Navigator.of(context).pop(),
                                child: Container(
                                  padding: EdgeInsets.symmetric(vertical: 12),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: AppColors.primary,
                                  ),
                                  width: double.infinity,
                                  child: Center(
                                    child: Text(
                                      'close'.tr(),
                                      style: TextStyle(
                                        color: AppColors.white,
                                        fontSize: 20,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  });
                  // Navigator.pushNamed(context, Routes.suggestRoute);
                },
                child: ProfileItemWidget(
                  image: ImageAssets.callUsIcon,
                  title: 'call_us'.tr(),
                  subTitle: 'contact_us'.tr(),
                ),
              ),
              const SizedBox(height: 30),
              InkWell(
                onTap: () {
                  lang == 'ar'
                      ? EasyLocalization.of(context)!
                          .setLocale(const Locale('en'))
                      : EasyLocalization.of(context)!
                          .setLocale(const Locale('ar'));
                  HotRestartController.performHotRestart(context);
                },
                child: ProfileItemWidget(
                  image: ImageAssets.languageIcon,
                  title: 'language'.tr(),
                  subTitle: 'language_type'.tr(),
                ),
              ),
              const SizedBox(height: 30),
              InkWell(
                onTap: () {
                  Preferences.instance.clearUserData().then(
                        (value) =>
                            HotRestartController.performHotRestart(context),
                      );
                },
                child: ProfileItemWidget(
                  image: ImageAssets.logoutIcon,
                  title: 'logout'.tr(),
                  subTitle: 'logout'.tr(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
