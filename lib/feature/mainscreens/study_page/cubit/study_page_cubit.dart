import 'package:bloc/bloc.dart';

import '../../../../core/remote/service.dart';
import '../models/all_classes_model.dart';
import '../models/lessons_class_model.dart';

part 'study_page_state.dart';

class StudyPageCubit extends Cubit<StudyPageState> {
  StudyPageCubit(this.api) : super(StudyPageInitial()) {
    getAllClasses();
  }

  late AllClassesDatum allClassesDatum ;
  List<LessonsClassDatum> listLessons = [];

  final ServiceApi api;

  getAllClasses() async {
    emit(StudyPageLoading());
    final response = await api.getAllClasses();
    response.fold(
      (error) => emit(StudyPageError()),
      (response) {
        allClassesDatum = response.data;
        emit(StudyPageLoaded());
      },
    );
  }

  getLessonsClass(int id) async {
    emit(StudyPageLessonsLoading());
    final response = await api.getLessonsByClassId(id);
    response.fold(
      (error) => emit(StudyPageLessonsError()),
      (response) {
        listLessons = response.data;
        emit(StudyPageLessonsLoaded(response.data));
      },
    );
  }
}
