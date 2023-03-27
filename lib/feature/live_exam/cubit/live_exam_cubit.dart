import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'live_exam_state.dart';

class LiveExamCubit extends Cubit<LiveExamState> {
  LiveExamCubit() : super(LiveExamInitial());
  int minutes = -1;
  int seconed = -1;
  var minute = "0";
  var second = "0";


  void updateTime() {
    seconed = -1;
    minutes = -1;
    emit(LiveExamQuestionUpdate());
  }
}
