import 'package:bloc/bloc.dart';
import 'package:elmazoon/core/remote/service.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import '../../../core/models/answer_model.dart';
import '../../../core/models/live_exam_model.dart';
import '../../../core/models/live_questiones_data_model.dart';
import '../../exam/models/answer_exam_model.dart';

part 'live_exam_state.dart';

class LiveExamCubit extends Cubit<LiveExamState> {
  LiveExamCubit(this.api) : super(LiveExamInitial()){
    answerExamModel = AnswerExamModel(answer: [], audio: [], image: []);

  }

  final ServiceApi api;

  int minutes = -1;
  int seconed = -1;
  var minute = "0";
  var second = "0";
  int index = 0;
  AnswerExamModel? answerExamModel;
  LiveQuestionsDataModel? liveExamModel;
  int pendingNumberIndex = 0;
  List<int> pendingList = [];
  List<int> pendingListNumber = [];
  final formKey = GlobalKey<FormState>();

  void updateTime() {
    seconed = -1;
    minutes = -1;
    emit(LiveExamQuestionUpdate());
  }


  accessQuestionOfLiveExam(int examId) async {
    emit(LiveExamQuestionLoading());
    final response = await api.getLiveExamQuestion(examId);
    response.fold(
      (l) => emit(LiveExamQuestionError()),
      (r) {
        liveExamModel = r;
        emit(LiveExamQuestionLoaded());
      },
    );
  }

  // answerQuestionOfLiveExam(int examId) async {
  //   emit(LiveExamQuestionLoading());
  //   final response = await api.answerLiveExamQuestion(
  //     examId: examId,
  //     questionId: quesId,
  //     answerId: ansId,
  //   );
  //   response.fold(
  //     (l) => emit(LiveExamQuestionError()),
  //     (r) {
  //       ansId = 0;
  //       liveExamModel = r;
  //       emit(LiveExamQuestionLoaded());
  //     },
  //   );
  // }
  void updateIndex(int index) {
    if (pendingList.contains(liveExamModel!.data!.questions![this.index].id!)) {
      liveExamModel!.data!.questions![index].status = 'pending';
    
    }
    this.index = index;
    emit(LiveExamQuestionLoaded());
  }

  void updateSelectAnswer(int index2) {
    List<Answers>? answers = liveExamModel!.data!.questions![index].answers;
    for (int i = 0; i < answers!.length; i++) {
      if (index2 == i) {
        answers[i].status = 'select';
      } else {
        answers[i].status = '';
      }
    }
    emit(LiveExamQuestionLoaded());
  }

  void postponeQuestion(int index) {
    liveExamModel!.data!.questions![index].status = 'pending';

    if (!pendingList.contains(liveExamModel!.data!.questions![index].id!)) {
      pendingList.add(liveExamModel!.data!.questions![index].id!);
      pendingNumberIndex = index;
      pendingNumberIndex = pendingNumberIndex + 1;
      pendingListNumber.add(pendingNumberIndex);
    }


      List<Answers>? answers = liveExamModel!.data!.questions![index].answers;
      for (int i = 0; i < answers!.length; i++) {
        if (answers[i].status == 'select') {
          answerExamModel!.answer[index]='';

      }
    }


    emit(LiveExamQuestionLoaded());
  }

  void answerQuestion(int index) {
    liveExamModel!.data!.questions![index].status = 'answered';
    if (pendingList.contains(liveExamModel!.data!.questions![index].id)) {
      pendingList.remove(liveExamModel!.data!.questions![index].id);
      pendingNumberIndex = index;
      pendingNumberIndex = pendingNumberIndex + 1;
      pendingListNumber.remove(pendingNumberIndex);
    }

      List<Answers>? answers = liveExamModel!.data!.questions![index].answers;
      for (int i = 0; i < answers!.length; i++) {
        if (answers[i].status == 'select') {

          answerExamModel!.answer[index]= answers[i].id.toString();
        }

    }
    emit(LiveExamQuestionLoaded());
  }

}
