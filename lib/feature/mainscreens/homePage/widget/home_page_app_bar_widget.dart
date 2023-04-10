import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/assets_manager.dart';
import '../../../../core/widgets/my_svg_widget.dart';
import '../../../../core/widgets/network_image.dart';
import '../../../../core/widgets/painting.dart';
import '../cubit/home_page_cubit.dart';

class HomePageAppBarWidget extends StatelessWidget {
  const HomePageAppBarWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String lang = EasyLocalization.of(context)!.locale.languageCode;
    return Stack(
      children: [
        SizedBox(
          height: 120,
          child: CustomPaint(
            size: Size(
              MediaQuery.of(context).size.width,
              (MediaQuery.of(context).size.width * 0.38676844783715014)
                  .toDouble(),
            ),
            painter: RPSCustomPainter(),
          ),
        ),
        Positioned(
          right: 20,
          left: 5,
          child: BlocBuilder<HomePageCubit, HomePageState>(
            builder: (context, state) {
              HomePageCubit cubit = context.read<HomePageCubit>();
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
                        crossAxisAlignment: CrossAxisAlignment.start,
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
                            padding: const EdgeInsets.only(top: 4.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Text(
                                    lang == 'ar'
                                        ? cubit.userModel!.data!.season.nameAr
                                        : cubit.userModel!.data!.season.nameEn,
                                    style: TextStyle(
                                        color: AppColors.white,
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                // SizedBox(width: 10),
                                Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Text(
                                    lang == 'ar'
                                        ? cubit.userModel!.data!.term.nameAr
                                        : cubit.userModel!.data!.term.nameEn,
                                    style: TextStyle(
                                        color: AppColors.white,
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold),
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
                              path: ImageAssets.notificationsIcon,
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
    );
  }
}
