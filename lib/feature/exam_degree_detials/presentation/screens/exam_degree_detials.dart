import 'package:easy_localization/easy_localization.dart';
import 'package:elmazoon/core/models/lessons_details_model.dart';
import 'package:elmazoon/core/models/times_model.dart';
import 'package:elmazoon/core/models/times_model.dart';
import 'package:elmazoon/core/utils/assets_manager.dart';
import 'package:elmazoon/core/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

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
import '../../../../core/widgets/network_image.dart';
import '../../../exam/cubit/exam_cubit.dart';
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
    cubit.examAnswerModel=widget.examAnswerModel;
    return BlocBuilder<ExamDegreeCubit, ExamDegreeState>(
      builder: (context1, state) {
        if (state is ExamDegreeDetails) {
          print(cubit.degreeDetails!.data!.users!.length);

          return Scaffold(
            appBar: AppBar(
              toolbarHeight: 80,
              titleSpacing: 0,
              title: CustomAppBar(
                title: 'exam_details'.tr(),
                subtitle: cubit.degreeDetails!.details!.name!,
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
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          height: 500,
                          width: double.infinity,
                          child: Card(
                            color: AppColors.white,
                            elevation: 2,
                            child:
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 3.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Container(
                                    height: 20,
                                    child: Row(children: [
                                      Text(
                                        'my_order'.tr(),
                                        style: TextStyle(
                                            color: AppColors.secondPrimary,
                                            fontSize: 13,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(width: 7,),
                                      Container(
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: AppColors.secondPrimary),
                                        child: Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: Text(
                                            cubit.degreeDetails!.ordered
                                                .toString(),
                                            style: TextStyle(
                                                color: AppColors.white,
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold),),
                                        ),
                                      )
                                    ],),),
                                  Flexible(
                                    child: ListView.builder(
                                      shrinkWrap: true,
                                      reverse: true,
                                      scrollDirection: Axis.horizontal,
                                      itemCount: cubit.degreeDetails!.data!
                                          .users!
                                          .length,
                                      itemBuilder: (context, index) {
                                        return Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 3.0),
                                          child: Container(

                                            width: 35,
                                            child: Column(

                                              children: [
                                                Flexible(
                                                    child: Container(

                                                    )),
                                                Visibility(
                                                  visible: cubit.userModel!
                                                      .data!
                                                      .id ==
                                                      cubit.degreeDetails!.data!
                                                          .users!
                                                          .elementAt(index).id,
                                                  child: SizedBox(
                                                      width: 40,
                                                      height: 40,
                                                      child: Center(
                                                        child: CircleAvatar(
                                                          radius: 40,
                                                          backgroundColor: AppColors
                                                              .transparent,
                                                          child: ManageNetworkImage(
                                                            imageUrl: cubit
                                                                .userModel!
                                                                .data!.image,
                                                            width: 40,
                                                            height: 40,
                                                            borderRadius: 40,
                                                          ),
                                                        ),
                                                      )),
                                                ),
                                                SizedBox(height: 6,),
                                                Text(
                                                  cubit.degreeDetails!.data!
                                                      .users!
                                                      .elementAt(index)
                                                      .percentage!,
                                                  style: TextStyle(
                                                      color: AppColors
                                                          .secondPrimary,
                                                      fontSize: 11,
                                                      fontWeight: FontWeight
                                                          .normal),
                                                ),
                                                Container(

                                                  height: cubit.userModel!.data!
                                                      .id ==
                                                      cubit.degreeDetails!.data!
                                                          .users!
                                                          .elementAt(index).id
                                                      ? (double
                                                      .parse(cubit
                                                      .degreeDetails!.data!
                                                      .users!
                                                      .elementAt(index)
                                                      .percentage!
                                                      .replaceAll("%", '')) *
                                                      380) /
                                                      100
                                                      : (double.parse(cubit
                                                      .degreeDetails!.data!
                                                      .users!
                                                      .elementAt(index)
                                                      .percentage!
                                                      .replaceAll("%", '')) *
                                                      420) /
                                                      100,

                                                  decoration: BoxDecoration(
                                                      color: double.parse(cubit
                                                          .degreeDetails!.data!
                                                          .users!
                                                          .elementAt(index)
                                                          .percentage!
                                                          .replaceAll(
                                                          "%", '')) >=
                                                          85
                                                          ? AppColors.green
                                                          : (double.parse(cubit
                                                          .degreeDetails!.data!
                                                          .users!
                                                          .elementAt(index)
                                                          .percentage!
                                                          .replaceAll(
                                                          "%", '')) <
                                                          85 &&
                                                          double.parse(cubit
                                                              .degreeDetails!
                                                              .data!
                                                              .users!
                                                              .elementAt(index)
                                                              .percentage!
                                                              .replaceAll(
                                                              "%", '')) >=
                                                              75)
                                                          ? AppColors
                                                          .secondPrimary
                                                          : AppColors.primary,
                                                      borderRadius: BorderRadius
                                                          .only(
                                                          topLeft: Radius
                                                              .circular(20),
                                                          topRight: Radius
                                                              .circular(
                                                              20)),
                                                      shape: BoxShape.rectangle
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  )
                                ],
                              ),
                            ),


                          ),

                        ),
                        Container(height: 70,
                            child: ListView.builder(
                              shrinkWrap: true,
                              reverse: true,
                              scrollDirection: Axis.horizontal,
                              itemCount: cubit.degreeDetails!.data!.users!
                                  .length,
                              itemBuilder: (BuildContext context, int index) {
                                return Padding(
                                  padding: const EdgeInsets.all(3.0),
                                  child: Container(
                                    width: 37.5,
                                    child: RotatedBox(


                                      quarterTurns: 1,
                                      child: Center(
                                        child: Text(
                                          cubit.degreeDetails!.data!.users!
                                              .elementAt(index).name!,

                                          maxLines: 1,
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 13,
                                            color: AppColors.secondPrimary,

                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            )),
                        SizedBox(height: 8,),

                        Container(
                          height: 50,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              gradient: LinearGradient(
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                                colors: [
                                  AppColors.blueColor1,
                                  AppColors.blueColor2,
                                ],
                              )
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 16),
                            child: Row(
                              children: [
                                Icon(Icons.access_time_sharp
                                    , color: AppColors.secondPrimary),
                                SizedBox(width: 3,),
                                Text('time_used'.tr(),
                                  style: TextStyle(
                                      color: AppColors.secondPrimary,
                                      fontWeight: FontWeight.normal,
                                      fontSize: 14),),
                                Expanded(child: Container()),
                                Text(cubit.degreeDetails!.timer! + ":0",
                                  style: TextStyle(
                                      color: AppColors.secondPrimary,
                                      fontWeight: FontWeight.normal,
                                      fontSize: 14),)
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 8,),

                        Container(
                          height: 50,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              gradient: LinearGradient(
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                                colors: [
                                  AppColors.blueColor1,
                                  AppColors.blueColor2,
                                ],
                              )
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 16),
                            child: Row(
                              children: [
                                SvgPicture.asset(
                                  ImageAssets.mistakeIcon,
                                  color:
                                  AppColors.secondPrimary

                                  ,
                                ),
                                SizedBox(width: 3,),
                                Text('mistake_num'.tr(),
                                  style: TextStyle(
                                      color: AppColors.secondPrimary,
                                      fontWeight: FontWeight.normal,
                                      fontSize: 14),),
                                Expanded(child: Container()),
                                Text(cubit.degreeDetails!.numberMistake!
                                    .toString(),
                                  style: TextStyle(
                                      color: AppColors.secondPrimary,
                                      fontWeight: FontWeight.normal,
                                      fontSize: 14),)
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 8,),

                        Container(
                          height: 50,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              gradient: LinearGradient(
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                                colors: [
                                  AppColors.blueColor1,
                                  AppColors.blueColor2,
                                ],
                              )
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 16),
                            child: Row(
                              children: [
                                SvgPicture.asset(
                                  ImageAssets.degreefullIcon,
                                  color:
                                  AppColors.secondPrimary

                                  ,
                                ),
                                SizedBox(width: 3,),
                                Text('full_degree'.tr(),
                                  style: TextStyle(
                                      color: AppColors.secondPrimary,
                                      fontWeight: FontWeight.normal,
                                      fontSize: 14),),
                                Expanded(child: Container()),
                                Text(cubit.degreeDetails!.degree!.toString(),
                                  style: TextStyle(
                                      color: AppColors.secondPrimary,
                                      fontWeight: FontWeight.normal,
                                      fontSize: 14),)
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 8,),

                        Container(
                          height: 50,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              gradient: LinearGradient(
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                                colors: [
                                  AppColors.blueColor1,
                                  AppColors.blueColor2,
                                ],
                              )
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 16),
                            child: Row(
                              children: [
                                SvgPicture.asset(
                                  ImageAssets.filterIcon,
                                  color:
                                  AppColors.secondPrimary

                                  ,
                                ),
                                SizedBox(width: 3,),
                                Text('remining_num'.tr(),
                                  style: TextStyle(
                                      color: AppColors.secondPrimary,
                                      fontWeight: FontWeight.normal,
                                      fontSize: 14),),
                                Expanded(child: Container()),
                                Text(cubit.degreeDetails!.tryingNumberAgain!
                                    .toString(),
                                  style: TextStyle(
                                      color: AppColors.secondPrimary,
                                      fontWeight: FontWeight.normal,
                                      fontSize: 14),)
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 8,),
                        Visibility(
                          visible: cubit.degreeDetails!.tryingNumberAgain! > 0,
                          child: CustomButton(
                            paddingHorizontal: 50,
                            text: 'exam_repetition'.tr(),
                            color: AppColors.primary,
                            onClick: () {
                              context.read<ExamCubit>().getExam(widget.examAnswerModel.data!.id!,widget.examAnswerModel.data!.instruction!.exam_type);
                              Navigator.pop(context);
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        }
        else {
          return Center(
            child: CircularProgressIndicator(
              color: AppColors.primary,
            ),
          );
        }
      },
    );
  }
}
