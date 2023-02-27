part of 'login_cubit.dart';

@immutable
abstract class LoginState {}

class userInitial extends LoginState {}

class userLoading extends LoginState {}
class userLoaded extends LoginState {}
class userError extends LoginState {}


class userCommunicationLoading extends LoginState {}
class userCommunicationLoaded extends LoginState {}
class userCommunicationError extends LoginState {}
