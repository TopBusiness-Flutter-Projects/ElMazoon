import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'exam_register_state.dart';

class ExamRegisterCubit extends Cubit<ExamRegisterState> {
  ExamRegisterCubit() : super(ExamRegisterInitial());
}
