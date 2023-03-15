part of 'my_degree_cubit.dart';

@immutable
abstract class MyDegreeState {}

class MyDegreeInitial extends MyDegreeState {}

class MyDegreeLoading extends MyDegreeState {}
class MyDegreeLoaded extends MyDegreeState {}
class MyDegreeError extends MyDegreeState {}
