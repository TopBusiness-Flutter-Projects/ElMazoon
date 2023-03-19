import 'package:bloc/bloc.dart';
import 'package:elmazoon/core/remote/service.dart';
import 'package:meta/meta.dart';

import '../../../core/models/subscribes_model.dart';

part 'payment_state.dart';

class PaymentCubit extends Cubit<PaymentState> {
  PaymentCubit(this.api) : super(PaymentInitial()) {
    getPaymentMonth();
  }

  final ServiceApi api;
  int totalPayment = 0;
  List<SubscribesDatum> subscribesList = [];
  List<SubscribesDatum> tempSubscribesList = [];

  getPaymentMonth() async {
    emit(PaymentMonthLoading());
    final response = await api.getSubscribesPayment();
    response.fold(
      (error) => emit(PaymentMonthError()),
      (res) {
        subscribesList = res.data!;
        emit(PaymentMonthLoaded());
      },
    );
  }

  addOrRemoveModel(SubscribesDatum model, String type) {
    if (type == 'add') {
      totalPayment = totalPayment + model.price!;
      tempSubscribesList.add(model);
      emit(PaymentChangeList());
    }
    if (type == 'remove') {
      tempSubscribesList.removeWhere((element) {
        if (element.id == model.id) {
          totalPayment = totalPayment - model.price!;
        }
        return element.id == model.id;
      });
      emit(PaymentChangeList());
    }
  }
}
