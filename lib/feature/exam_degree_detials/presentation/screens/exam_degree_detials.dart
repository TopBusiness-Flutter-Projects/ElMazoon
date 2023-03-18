import 'package:easy_localization/easy_localization.dart';
import 'package:elmazoon/core/models/lessons_details_model.dart';
import 'package:elmazoon/core/models/times_model.dart';
import 'package:elmazoon/core/models/times_model.dart';
import 'package:elmazoon/core/utils/assets_manager.dart';
import 'package:elmazoon/core/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/models/TimeModel.dart';
import '../../../../core/models/exam_answer_model.dart';
import '../../../../core/models/times_model.dart';
import '../../../../core/models/times_model.dart';
import '../../../../core/models/times_model.dart';
import '../../../../core/models/times_model.dart';
import '../../../../core/models/times_model.dart';
import '../../../../core/models/times_model.dart';
import '../../../../core/models/times_model.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../cubit/exam_degree_cubit.dart';

class ExamDegreePage extends StatefulWidget {
  final ExamAnswerModel examAnswerModel;

  ExamDegreePage({
    Key? key,
    required this.examAnswerModel,
  }) : super(key: key);

  @override
  State<ExamDegreePage> createState() => _ExamDegreePageState();
}

class _ExamDegreePageState extends State<ExamDegreePage> {


  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    print("dldkkdk");
    ExamDegreeCubit cubit = context.read<ExamDegreeCubit>();
    // print(widget.timeDataModel.data.times.length);
    return BlocBuilder<ExamDegreeCubit, ExamDegreeState>(
      builder: (context1, state) {
        if(state is ExamDegreeDetails){
        return Scaffold(
          appBar: AppBar(
            toolbarHeight: 80,
            titleSpacing: 0,
            title: CustomAppBar(
              title: 'register_paper_exam'.tr(),
              subtitle: cubit!.degreeDetails!.details!.name!,
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
          body: BlocBuilder<ExamDegreeCubit, ExamDegreeState>(
            builder: (context, state) {
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Column(
                    children: [
                      Container(
                        height: 500,
                        child: Card(
                          color: AppColors.white,
                          elevation: 2,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: cubit.degreeDetails!.data!.users!.length,
                            itemBuilder: (context, index) {
                              return Column(
                                children: [
                                  Text(
                                    cubit.degreeDetails!.data!.users!
                                        .elementAt(index)
                                        .percentage!,
                                    style: TextStyle(
                                        color: AppColors.secondPrimary,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Center(
                                      child: FAProgressBar(
                                    currentValue: double.parse(cubit!
                                        .degreeDetails!.data!.users!
                                        .elementAt(index)
                                        .percentage!
                                        .replaceAll("%", '')),
                                    verticalDirection: VerticalDirection.up,
                                  ))
                                ],
                              );
                            },
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        );}
        else{
          cubit.getExamDetails(widget.examAnswerModel, context);

          return Container();
        }
      },
    );
  }
}
