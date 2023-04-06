part of 'on_boarding_cubit.dart';

@immutable
abstract class OnBoardingState {}

class OnBoardingInitial extends OnBoardingState {}

class OnBoardingLoading extends OnBoardingState {}
class OnBoardingLoaded extends OnBoardingState {}
class OnBoardingError extends OnBoardingState {}
