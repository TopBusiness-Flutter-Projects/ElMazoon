part of 'login_cubit.dart';

@immutable
abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}
class LoginLoaded extends LoginState {}
class LoginError extends LoginState {}


class LoginCommunicationLoading extends LoginState {}
class LoginCommunicationLoaded extends LoginState {}
class LoginCommunicationError extends LoginState {}
