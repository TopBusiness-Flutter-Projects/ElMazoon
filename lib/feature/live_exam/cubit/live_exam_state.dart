part of 'live_exam_cubit.dart';

@immutable
abstract class LiveExamState {}

class LiveExamInitial extends LiveExamState {}

class LiveExamQuestionUpdate extends LiveExamState {}

class LiveExamUpdateSelectQuestion extends LiveExamState {}

class LiveExamQuestionLoading extends LiveExamState {}
class LiveExamQuestionLoaded extends LiveExamState {}
class LiveExamQuestionError extends LiveExamState {}
