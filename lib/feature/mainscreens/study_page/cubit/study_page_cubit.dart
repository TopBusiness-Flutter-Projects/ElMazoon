import 'package:bloc/bloc.dart';

import '../../../../core/models/comments_model.dart';
import '../../../../core/models/lessons_details_model.dart';
import '../../../../core/remote/service.dart';
import '../models/all_classes_model.dart';

part 'study_page_state.dart';

class StudyPageCubit extends Cubit<StudyPageState> {
  StudyPageCubit(this.api) : super(StudyPageInitial()) {
    getAllClasses();
  }

  late AllClassesDatum allClassesDatum ;
  late LessonsDetailsModel lessonsDetailsModel ;
  List<CommentDatum> commentsList = [];
  late Comments comments;

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

  getLessonsDetails(int id) async {
    emit(StudyPageLessonsLoading());
    final response = await api.getLessonsDetails(id);
    response.fold(
      (error) => emit(StudyPageLessonsError()),
      (response) {
        lessonsDetailsModel = response;
        emit(StudyPageLessonsLoaded(response));
      },
    );
  }

  getCommentsLesson(int id) async {
    emit(StudyPageCommentsLessonsLoading());
    final response = await api.getCommentsByLesson(id);
    response.fold(
      (error) => emit(StudyPageCommentsLessonsError()),
      (response) {
        comments = response.comments;
        commentsList= response.comments.comment;
        emit(StudyPageCommentsLessonsLoaded());
      },
    );
  }
}
