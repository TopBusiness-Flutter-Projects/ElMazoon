import 'package:easy_localization/easy_localization.dart';
import 'package:elmazoon/core/widgets/show_loading_indicator.dart';
import 'package:elmazoon/feature/mydegree/cubit/my_degree_cubit.dart';
import 'package:elmazoon/feature/mydegree/cubit/my_degree_cubit.dart';
import 'package:elmazoon/feature/mydegree/screens/screens_tab/partial%20_exams.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/assets_manager.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../widget/no_exam_widget.dart';

class MyDegreePage extends StatefulWidget {
  const MyDegreePage({Key? key}) : super(key: key);

  @override
  State<MyDegreePage> createState() => _MyDegreePageState();
}

class _MyDegreePageState extends State<MyDegreePage>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
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

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        titleSpacing: 0,
        title: CustomAppBar(
          title: 'mygards_rate'.tr(),
          subtitle: 'exam_level'.tr(),
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(ImageAssets.appBarImage),
              fit: BoxFit.fill,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: RefreshIndicator(
          onRefresh: () async {
            context.read<MyDegreeCubit>().getMyDegree();
          },
          color: AppColors.primary,
          backgroundColor: AppColors.secondPrimary,
          child: ListView(
            children: [
              SizedBox(
                height: 80,
                child: TabBar(
                  controller: _tabController,
                  isScrollable: true,
                  labelPadding: EdgeInsets.symmetric(horizontal: 30),
                  tabs: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          ImageAssets.partialExamsIcon,
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
                          ImageAssets.examsIcon,
                          colorFilter: ColorFilter.mode(
                            _tabController.index == 1
                                ? AppColors.secondPrimary
                                : AppColors.unselectedTab,
                            BlendMode.srcIn,
                          ),
                        ),
                        Text(
                          'exams'.tr(),
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
                          height: 32,
                          width: 32,
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
                          height: 32,
                          width: 32,
                          colorFilter: ColorFilter.mode(
                            _tabController.index == 2
                                ? AppColors.secondPrimary
                                : AppColors.unselectedTab,
                            BlendMode.srcIn,
                          ),
                        ),
                        Text(
                          'papel_sheet_exam'.tr(),
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
              BlocBuilder<MyDegreeCubit, MyDegreeState>(
                builder: (context, state) {
                  MyDegreeCubit cubit = context.read<MyDegreeCubit>();
                  return SizedBox(
                    height: MediaQuery.of(context).size.height - 80,
                    child: TabBarView(
                      controller: _tabController,
                      children: [
                        state is MyDegreeLoading
                            ? ShowLoadingIndicator()
                            : cubit.partialExams.isEmpty
                                ? NoExamWidget()
                                : PartialExams(examList: cubit.partialExams),
                        state is MyDegreeLoading
                            ? ShowLoadingIndicator()
                            : cubit.exams.isEmpty
                                ? NoExamWidget()
                                : PartialExams(examList: cubit.exams),
                        state is MyDegreeLoading
                            ? ShowLoadingIndicator()
                            : cubit.allExams.isEmpty
                                ? NoExamWidget()
                                : PartialExams(examList: cubit.allExams),
                        state is MyDegreeLoading
                            ? ShowLoadingIndicator()
                            : cubit.papelSheet.isEmpty
                                ? NoExamWidget()
                                : PartialExams(examList: cubit.papelSheet),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
