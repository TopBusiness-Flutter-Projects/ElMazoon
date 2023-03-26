part of 'study_page_cubit.dart';

abstract class StudyPageState {}

class StudyPageInitial extends StudyPageState {}

class StudyPagePickImageSuccess extends StudyPageState {}

class StudyPageGetUserModel extends StudyPageState {}

class SavedDownloadedPathsLoading extends StudyPageState {}
class SavedDownloadedPathsLoaded extends StudyPageState {}

class UpdateButtonValid extends StudyPageState {}
class DownloadVideoPercentage extends StudyPageState {}

class StudyPageLoading extends StudyPageState {}
class StudyPageLoaded extends StudyPageState {}
class StudyPageError extends StudyPageState {}


class StudyPageLessonsLoading extends StudyPageState {}
class StudyPageLessonsLoaded extends StudyPageState {
  final LessonsDetailsModel model;

  StudyPageLessonsLoaded(this.model);
}
class StudyPageLessonsError extends StudyPageState {}

class StudyPageAccessFirstVideoLoading extends StudyPageState {}
class StudyPageAccessFirstVideoLoaded extends StudyPageState {}
class StudyPageAccessFirstVideoError extends StudyPageState {}



class StudyPageCommentsLessonsLoading extends StudyPageState {}
class StudyPageCommentsLessonsLoaded extends StudyPageState {}
class StudyPageCommentsLessonsError extends StudyPageState {}

class StudyPageMoreCommentsLessonsLoading extends StudyPageState {}
class StudyPageMoreCommentsLessonsLoaded extends StudyPageState {}
class StudyPageMoreCommentsLessonsError extends StudyPageState {}




class StudyPageAddCommentLoading extends StudyPageState {}
class StudyPageAddCommentLoaded extends StudyPageState {}
class StudyPageAddCommentError extends StudyPageState {}

class StudyPageUpdateCommentLoading extends StudyPageState {}
class StudyPageUpdateCommentLoaded extends StudyPageState {}
class StudyPageUpdateCommentError extends StudyPageState {}


class StudyPageDeleteCommentLoading extends StudyPageState {}
class StudyPageDeleteCommentLoaded extends StudyPageState {}
class StudyPageDeleteCommentError extends StudyPageState {}


class StudyPageDeleteReplyLoading extends StudyPageState {}
class StudyPageDeleteReplyLoaded extends StudyPageState {}
class StudyPageDeleteReplyError extends StudyPageState {}
