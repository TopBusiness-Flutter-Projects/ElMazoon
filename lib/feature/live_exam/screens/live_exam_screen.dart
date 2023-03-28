import 'package:easy_localization/easy_localization.dart';
import 'package:elmazoon/core/utils/toast_message_method.dart';
import 'package:elmazoon/core/widgets/no_data_widget.dart';
import 'package:elmazoon/core/widgets/show_loading_indicator.dart';
import 'package:elmazoon/feature/live_exam/cubit/live_exam_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/utils/app_colors.dart';
import '../../../core/utils/assets_manager.dart';
import '../../../core/utils/restart_app_class.dart';
import '../../../core/widgets/custom_button.dart';
import '../../exam/widget/add_question_replay_widget.dart';
import '../../exam/widget/time_widget.dart';
import '../widgets/completed_live_exam_widget.dart';
import '../widgets/live_exam_timer_widget.dart';

class LiveExamScreen extends StatefulWidget {
  const LiveExamScreen({Key? key}) : super(key: key);

  @override
  State<LiveExamScreen> createState() => _LiveExamScreenState();
}

class _LiveExamScreenState extends State<LiveExamScreen> {
  @override
  void initState() {
    super.initState();
    context.read<LiveExamCubit>().accessFirstQuestionOfLiveExam(1);
  }

  @override
  void deactivate() {
    super.deactivate();
    HotRestartController.performHotRestart(_scaffoldKey.currentContext!);
  }

  @override
  void dispose() {
    super.dispose();
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        toolbarHeight: 60,
        titleSpacing: 0,
        title: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Text(
            'live_exam'.tr(),
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
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
      body: BlocBuilder<LiveExamCubit, LiveExamState>(
        builder: (context, state) {
          LiveExamCubit cubit = context.read<LiveExamCubit>();
          if (state is LiveExamQuestionLoading) {
            return ShowLoadingIndicator();
          }
          if (state is LiveExamQuestionError) {
            return NoDataWidget(onclick: () {}, title: 'no_data');
          }

          return cubit.liveExamModel!.code == 200
              ? ListView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 16),
                      child: Row(
                        children: [
                          Expanded(
                            child: LiveExamTimerWidget(
                              examTime: cubit
                                  .liveExamModel!.liveExamDatum!.remainingTime!,
                            ),
                          ),
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.primary,
                            ),
                            child: Center(
                              child: Text(
                                cubit.liveExamModel!.liveExamDatum!.degree
                                    .toString(),
                                style: TextStyle(
                                  color: AppColors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 30.0),
                        child: Text(
                          cubit.liveExamModel!.liveExamDatum!.question!,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 25),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount:
                          cubit.liveExamModel!.liveExamDatum!.answers!.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Container(
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: InkWell(
                                  onTap: () {
                                    cubit.updateSelectAnswer(
                                      index,
                                    );
                                  },
                                  child: Container(
                                    width: double.maxFinite,
                                    height: 60,
                                    decoration: BoxDecoration(
                                        color: cubit
                                                    .liveExamModel!
                                                    .liveExamDatum!
                                                    .answers![index]
                                                    .status ==
                                                'select'
                                            ? AppColors.blueColor3
                                            : AppColors.unselectedTab,
                                        shape: BoxShape.rectangle,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10))),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Align(
                                        alignment: Alignment.centerRight,
                                        child: Text(
                                          cubit.liveExamModel!.liveExamDatum!
                                              .answers![index].answer!,
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14,
                                            color: cubit
                                                        .liveExamModel!
                                                        .liveExamDatum!
                                                        .answers![index]
                                                        .status ==
                                                    'select'
                                                ? AppColors.white
                                                : AppColors.secondPrimary,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    SizedBox(height: 50),
                    CustomButton(
                      paddingHorizontal: 70,
                      text: 'solution_done'.tr(),
                      color: AppColors.success,
                      onClick: () {
                        if (cubit.ansId == 0) {
                          toastMessage(
                            'please_choose_answer'.tr(),
                            context,
                            color: AppColors.error,
                          );
                        } else {
                          cubit.answerQuestionOfLiveExam(1);
                          print(cubit.liveExamModel!.liveExamDatum!.answers!
                              .toString());
                          print(cubit.quesId);
                          print(cubit.ansId);
                        }
                      },
                    ),
                  ],
                )
              : cubit.liveExamModel!.code == 201
                  ? CompletedLiveExamWidget(
                      degree: cubit.liveExamModel!.degree.toString(),
                      pre: cubit.liveExamModel!.pre!,
                    )
                  : Container(color: Colors.yellow);
        },
      ),
    );
  }
}
