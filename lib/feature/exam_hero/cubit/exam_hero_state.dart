part of 'exam_hero_cubit.dart';

@immutable
abstract class ExamHeroState {}

class ExamHeroInitial extends ExamHeroState {}

class ExamHeroLoading extends ExamHeroState {}
class ExamHeroLoaded extends ExamHeroState {}
class ExamHeroError extends ExamHeroState {}
