import 'package:elmazoon/core/utils/app_colors.dart';
import 'package:elmazoon/core/widgets/show_loading_indicator.dart';
import 'package:elmazoon/feature/exam/cubit/exam_cubit.dart';
import 'package:elmazoon/feature/mainscreens/study_page/cubit/study_page_cubit.dart';
import 'package:elmazoon/feature/mainscreens/study_page/screens/all_lecture/class_name_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/utils/assets_manager.dart';
import '../../../../core/widgets/container_with_two_color_widget.dart';
import 'full_exam/stucture_of_exam.dart';

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
            flex: 10,
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
                            color: AppColors.primary,
                            backgroundColor: AppColors.secondPrimary,
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
                                        itemCount: cubit.allClassesDatum != null
                                            ? cubit
                                                .allClassesDatum!.classes.length
                                            : 0,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return InkWell(
                                            onTap: () {
                                              print('index @@@@@@  $index');
                                              context
                                                      .read<ExamCubit>()
                                                      .examSubjectClassIndex =
                                                  index;
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      ClassNameScreen(
                                                    model: cubit
                                                        .allClassesDatum!
                                                        .classes[index],
                                                  ),
                                                ),
                                              );
                                            },
                                            child: ContainerWithTwoColorWidget(
                                              title: cubit.allClassesDatum!
                                                  .classes[index].name,
                                              imagePath: cubit.allClassesDatum!
                                                  .classes[index].image,
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
                        : RefreshIndicator(
                            onRefresh: () async {
                              cubit.getAllClasses();
                            },
                            color: AppColors.primary,
                            backgroundColor: AppColors.secondPrimary,
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: ListView(
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
                                    itemCount: cubit.allClassesDatum != null
                                        ? cubit
                                            .allClassesDatum!.fullExams.length
                                        : 0,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return InkWell(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  ExamInstruction(
                                                examInstruction: cubit
                                                    .allClassesDatum!
                                                    .fullExams[index]
                                                    .instruction!,
                                              ),
                                            ),
                                          );
                                        },
                                        child: ContainerWithTwoColorWidget(
                                          title: cubit.allClassesDatum!
                                              .fullExams[index].name,
                                          imagePath: cubit.allClassesDatum!
                                              .fullExams[index].image,
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
