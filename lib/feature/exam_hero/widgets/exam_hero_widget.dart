import 'package:elmazoon/core/utils/app_colors.dart';
import 'package:elmazoon/core/utils/assets_manager.dart';
import 'package:elmazoon/feature/exam_hero/cubit/exam_hero_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../core/models/exam_hero_model.dart';
import '../../../core/widgets/network_image.dart';

class ExamHeroWidget extends StatelessWidget {
  const ExamHeroWidget({Key? key, required this.heroData}) : super(key: key);
  final List<HeroData> heroData;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: RefreshIndicator(
        onRefresh: () async {
          context.read<ExamHeroCubit>().getExamHeroes();
        },
        color: AppColors.primary,
        backgroundColor: AppColors.secondPrimary,
        child: ListView(
          // physics: NeverScrollableScrollPhysics(),
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Stack(
                      children: [
                        ManageNetworkImage(
                          imageUrl: heroData[1].image!,
                          width: 80,
                          height: 80,
                          borderRadius: 80,
                        ),
                        Positioned(
                          top: 0,
                          right: 0,
                          child: Image.asset(
                            ImageAssets.secondImage,
                            height: 25,
                            width: 25,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 12),
                    Text(
                      heroData[1].name!,
                      style: TextStyle(
                        color: AppColors.secondPrimary,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Stack(
                      children: [
                        ManageNetworkImage(
                          imageUrl: heroData[0].image!,
                          width: 120,
                          height: 120,
                          borderRadius: 80,
                        ),
                        Positioned(
                          top: 0,
                          right: 0,
                          child: Image.asset(
                            ImageAssets.firstImage,
                            height: 35,
                            width: 35,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 12),
                    Text(
                      heroData[0].name!,
                      style: TextStyle(
                        color: AppColors.secondPrimary,
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Stack(
                      children: [
                        ManageNetworkImage(
                          imageUrl: heroData[2].image!,
                          width: 80,
                          height: 80,
                          borderRadius: 80,
                        ),
                        Positioned(
                          top: 0,
                          right: 0,
                          child: Image.asset(
                            ImageAssets.thirdImage,
                            height: 25,
                            width: 25,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 12),
                    Text(
                      heroData[2].name!,
                      style: TextStyle(
                        color: AppColors.secondPrimary,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            ...List.generate(
              heroData.length - 3,
              (index) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.primary,
                      ),
                      padding: EdgeInsets.all(15),
                      child: Text(
                        heroData[index + 3].ordered.toString(),
                        style: TextStyle(
                          color: AppColors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: AppColors.paymentContainer,
                        ),
                        child: Row(
                          children: [
                            ManageNetworkImage(
                              imageUrl: heroData[index + 3].image!,
                              width: 60,
                              height: 60,
                              borderRadius: 40,
                            ),
                            SizedBox(width: 40),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    heroData[index + 3].name!,
                                    style: TextStyle(
                                      color: AppColors.secondPrimary,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                  ),
                                  SizedBox(height: 12),
                                  Text(
                                    heroData[index + 3].country!,
                                    style: TextStyle(
                                      color: AppColors.primary,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 90,
                              height: 90,
                              child: SfCircularChart(
                                palette: [index%2==0?AppColors.primary:AppColors.secondPrimary],
                                annotations: <CircularChartAnnotation>[
                                  CircularChartAnnotation(
                                    widget: Text(
                                      '${heroData[index + 3].percentage}',
                                      style: TextStyle(
                                          color: AppColors.secondPrimary,
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                                series: <CircularSeries>[
                                  RadialBarSeries<HeroData, String>(
                                    maximumValue: 100,
                                    innerRadius: '20',
                                    dataSource: [heroData[index + 3]],
                                    cornerStyle: CornerStyle.endCurve,
                                    xValueMapper: (HeroData data, _) =>
                                        data.name,
                                    yValueMapper: (HeroData data, _) =>
                                        double.parse(
                                      data.percentage!.replaceAll('%', ''),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}