import 'package:easy_localization/easy_localization.dart';
import 'package:elmazoon/core/utils/assets_manager.dart';
import 'package:elmazoon/feature/mainscreens/profilePage/cubit/profile_cubit.dart';
import 'package:elmazoon/feature/mainscreens/profilePage/widgets/profile_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/utils/app_routes.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
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
                  image: ImageAssets.usereditIcon,
                  title: 'register_paper_exam'.tr(),
                  subTitle: 'register_data_enter_exam'.tr(),
                ),
              ),
              const SizedBox(
                height: 30
              ),
              InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, Routes.myDegreeRoute);
                  },
                  child: ProfileItemWidget(
                      image: ImageAssets.degreeIcon,
                      title: 'mygards_rate'.tr(),
                      subTitle: 'grades_performance'.tr())),
              const SizedBox(
                height: 30,
              ),
              ProfileItemWidget(
                  image: ImageAssets.cupIcon,
                  title: 'exam_hero'.tr(),
                  subTitle: 'first_exams'.tr()),
              const SizedBox(
                height: 30,
              ),
              ProfileItemWidget(
                  image: ImageAssets.calenderIcon,
                  title: 'month_plan'.tr(),
                  subTitle: 'month_course'.tr(),),
              const SizedBox(
                height: 30,
              ),
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
              const SizedBox(
                  height: 30
              ),

            ],
          ),
        ),
      ),
    );
  }
}
