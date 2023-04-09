import 'package:easy_localization/easy_localization.dart';
import 'package:elmazoon/core/utils/app_colors.dart';
import 'package:elmazoon/core/utils/toast_message_method.dart';
import 'package:elmazoon/feature/mainscreens/homePage/cubit/home_page_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/assets_manager.dart';
import '../../../../core/widgets/banner.dart';
import '../../../../core/widgets/container_with_two_color_widget.dart';
import '../../../../core/widgets/my_svg_widget.dart';
import '../../../../core/widgets/network_image.dart';
import '../../../../core/widgets/no_data_widget.dart';
import '../../../../core/widgets/painting.dart';
import '../../../../core/widgets/show_loading_indicator.dart';
import '../../../exam/cubit/exam_cubit.dart';
import '../../../navigation_bottom/cubit/navigation_cubit.dart';
import '../../notificationpage/presentation/screens/widget/notification_details_widget.dart';
import '../../study_page/screens/all_lecture/class_name_screen.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String lang = EasyLocalization.of(context)!.locale.languageCode;
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
              child: Stack(
                children: [
                  ListView(
                    children: [
                      SizedBox(height: 120),
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
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.25,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'درب نفسك'.tr(),
                                style: TextStyle(
                                  // color: AppColors.secondPrimary,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 4),
                              Container(
                                height: 1,
                                width: MediaQuery.of(context).size.width * 0.22,
                                color: AppColors.primary,
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            ...List.generate(
                              5,
                              (index) => Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Container(
                                  height: 120,
                                  width: MediaQuery.of(context).size.width * 0.45,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: AppColors.primary,
                                  ),
                                  child: Column(
                                    children: [
                                      Spacer(),
                                      Text('عنوان الفديو',style: TextStyle(color: AppColors.white,fontWeight: FontWeight.bold),),
                                      Spacer(),
                                      Row(
                                        children: [
                                          // Spacer(),
                                          SizedBox(width: 16),
                                          MySvgWidget(
                                            path: ImageAssets.clockIcon,
                                            imageColor: AppColors.white,
                                            size: 16,
                                          ),
                                          Spacer(),
                                          Text('ساعه',style: TextStyle(color: AppColors.white,fontWeight: FontWeight.bold),),
                                          Spacer(),
                                        ],
                                      ),
                                      Spacer(),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 40),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.25,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'start_study'.tr(),
                                style: TextStyle(
                                  // color: AppColors.secondPrimary,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 4),
                              Container(
                                height: 1,
                                width: MediaQuery.of(context).size.width * 0.22,
                                color: AppColors.primary,
                              )
                            ],
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
                                    mainAxisSpacing: 50,
                                    crossAxisSpacing: 50,
                                    crossAxisCount: 3,
                                  ),
                                  itemCount: cubit.classes.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return InkWell(
                                      onTap: () {
                                        if (cubit.classes[index].status ==
                                            'lock') {
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
                                              builder: (context) =>
                                                  ClassNameScreen(
                                                model: cubit.classes[index],
                                              ),
                                            ),
                                          );
                                        }
                                      },
                                      child: ContainerWithTwoColorWidget(
                                        title: cubit.classes[index].name,
                                        imagePath: context
                                            .read<NavigationCubit>()
                                            .userModel!
                                            .data!
                                            .image,
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
                  Positioned(
                    top: 0,
                    right: 0,
                    left: 0,
                    child: Stack(
                      children: [
                        SizedBox(
                          height: 120,
                          child: CustomPaint(
                            size: Size(
                              MediaQuery.of(context).size.width,
                              (MediaQuery.of(context).size.width *
                                      0.38676844783715014)
                                  .toDouble(),
                            ),
                            painter: RPSCustomPainter(),
                          ),
                        ),
                        Positioned(
                          right: 20,
                          left: 5,
                          child: BlocBuilder<NavigationCubit, NavigationState>(
                            builder: (context, state) {
                              NavigationCubit cubit =
                                  context.read<NavigationCubit>();
                              return SizedBox(
                                // height: 150,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    ManageNetworkImage(
                                      imageUrl: cubit.userModel!.data!.image,
                                      width: 50,
                                      height: 50,
                                      borderRadius: 90,
                                    ),
                                    SizedBox(width: 16),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Align(
                                            alignment: lang == 'ar'
                                                ? Alignment.topRight
                                                : Alignment.topLeft,
                                            child: Text(
                                              cubit.userModel!.data!.name,
                                              style: TextStyle(
                                                  color: AppColors.white,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 4.0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(4.0),
                                                  child: Text(
                                                    lang == 'ar'
                                                        ? cubit.userModel!.data!
                                                            .season.nameAr
                                                        : cubit.userModel!.data!
                                                            .season.nameEn,
                                                    style: TextStyle(
                                                        color: AppColors.white,
                                                        fontSize: 10,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                                // SizedBox(width: 10),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(4.0),
                                                  child: Text(
                                                    lang == 'ar'
                                                        ? cubit.userModel!.data!
                                                            .term.nameAr
                                                        : cubit.userModel!.data!
                                                            .term.nameEn,
                                                    style: TextStyle(
                                                        color: AppColors.white,
                                                        fontSize: 10,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Column(
                                      children: [
                                        Row(
                                          children: [
                                            SizedBox(width: 8),
                                            MySvgWidget(
                                              path:
                                                  ImageAssets.notificationsIcon,
                                              size: 25,
                                              imageColor: AppColors.white,
                                            ),
                                            SizedBox(width: 18),
                                            MySvgWidget(
                                              path: ImageAssets.loveIcon,
                                              size: 25,
                                              imageColor: AppColors.white,
                                            ),
                                            SizedBox(width: 8),
                                          ],
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          } else {
            return NoDataWidget(
              onclick: () => cubit.getHomePageData(),
              title: 'no_date',
            );
          }
        },
      ),
    );
  }
}
