part of 'exam_cubit.dart';

@immutable
abstract class ExamState {}

class ExamInitial extends ExamState {}
class Questionupdate extends ExamState {}
class ExamPagePickImageSuccess extends ExamState {}
