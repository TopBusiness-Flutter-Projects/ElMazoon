import 'package:elmazoon/core/utils/app_colors.dart';
import 'package:elmazoon/core/widgets/show_loading_indicator.dart';
import 'package:elmazoon/feature/mainscreens/study_page/cubit/study_page_cubit.dart';
import 'package:elmazoon/feature/mainscreens/study_page/screens/class_name_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
              ],
            ),
          ),
          Expanded(
            flex: 12,
            child: BlocBuilder<StudyPageCubit, StudyPageState>(
              builder: (context, state) {
                StudyPageCubit cubit = context.read<StudyPageCubit>();
                return TabBarView(
                  controller: _tabController,
                  children: [
                    state is StudyPageLoading
                        ? ShowLoadingIndicator()
                        : RefreshIndicator(
                            onRefresh: () async {
                              cubit.getAllClasses();
                            },
                            child: ListView(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Column(
                                    children: [
                                      GridView.builder(
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        gridDelegate:
                                            const SliverGridDelegateWithFixedCrossAxisCount(
                                          // childAspectRatio: .9,
                                          mainAxisSpacing: 25,
                                          crossAxisSpacing: 25,
                                          crossAxisCount: 2,
                                        ),
                                        itemCount: cubit.allClassesDatum.length,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return InkWell(
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      ClassNameScreen(
                                                    model: cubit
                                                        .allClassesDatum[index],
                                                  ),
                                                ),
                                              );
                                            },
                                            child: ContainerWithTwoColorWidget(
                                              title: cubit
                                                  .allClassesDatum[index]
                                                  .name,
                                              imagePath: cubit
                                                  .allClassesDatum[index].image,
                                              color1: AppColors.blueColor1,
                                              color2: AppColors.blueColor2,
                                              textColor:
                                                  AppColors.secondPrimary,
                                            ),
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                    state is StudyPageLoading
                        ? ShowLoadingIndicator()
                        : SingleChildScrollView(
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                children: [
                                  GridView.builder(
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                      // childAspectRatio: .9,
                                      mainAxisSpacing: 25,
                                      crossAxisSpacing: 25,
                                      crossAxisCount: 2,
                                    ),
                                    itemCount: 10,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return InkWell(
                                        onTap: () {
                                          // Navigator.push(
                                          //   context,
                                          //   MaterialPageRoute(
                                          //     builder: (context) =>
                                          //         ClassNameScreen(),
                                          //   ),
                                          // );
                                        },
                                        child: ContainerWithTwoColorWidget(
                                          title: 'First Class',
                                          imagePath: '',
                                          color1: AppColors.primary,
                                          color2: AppColors.primary,
                                          textColor: AppColors.secondPrimary,
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
