part of 'guide_cubit.dart';

@immutable
abstract class GuideState {}

class GuideInitial extends GuideState {}

class GuideLoading extends GuideState {}
class GuideLoaded extends GuideState {}
class GuideError extends GuideState {}
