part of 'study_page_cubit.dart';

abstract class StudyPageState {}

class StudyPageInitial extends StudyPageState {}

class StudyPagePickImageSuccess extends StudyPageState {}

class StudyPageGetUserModel extends StudyPageState {}

class StudyPageLoading extends StudyPageState {}
class StudyPageLoaded extends StudyPageState {}
class StudyPageError extends StudyPageState {}


class StudyPageLessonsLoading extends StudyPageState {}
class StudyPageLessonsLoaded extends StudyPageState {
  final LessonsDetailsModel model;

  StudyPageLessonsLoaded(this.model);
}
class StudyPageLessonsError extends StudyPageState {}



class StudyPageCommentsLessonsLoading extends StudyPageState {}
class StudyPageCommentsLessonsLoaded extends StudyPageState {}
class StudyPageCommentsLessonsError extends StudyPageState {}

class StudyPageMoreCommentsLessonsLoading extends StudyPageState {}
class StudyPageMoreCommentsLessonsLoaded extends StudyPageState {}
class StudyPageMoreCommentsLessonsError extends StudyPageState {}




class StudyPageAddCommentLoading extends StudyPageState {}
class StudyPageAddCommentLoaded extends StudyPageState {}
class StudyPageAddCommentError extends StudyPageState {}
