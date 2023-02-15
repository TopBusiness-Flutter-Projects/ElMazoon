import 'package:easy_localization/easy_localization.dart';
import 'package:elmazoon/core/utils/assets_manager.dart';
import 'package:elmazoon/core/widgets/customAppbar.dart';
import 'package:elmazoon/core/widgets/my_svg_widget.dart';
import 'package:elmazoon/feature/mainscreens/profilePage/presentation/widgets/profile_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/widgets/custom_button.dart';

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
          padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 30),
          child: Column(
            children: [
              ProfileItemWidget(image: ImageAssets.usereditIcon, title: 'register_paper_exam'.tr(), subTitle: 'register_data_enter_exam'.tr()),
             const SizedBox(height: 30,),
              ProfileItemWidget(image: ImageAssets.degreeIcon, title: 'mygards_rate'.tr(), subTitle: 'grades_performance'.tr()),
              const SizedBox(height: 30,),
              ProfileItemWidget(image: ImageAssets.cupIcon, title: 'exam_hero'.tr(), subTitle: 'first_exams'.tr()),
              const SizedBox(height: 30,),
              ProfileItemWidget(image: ImageAssets.calenderIcon, title: 'month_plan'.tr(), subTitle: 'month_course'.tr())


            ],
          ),
        ),
      ),
    );
  }
}
