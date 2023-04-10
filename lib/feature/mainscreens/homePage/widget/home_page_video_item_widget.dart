import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/models/home_page_model.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/assets_manager.dart';
import '../../../../core/widgets/my_svg_widget.dart';

class HomePageVideoWidget extends StatelessWidget {
  const HomePageVideoWidget(
      {Key? key, required this.videosBasics, required this.title})
      : super(key: key);
  final List<HomePageVideosModel> videosBasics;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 40),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SizedBox(
            // width: MediaQuery.of(context).size.width * 0.50,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title.tr(),
                  style: TextStyle(
                    // color: AppColors.secondPrimary,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 4),
                Container(
                  height: 1,
                  width: title == 'all_exams'
                      ? MediaQuery.of(context).size.width * 0.35
                      : MediaQuery.of(context).size.width * 0.20,
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
                videosBasics.length,
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
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            videosBasics[index].name!,
                            style: TextStyle(
                              fontSize: 16,
                              color: AppColors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
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
                            SizedBox(width: 10),
                            // Spacer(),
                            Text(
                              '${videosBasics[index].time!} ساعه ',
                              style: TextStyle(
                                fontSize: 14,
                                color: AppColors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
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
      ],
    );
  }
}
