part of 'live_exam_cubit.dart';

@immutable
abstract class LiveExamState {}

class LiveExamInitial extends LiveExamState {}

class LiveExamQuestionUpdate extends LiveExamState {}
