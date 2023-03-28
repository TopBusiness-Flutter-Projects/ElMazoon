import 'package:bloc/bloc.dart';
import 'package:elmazoon/core/remote/service.dart';
import 'package:elmazoon/feature/payment/model/pay_model.dart';
import 'package:meta/meta.dart';

import '../../../core/models/subscribes_model.dart';
import '../model/payment_response_model.dart';

part 'payment_state.dart';

class PaymentCubit extends Cubit<PaymentState> {
  PaymentCubit(this.api) : super(PaymentInitial()) {
    getPaymentMonth();
  }

  final ServiceApi api;
  int totalPayment = 0;
  List<int> paymentList = [];
  List<SubscribesDatum> subscribesList = [];
  List<SubscribesDatum> tempSubscribesList = [];
  PaymentResponse? paymentResponse;

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
      paymentList.add(model.id!);
      emit(PaymentChangeList());
    }
    if (type == 'remove') {
      paymentList.removeWhere((element) => element == model.id);
      tempSubscribesList.removeWhere((element) {
        if (element.id == model.id) {
          totalPayment = totalPayment - model.price!;
        }
        return element.id == model.id;
      });
      emit(PaymentChangeList());
    }
  }

  pay({
    required String fullName,
    required String cardNumber,
    required String month,
    required String year,
    required String cvv,
  }) async {
    emit(PayLoading());
    final response = await api.paySubscribes(
      SendPayModel(
        subscribesIds: paymentList,
        amount: totalPayment.toString(),
        paymentMethod: 'cart',
        fullName: fullName,
        cardNumber: cardNumber,
        month: month,
        year: year,
        cvv: cvv,
      ),
    );
    response.fold(
      (error) => emit(PayError()),
      (res) {
        if (res.code == 200) {
          paymentResponse = res;
          emit(PayLoaded());
          Future.delayed(Duration(seconds: 1), () {
            emit(PaymentInitial());
          });
        } else {
          paymentResponse = res;
          emit(PayError());
          Future.delayed(Duration(milliseconds: 700), () {
            emit(PaymentInitial());
          });
        }
      },
    );
  }
}
