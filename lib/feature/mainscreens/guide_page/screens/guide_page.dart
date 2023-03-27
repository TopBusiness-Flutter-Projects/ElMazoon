import 'package:elmazoon/feature/mainscreens/guide_page/cubit/guide_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/widgets/no_data_widget.dart';
import '../../../../core/widgets/show_loading_indicator.dart';
import '../../study_page/widgets/container_color_title_widget.dart';
import 'guide_page_details.dart';

class GuidePage extends StatelessWidget {
  const GuidePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<GuideCubit, GuideState>(
        builder: (context, state) {
          GuideCubit cubit = context.read<GuideCubit>();
          if (state is GuideLoading) {
            return ShowLoadingIndicator();
          }
          if (state is GuideError) {
            return NoDataWidget(onclick: () => cubit.getGuideData(),title: 'no_date',);
          }
          return RefreshIndicator(
            onRefresh: () async {
              cubit.getGuideData();
            },
            color: AppColors.primary,
            backgroundColor: AppColors.secondPrimary,
            child: ListView(
              children: [
                ...List.generate(
                  cubit.guideList.length,
                  (index) => InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => GuidePageDetails(
                            innerItems: cubit.guideList[index].innerItems!,
                          ),
                        ),
                      );
                    },
                    child: ContainerColorTitleWidget(
                      lesson: null,
                      title: cubit.guideList[index].title!,
                      subTitle: cubit.guideList[index].description!,
                      titleBackground: AppColors.primary,
                      color2: AppColors.blueLiteColor1,
                      color1: AppColors.blueLiteColor2,
                      titleIcon: Icons.newspaper,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
