import 'package:easy_localization/easy_localization.dart';
import 'package:elmazoon/feature/mydegree/presentation/screens/screens_tab/partial%20_exams.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/assets_manager.dart';
import '../../../../core/widgets/container_text_with_two_color_widget.dart';
import '../../../../core/widgets/container_with_two_color_widget.dart';
import '../../../../core/widgets/custom_app_bar.dart';

class MyDegreePage extends StatefulWidget {
  const MyDegreePage({Key? key}) : super(key: key);

  @override
  State<MyDegreePage> createState() => _MyDegreePageState();
}

class _MyDegreePageState extends State<MyDegreePage> with TickerProviderStateMixin  {
  late TabController _tabController;
  List <Widget> screens=[];
  @override
  void initState() {
    super.initState();
    screens=[Partialexams(),
      Partialexams(),
      Partialexams(),
      Partialexams(),
    ];
    _tabController = TabController(length: 4, vsync: this);
    _tabController.addListener(() {
      _tabController.index != _tabController.previousIndex
          ? setState(() {})
          : setState(() {});
    });
  }
  @override
  Widget build(BuildContext context) {
    _tabController.index == 0 ? '' : '';

    return  Scaffold(
     appBar: AppBar(
      toolbarHeight: 80,
      titleSpacing: 0,
      title:
      CustomAppBar(title:'mygards_rate'.tr() ,subtitle: 'exam_level'.tr() ,),
      flexibleSpace: Container(
        decoration:  const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(ImageAssets.appBarImage),
            fit: BoxFit.fill,
          ),
        ),
      ),
    ),
    body: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
      children: [
      SizedBox(
      // flex: 2,
      child: TabBar(
        controller: _tabController,
        isScrollable: true,
        tabs: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(
                ImageAssets.studyTap1Icon,
                colorFilter: ColorFilter.mode(
                  _tabController.index == 0
                      ? AppColors.secondPrimary
                      : AppColors.unselectedTab,
                  BlendMode.srcIn,
                ),
              ),
              Text(
                'part_exam'.tr(),
                style: TextStyle(
                  color: _tabController.index == 0
                      ? AppColors.secondPrimary
                      : AppColors.unselectedTab,
                ),
              )
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(
                ImageAssets.studyTap2Icon,
                colorFilter: ColorFilter.mode(
                  _tabController.index == 1
                      ? AppColors.secondPrimary
                      : AppColors.unselectedTab,
                  BlendMode.srcIn,
                ),
              ),
              Text(
                'tests',
                style: TextStyle(
                  color: _tabController.index == 1
                      ? AppColors.secondPrimary
                      : AppColors.unselectedTab,
                ),
              )
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(
                ImageAssets.studyTap2Icon,
                colorFilter: ColorFilter.mode(
                  _tabController.index == 2
                      ? AppColors.secondPrimary
                      : AppColors.unselectedTab,
                  BlendMode.srcIn,
                ),
              ),
              Text(
                'comprehensive_exam'.tr(),
                style: TextStyle(
                  color: _tabController.index == 2
                      ? AppColors.secondPrimary
                      : AppColors.unselectedTab,
                ),
              )
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(
                ImageAssets.studyTap2Icon,
                colorFilter: ColorFilter.mode(
                  _tabController.index == 3
                      ? AppColors.secondPrimary
                      : AppColors.unselectedTab,
                  BlendMode.srcIn,
                ),
              ),
              Text(
                'comprehensive_exam'.tr(),
                style: TextStyle(
                  color: _tabController.index == 3
                      ? AppColors.secondPrimary
                      : AppColors.unselectedTab,
                ),
              )
            ],
          )
          // Put Tabs here
        ],
      ),
      ),
      Expanded(
      flex: 12,
      child: TabBarView(
      controller: _tabController,
      children: screens,
      ),
      ),
      ],
      ),
    ),
    );
  }
}
