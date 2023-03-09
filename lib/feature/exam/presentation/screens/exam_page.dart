import 'package:calendar_view/calendar_view.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:elmazoon/core/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/models/month_plan_model.dart';
import '../../../../core/utils/assets_manager.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../cubit/exam_cubit.dart';

class ExamScreen extends StatelessWidget {
  final int exam_id;

  const ExamScreen({Key? key, required this.exam_id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ExamCubit cubit = context.read<ExamCubit>();
    cubit.getExam(exam_id);
    String lang = EasyLocalization.of(context)!.locale.languageCode;

    return BlocBuilder<ExamCubit, ExamState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            toolbarHeight: 160,
            titleSpacing: 0,
            title: Column(
              children: [
                CustomAppBar(
                  title: 'month_plan'.tr(),
                  subtitle: ''.tr(),
                ),
                Container(
                  width: double.infinity,
                  height: 100,
                  child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: cubit.questionesDataModel!.questions.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: 40,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color:cubit.index==index? AppColors.primary:cubit.questionesDataModel!.questions.elementAt(index).status=='pending'?AppColors.error:AppColors.white,
                          ),
                          child: InkWell(
                            onTap: () {
                              cubit.updateindex(index);
                            },
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "${index + 1}",
                                  style: TextStyle(
                                      color:cubit.index==index? AppColors.white:AppColors.primary,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                )
              ],
            ),
            flexibleSpace: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(ImageAssets.appBarImage),
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
