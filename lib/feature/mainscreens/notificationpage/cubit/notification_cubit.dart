import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../core/models/notifications_model.dart';
import '../../../../core/remote/service.dart';

part 'notification_state.dart';

class NotificationCubit extends Cubit<NotificationState> {
  List<NotificationModel>? data;
  final ServiceApi api;

  NotificationCubit(this.api) : super(NotificationInitial()) {
    getAllNotification();
  }

  getAllNotification() async {
    emit(NotificationPageLoading());
    final response = await api.getAllNotification();
    response.fold(
      (error) => emit(NotificationPageError()),
      (response) {
        data = response.data;
        emit(NotificationPageLoaded());
      },
    );
  }
}
