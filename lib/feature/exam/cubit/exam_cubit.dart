import 'package:bloc/bloc.dart';
import 'package:elmazoon/core/remote/service.dart';
import 'package:meta/meta.dart';

import '../../../core/models/question_model.dart';
import '../../../core/models/questiones_data_model.dart';

part 'exam_state.dart';

class ExamCubit extends Cubit<ExamState> {
  final ServiceApi api;
  int index = 0;
  QuestionData? questionesDataModel = QuestionData();

  ExamCubit(this.api) : super(ExamInitial());

  getExam(int exam_id) async {
    final response = await api.getQuestion(exam_id);
    response.fold(
      (error) => {},
      (response) {
        if (response.code == 200) {
          questionesDataModel = response.data!;
          index = 0;
          List<Questions> qu=questionesDataModel!.questions;
          Questions data=qu.elementAt(1);
          data.status='pending';
         qu.removeAt(1);
         qu.insert(1, data);
         questionesDataModel!.questions=qu;
          emit(Questionupdate());
          // Navigator.pushNamed(context, Routes.examRegisterRoute,arguments: data);
        } else {}
        //data = response.data;
        //  emit(NotificationPageLoaded());
      },
    );
  }

  void updateindex(int index) {
    this.index=index;
    emit(Questionupdate());


  }
}
