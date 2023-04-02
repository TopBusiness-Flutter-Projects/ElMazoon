import 'package:easy_localization/easy_localization.dart';
import 'package:elmazoon/core/preferences/preferences.dart';
import 'package:elmazoon/core/utils/assets_manager.dart';
import 'package:elmazoon/core/utils/toast_message_method.dart';
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
import '../../../exam_hero/screens/exam_hero.dart';
import '../../../live_exam/screens/live_exam_screen.dart';
import '../widgets/customAppbar.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key, this.isAppBar = false}) : super(key: key);
  final bool? isAppBar;

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    String lang = EasyLocalization.of(context)!.locale.languageCode;
    return Scaffold(
      appBar: widget.isAppBar!?AppBar(
        toolbarHeight: 90,
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
          child: CustomAppBar(),
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(ImageAssets.appBarImage),
              fit: BoxFit.fill,
            ),
          ),
        ),
      ):null,
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 30),
          child: Column(
            children: [
              // InkWell(
              //   onTap: () {
              //     Navigator.push(
              //       context,
              //       MaterialPageRoute(
              //         builder: (context) => LiveExamScreen(),
              //       ),
              //     );
              //   },
              //   child: ProfileItemWidget(
              //     image: ImageAssets.downloadVideoIcon,
              //     title: 'live_exam'.tr(),
              //     subTitle: 'live_exam'.tr(),
              //   ),
              // ),
              // const SizedBox(height: 30),
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, Routes.downloadsRoute);
                },
                child: ProfileItemWidget(
                  image: ImageAssets.downloadVideoIcon,
                  title: 'downloads_videos'.tr(),
                  subTitle: 'downloads_videos'.tr(),
                ),
              ),
            widget.isAppBar!? SizedBox():  const SizedBox(height: 30),
              widget.isAppBar!? SizedBox():InkWell(
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
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ExamHero(),
                    ),
                  );
                },
                child: ProfileItemWidget(
                  image: ImageAssets.cupIcon,
                  title: 'exam_hero'.tr(),
                  subTitle: 'first_exams'.tr(),
                ),
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
                    if (context.read<LoginCubit>().communicationData != null) {
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
                                      .communicationData!
                                      .phones
                                      .length,
                                  (index) => InkWell(
                                    onTap: () {
                                      phoneCallMethod(
                                        context
                                            .read<LoginCubit>()
                                            .communicationData!
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
                                                    .communicationData!
                                                    .phones[index]
                                                    .phone),
                                                Text(context
                                                    .read<LoginCubit>()
                                                    .communicationData!
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
                    } else {
                      toastMessage(
                        'no_date'.tr(),
                        context,
                        color: AppColors.error,
                      );
                    }
                  });
                  // Navigator.pushNamed(context, Routes.suggestRoute);
                },
                child: ProfileItemWidget(
                  image: ImageAssets.callUsIcon,
                  title: 'call_us'.tr(),
                  subTitle: 'contact_us'.tr(),
                ),
              ),
              // const SizedBox(height: 30),
              // InkWell(
              //   onTap: () {
              //     lang == 'ar'
              //         ? EasyLocalization.of(context)!
              //             .setLocale(const Locale('en'))
              //         : EasyLocalization.of(context)!
              //             .setLocale(const Locale('ar'));
              //     HotRestartController.performHotRestart(context);
              //   },
              //   child: ProfileItemWidget(
              //     image: ImageAssets.languageIcon,
              //     title: 'language'.tr(),
              //     subTitle: 'language_type'.tr(),
              //   ),
              // ),
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
