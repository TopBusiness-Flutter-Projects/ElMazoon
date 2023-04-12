import 'package:elmazoon/core/utils/app_colors.dart';
import 'package:elmazoon/feature/start_trip/cubit/start_trip_cubit.dart';
import 'package:elmazoon/feature/start_trip/cubit/start_trip_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'classes_exam_screen.dart';
import 'classes_screen.dart';
import 'final_review_screen.dart';

class StartTripScreen extends StatefulWidget {
  StartTripScreen({Key? key}) : super(key: key);

  @override
  State<StartTripScreen> createState() => _StartTripScreenState();
}

class _StartTripScreenState extends State<StartTripScreen>
    with TickerProviderStateMixin {
  List<String> titles = ['الفصول', 'امتحانات الفصول', 'المراجعه النهائيه'];
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.animateTo(context.read<StartTripCubit>().currentIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<StartTripCubit, StartTripState>(
        builder: (context, state) {
          StartTripCubit cubit = context.read<StartTripCubit>();
          return Column(
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    ...List.generate(
                      titles.length,
                      (index) => Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8.0,
                          vertical: 8,
                        ),
                        child: InkWell(
                          onTap: () {
                            cubit.selectTap(index);
                            print(cubit.currentIndex);
                            _tabController.animateTo(index);
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 30, vertical: 10),
                            decoration: BoxDecoration(
                              color: cubit.currentIndex == index
                                  ? AppColors.orangeThirdPrimary
                                  : AppColors.unselectedTabColor,
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: Center(
                              child: Text(
                                titles[index],
                                style: TextStyle(
                                  color: cubit.currentIndex == index
                                      ? AppColors.white
                                      : AppColors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                child: RefreshIndicator(
                  onRefresh: () async {
                    print(88888);
                  },
                  child: TabBarView(
                    controller: _tabController,
                    physics: NeverScrollableScrollPhysics(),
                    children: [
                      ClassesScreen(),
                      ClassesExamsScreen(),
                      FinalReviewScreen(),
                    ],
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
