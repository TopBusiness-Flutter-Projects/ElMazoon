import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:elmazoon/core/preferences/preferences.dart';
import 'package:elmazoon/core/remote/service.dart';
import 'package:elmazoon/core/utils/app_colors.dart';
import 'package:elmazoon/core/utils/toast_message_method.dart';
import 'package:flutter/cupertino.dart';

import '../models/communication_model.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this.api) : super(LoginInitial()) {
    getCommunicationData();
  }

  final ServiceApi api;
  late CommunicationData communicationData;
  bool isCommunicationData = false;

  TextEditingController codeController = TextEditingController();

  loginWithCode(context) async {
    emit(LoginLoading());
    final response = await api.postLogin(codeController.text);
    response.fold(
      (error) => emit(LoginError()),
      (response) {
        if (response.code == 407) {
          toastMessage(
            'code_not_found'.tr(),
            context,
            color: AppColors.error,
          );
          emit(LoginError());
        } else if (response.code == 408) {
          toastMessage(
            'code_not_subscribe'.tr(),
            context,
            color: AppColors.error,
          );
          emit(LoginError());
        } else {
          Future.delayed(Duration(seconds: 2), () {
            emit(LoginInitial());
          });
          Preferences.instance.setUser(response);
          emit(LoginLoaded());
        }
      },
    );
  }

  Future<void> getCommunicationData() async {
    emit(LoginCommunicationLoading());
    final response = await api.getCommunicationData();
    response.fold(
      (error) => emit(LoginCommunicationError()),
      (response) {
        if (response.code == 200) {
          communicationData = response.data;
          isCommunicationData =true;
          emit(LoginCommunicationLoaded());
        } else {
          isCommunicationData =false;
          emit(LoginCommunicationError());
        }
      },
    );
  }
}
