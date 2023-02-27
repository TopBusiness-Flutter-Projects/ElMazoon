part of 'notification_cubit.dart';

@immutable
abstract class NotificationState {}

class NotificationInitial extends NotificationState {}
class NotificationPageLoading extends NotificationState {}
class NotificationPageLoaded extends NotificationState {}
class NotificationPageError extends NotificationState {}
