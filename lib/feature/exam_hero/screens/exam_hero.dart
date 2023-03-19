import 'package:easy_localization/easy_localization.dart';
import 'package:elmazoon/core/widgets/show_loading_indicator.dart';
import 'package:elmazoon/feature/exam_hero/cubit/exam_hero_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/utils/app_colors.dart';
import '../../../core/utils/assets_manager.dart';
import '../../../core/widgets/custom_app_bar.dart';
import '../widgets/exam_hero_widget.dart';

class ExamHero extends StatefulWidget {
  const ExamHero({Key? key}) : super(key: key);

  @override
  State<ExamHero> createState() => _ExamHeroState();
}

class _ExamHeroState extends State<ExamHero> with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
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
          title: 'exam_hero'.tr(),
          subtitle: 'first_exams'.tr(),
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
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2),
        child: Column(
          children: [
            SizedBox(
              height: 50,
              child: TabBar(
                controller: _tabController,
                isScrollable: true,
                indicatorColor: AppColors.transparent,
                labelPadding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width / 25),
                tabs: [
                  Container(
                    decoration: _tabController.index != 0
                        ? null
                        : BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: AppColors.primary,
                          ),
                    padding: EdgeInsets.symmetric(
                      horizontal: 40,
                    ),
                    child: Text(
                      'day'.tr(),
                      style: TextStyle(
                        color: _tabController.index != 0
                            ? AppColors.unselectedTab
                            : AppColors.white,
                        fontWeight:
                            _tabController.index != 0 ? null : FontWeight.bold,
                        fontSize: _tabController.index != 0 ? 16 : 20,
                      ),
                    ),
                  ),
                  Container(
                    decoration: _tabController.index != 1
                        ? null
                        : BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: AppColors.primary,
                          ),
                    padding: EdgeInsets.symmetric(
                      horizontal: 40,
                    ),
                    child: Text(
                      'week'.tr(),
                      style: TextStyle(
                        color: _tabController.index != 1
                            ? AppColors.unselectedTab
                            : AppColors.white,
                        fontWeight:
                            _tabController.index != 1 ? null : FontWeight.bold,
                        fontSize: _tabController.index != 1 ? 16 : 20,
                      ),
                    ),
                  ),
                  Container(
                    decoration: _tabController.index != 2
                        ? null
                        : BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: AppColors.primary,
                          ),
                    padding: EdgeInsets.symmetric(
                      horizontal: 40,
                    ),
                    child: Text(
                      'month'.tr(),
                      style: TextStyle(
                        color: _tabController.index != 2
                            ? AppColors.unselectedTab
                            : AppColors.white,
                        fontWeight:
                            _tabController.index != 2 ? null : FontWeight.bold,
                        fontSize: _tabController.index != 2 ? 16 : 20,
                      ),
                    ),
                  ),
                  // Put Tabs here
                ],
              ),
            ),
            BlocBuilder<ExamHeroCubit, ExamHeroState>(
              builder: (context, state) {
                ExamHeroCubit cubit = context.read<ExamHeroCubit>();
                return SizedBox(
                  height: MediaQuery.of(context).size.height - 180,
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      state is ExamHeroLoading
                          ? ShowLoadingIndicator()
                          : ExamHeroWidget(heroData: cubit.dayHero),
                      state is ExamHeroLoading
                          ? ShowLoadingIndicator()
                          : ExamHeroWidget(heroData: cubit.weekHero),
                      state is ExamHeroLoading
                          ? ShowLoadingIndicator()
                          : ExamHeroWidget(heroData: cubit.monthHero),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
