import 'package:bloc/bloc.dart';
import 'package:elmazoon/core/remote/service.dart';
import 'package:meta/meta.dart';

import '../../../core/models/my_degree_model.dart';

part 'my_degree_state.dart';

class MyDegreeCubit extends Cubit<MyDegreeState> {
  MyDegreeCubit(this.api) : super(MyDegreeInitial()) {
    getMyDegree();
  }

  final ServiceApi api;

  List<ExamDetailsModel> partialExams = [];
  List<ExamDetailsModel> allExams = [];
  List<ExamDetailsModel> exams = [];

  getMyDegree() async {
    emit(MyDegreeLoading());
    final response = await api.getMyDegreeData();
    response.fold(
      (l) => emit(MyDegreeError()),
      (r) {
        partialExams = r.myDegreeModelData!.partialExams!;
        allExams = r.myDegreeModelData!.allExams!;
        exams = r.myDegreeModelData!.exams!;
        emit(MyDegreeLoaded());
      },
    );
  }
}
