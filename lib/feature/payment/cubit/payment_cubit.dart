import 'package:bloc/bloc.dart';
import 'package:elmazoon/core/remote/service.dart';
import 'package:elmazoon/feature/payment/model/pay_model.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import '../../../core/models/subscribes_model.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/toast_message_method.dart';
import '../model/payment_response_model.dart';
import '../screen/pay_screen.dart';

part 'payment_state.dart';

class PaymentCubit extends Cubit<PaymentState> {
  PaymentCubit(this.api) : super(PaymentInitial()) {
    getPaymentMonth();
  }

  final ServiceApi api;
  int totalPayment = 0;
  List<int> paymentList = [];
  List<int> monthNumber = [];
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

  testMonth(context, String lang) {
    for (int i = 0; i < monthNumber.length; i++) {
      int y = i;
      print(monthNumber.length);
      print(i);
      if (y + 1 != monthNumber.length) {
        int index = i;
        if (monthNumber[index + 1] - monthNumber[i] != 1) {
          toastMessage(
            lang == 'en'
                ? 'you cant Subscribes month ${monthNumber[index + 1]} before month ${monthNumber[i] + 1}'
                : ' لا يمكنك الاشتراك فى شهر ${monthNumber[index + 1]} قبل شهر   ${monthNumber[i] + 1}',
            context,
            color: AppColors.error,
          );
          break;
        } else {
          continue;
        }
      }else{
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PayScreen(),
          ),
        );
      }
    }
  }

  addOrRemoveModel(SubscribesDatum model, String type) {
    if (type == 'add') {
      totalPayment = totalPayment + model.price!;
      tempSubscribesList.add(model);
      paymentList.add(model.id!);
      monthNumber.add(model.month!);
      monthNumber.sort();
      emit(PaymentChangeList());
    }
    if (type == 'remove') {
      paymentList.removeWhere((element) => element == model.id);
      monthNumber.removeWhere((element) => element == model.month);
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
