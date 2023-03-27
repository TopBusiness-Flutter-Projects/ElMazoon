import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../core/utils/app_colors.dart';
import '../../../core/utils/assets_manager.dart';
import '../../exam/widget/time_widget.dart';
import '../widgets/live_exam_timer_widget.dart';

class LiveExamScreen extends StatelessWidget {
  const LiveExamScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: Column(
        children:[
          LiveExamTimerWidget(examTime: 20),

          // Container(
          //   width: double.infinity,
          //   child: Padding(
          //     padding:
          //     const EdgeInsets.symmetric(vertical: 30.0),
          //     child: Text(
          //       cubit.questionsDataModel!.questions[cubit.index]
          //           .question!,
          //       style: TextStyle(
          //         fontWeight: FontWeight.normal,
          //         fontSize: 15,
          //       ),
          //     ),
          //   ),
          // ),

          // cubit.questionsDataModel!.questions[cubit.index]
          //     .answers!.length >
          //     0
          //     ? ListView.builder(
          //   shrinkWrap: true,
          //   physics: NeverScrollableScrollPhysics(),
          //   itemCount: cubit.questionsDataModel!
          //       .questions[cubit.index].answers!.length,
          //   itemBuilder: (context, index) {
          //     return Padding(
          //       padding: const EdgeInsets.symmetric(
          //           horizontal: 8.0),
          //       child: Container(
          //         child: Center(
          //           child: Padding(
          //             padding: const EdgeInsets.all(8.0),
          //             child: InkWell(
          //               onTap: () {
          //                 cubit.updateSelectAnswer(
          //                   index,
          //                 );
          //               },
          //               child: Container(
          //                 width: double.maxFinite,
          //                 height: 60,
          //                 decoration: BoxDecoration(
          //                     color: cubit
          //                         .questionsDataModel!
          //                         .questions[
          //                     cubit.index]
          //                         .answers![index]
          //                         .status ==
          //                         'select'
          //                         ? AppColors.blueColor3
          //                         : AppColors
          //                         .unselectedTab,
          //                     shape: BoxShape.rectangle,
          //                     borderRadius:
          //                     BorderRadius.all(
          //                         Radius.circular(
          //                             10))),
          //                 child: Padding(
          //                   padding:
          //                   const EdgeInsets.all(8.0),
          //                   child: Align(
          //                     alignment:
          //                     Alignment.centerRight,
          //                     child: Text(
          //                       cubit
          //                           .questionsDataModel!
          //                           .questions[
          //                       cubit.index]
          //                           .answers![index]
          //                           .answer!,
          //                       style: TextStyle(
          //                         fontWeight:
          //                         FontWeight.bold,
          //                         fontSize: 14,
          //                         color: cubit
          //                             .questionsDataModel!
          //                             .questions[
          //                         cubit
          //                             .index]
          //                             .answers![
          //                         index]
          //                             .status ==
          //                             'select'
          //                             ? AppColors.white
          //                             : AppColors
          //                             .secondPrimary,
          //                       ),
          //                     ),
          //                   ),
          //                 ),
          //               ),
          //             ),
          //           ),
          //         ),
          //       ),
          //     );
          //   },
          // )
          //     : Container(
          //   width: double.infinity,
          //   child: AddAnswerWidget(
          //     id: cubit.questionsDataModel!
          //         .questions[cubit.index].id!,
          //     type: 'question',
          //     index: cubit.index,
          //   ),
          // ),

          SizedBox(height: 50),
        ],
      ),
    );
  }
}
