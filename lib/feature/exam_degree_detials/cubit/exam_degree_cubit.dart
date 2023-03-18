import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:elmazoon/core/models/lessons_details_model.dart';
import 'package:elmazoon/core/remote/service.dart';
import 'package:flutter/cupertino.dart';

import '../../../core/models/degree_detials_model.dart';
import '../../../core/models/exam_answer_model.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/show_dialog.dart';
import '../../../core/utils/toast_message_method.dart';

part 'exam_degree_state.dart';

class ExamDegreeCubit extends Cubit<ExamDegreeState> {
  final ServiceApi api;
  DegreeDetails? degreeDetails;

  ExamDegreeCubit(this.api) : super(ExamDegreeInitial()) {
    degreeDetails = DegreeDetails();
  }

  Future<void> getExamDetails(
      ExamAnswerModel examAnswerModel, BuildContext context) async {
    //createProgressDialog(context, 'wait'.tr());
    print("';;;;;loooo'");
    var response = await api.getDegreeDetails(
        exam_id: examAnswerModel.data!.id!,
        exam_type: examAnswerModel.data!.instruction!.exam_type);
    response.fold(
      (l) =>print("ffff"),
      (r) {

        degreeDetails=r;
        //Navigator.of(context).pop();
        emit(ExamDegreeDetails(degreeDetails! ));
        // if(r.data==200){
        //   //   Navigator.pushNamed(context, Routes.examRegisterRoute,arguments: data);
        // }
        // else{
        //   toastMessage(
        //     'error',
        //     context,
        //     color: AppColors.error,
        //   );
        // }
      },
    );
  }
}
