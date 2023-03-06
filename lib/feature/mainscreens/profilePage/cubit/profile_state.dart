part of 'profile_cubit.dart';

@immutable
abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class ProfileGetUserData extends ProfileState {}

class ProfileSendSuggestLoading extends ProfileState {}
class ProfileSendSuggestLoaded extends ProfileState {}
class ProfileSendSuggestError extends ProfileState {}
class PageError extends ProfileState {}
