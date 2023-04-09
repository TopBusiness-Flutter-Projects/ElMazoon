part of 'home_page_cubit.dart';

@immutable
abstract class HomePageState {}

class HomePageInitial extends HomePageState {}

class HomeGetUserLoading extends HomePageState {}
class HomeGetUserData extends HomePageState {}


class HomePageLoading extends HomePageState {}
class HomePageLoaded extends HomePageState {
  final HomePageModel model;

  HomePageLoaded(this.model);
}
class HomePageError extends HomePageState {}
