import 'package:easy_localization/easy_localization.dart';
import 'package:elmazoon/core/utils/app_colors.dart';
import 'package:elmazoon/core/utils/toast_message_method.dart';
import 'package:elmazoon/feature/mainscreens/homePage/cubit/home_page_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/widgets/banner.dart';
import '../../../../core/widgets/container_with_two_color_widget.dart';
import '../../../../core/widgets/no_data_widget.dart';
import '../../../../core/widgets/show_loading_indicator.dart';
import '../../../exam/cubit/exam_cubit.dart';
import '../../notificationpage/presentation/screens/widget/notification_details_widget.dart';
import '../../study_page/screens/all_lecture/class_name_screen.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<HomePageCubit, HomePageState>(
        builder: (context, state) {
          HomePageCubit cubit = context.read<HomePageCubit>();
          if (state is HomePageLoading) {
            return ShowLoadingIndicator();
          } else if (state is HomePageLoaded) {
            return RefreshIndicator(
              onRefresh: () async {
                cubit.getHomePageData();
              },
              color: AppColors.primary,
              backgroundColor: AppColors.secondPrimary,
              child: ListView(
                children: [
                  BannerWidget(sliderData: state.model.data.sliders),
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        gradient: LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [
                            AppColors.blueColor1,
                            AppColors.blueColor2,
                          ],
                        ),
                      ),
                      child: NotificationDetailsWidget(
                          notificationModel: state.model.data.notification),
                    ),
                  ),
                  SizedBox(height: 40),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      'start_study'.tr(),
                      style: TextStyle(
                        // color: AppColors.secondPrimary,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Column(
                    children: [
                      Padding(
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
                              itemCount: cubit.classes.length,
                              itemBuilder: (BuildContext context, int index) {
                                return InkWell(
                                  onTap: () {
                                    if (cubit.classes[index].status == 'lock') {
                                      toastMessage(
                                        'open_class'.tr(),
                                        context,
                                        color: AppColors.error,
                                      );
                                    } else {
                                      context
                                          .read<ExamCubit>()
                                          .examSubjectClassIndex = index;
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => ClassNameScreen(
                                            model: cubit.classes[index],
                                          ),
                                        ),
                                      );
                                    }
                                  },
                                  child: ContainerWithTwoColorWidget(
                                    title: cubit.classes[index].name,
                                    imagePath: cubit.classes[index].image,
                                    color1: AppColors.blueColor1,
                                    color2: AppColors.blueColor2,
                                    textColor: AppColors.secondPrimary,
                                    isHome: true,
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      )
                    ],
                  )
                ],
              ),
            );
          } else {
            return NoDataWidget(onclick: () => cubit.getHomePageData(),title: 'no_date',);
          }
        },
      ),
    );
  }
}
