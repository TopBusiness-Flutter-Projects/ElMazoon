part of 'study_page_cubit.dart';

abstract class StudyPageState {}

class StudyPageInitial extends StudyPageState {}

class StudyPageLoading extends StudyPageState {}
class StudyPageLoaded extends StudyPageState {}
class StudyPageError extends StudyPageState {}


class StudyPageLessonsLoading extends StudyPageState {}
class StudyPageLessonsLoaded extends StudyPageState {
  final List<LessonsClassDatum> list;

  StudyPageLessonsLoaded(this.list);
}
class StudyPageLessonsError extends StudyPageState {}
