import 'package:elmazoon/core/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/utils/assets_manager.dart';
import '../../../../core/widgets/container_with_two_color_widget.dart';

class StudyPage extends StatefulWidget {
  const StudyPage({Key? key}) : super(key: key);

  @override
  State<StudyPage> createState() => _StudyPageState();
}

class _StudyPageState extends State<StudyPage> with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      _tabController.index != _tabController.previousIndex
          ? setState(() {})
          : setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    _tabController.index == 0 ? '' : '';

    return Scaffold(
      body: Column(
        children: [
          Expanded(
            // flex: 2,
            child: TabBar(
              controller: _tabController,
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
                      'شرح ومحاضرات',
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
                      'امتحانات شاملة',
                      style: TextStyle(
                        color: _tabController.index == 1
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
              children: [
                SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        GridView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            // childAspectRatio: .9,
                            mainAxisSpacing: 25,
                            crossAxisSpacing: 25,
                            crossAxisCount: 2,
                          ),
                          itemCount: 10,
                          itemBuilder: (BuildContext context, int index) {
                            return ContainerWithTwoColorWidget(
                              title: 'First Class',
                              imagePath: ImageAssets.logoImage,
                              color1: AppColors.blueColor1,
                              color2: AppColors.blueColor2,
                              textColor: AppColors.secondPrimary,
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  color: Colors.green,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
