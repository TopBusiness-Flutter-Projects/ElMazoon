import 'package:bloc/bloc.dart';
import 'package:elmazoon/core/remote/service.dart';
import 'package:meta/meta.dart';

import '../../../core/models/answer_model.dart';
import '../../../core/models/live_exam_model.dart';

part 'live_exam_state.dart';

class LiveExamCubit extends Cubit<LiveExamState> {
  LiveExamCubit(this.api) : super(LiveExamInitial());

  final ServiceApi api;

  int minutes = -1;
  int seconed = -1;
  var minute = "0";
  var second = "0";

  int quesId = 0;
  int ansId = 0;

  LiveExamModel? liveExamModel;

  void updateTime() {
    seconed = -1;
    minutes = -1;
    emit(LiveExamQuestionUpdate());
  }

  void updateSelectAnswer(int index) {
    for (int i = 0; i < liveExamModel!.liveExamDatum!.answers!.length; i++) {
      if (index == i) {
        quesId = liveExamModel!.liveExamDatum!.id!;
        ansId = liveExamModel!.liveExamDatum!.answers![i].id!;
        liveExamModel!.liveExamDatum!.answers![i].status = 'select';
      } else {
        liveExamModel!.liveExamDatum!.answers![i].status = '';
      }
    }
    emit(LiveExamUpdateSelectQuestion());
  }

  accessFirstQuestionOfLiveExam(int examId) async {
    emit(LiveExamQuestionLoading());
    final response = await api.getFirstLiveExamQuestion(examId);
    response.fold(
      (l) => emit(LiveExamQuestionError()),
      (r) {
        liveExamModel = r;
        emit(LiveExamQuestionLoaded());
      },
    );
  }

  answerQuestionOfLiveExam(int examId) async {
    emit(LiveExamQuestionLoading());
    final response = await api.answerLiveExamQuestion(
      examId: examId,
      questionId: quesId,
      answerId: ansId,
    );
    response.fold(
      (l) => emit(LiveExamQuestionError()),
      (r) {
        ansId = 0;
        liveExamModel = r;
        emit(LiveExamQuestionLoaded());
      },
    );
  }
}
