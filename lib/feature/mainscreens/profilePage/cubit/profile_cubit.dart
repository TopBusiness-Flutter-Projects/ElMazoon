import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:elmazoon/core/remote/service.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

import '../../../../core/models/times_model.dart';
import '../../../../core/models/user_model.dart';
import '../../../../core/preferences/preferences.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_routes.dart';
import '../../../../core/utils/show_dialog.dart';
import '../../../../core/utils/toast_message_method.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit(this.api) : super(ProfileInitial()) {
    getProfileData();
  }

  final ServiceApi api;

  TextEditingController studentName = TextEditingController();
  TextEditingController cityName = TextEditingController();
  TextEditingController studentCode = TextEditingController();
  TextEditingController suggest = TextEditingController();

  late UserModel loginModel;

  getProfileData() async {
    loginModel = await Preferences.instance.getUserModel();
    studentName.text = loginModel.data!.name;
    studentCode.text = loginModel.data!.code;
    cityName.text = loginModel.data!.country!.nameAr;
    suggest.clear();
    emit(ProfileGetUserData());
  }

  sendSuggest() async {
    emit(ProfileSendSuggestLoading());
    final response = await api.sendSuggest(suggest: suggest.text);
    response.fold(
      (l) => emit(ProfileSendSuggestError()),
      (r) {
        Future.delayed(Duration(seconds: 1), () {
          getProfileData();
        });
        emit(ProfileSendSuggestLoaded());
      },
    );
  }
  getTimes(BuildContext context) async {
    createProgressDialog(context, 'wait'.tr());

    final response = await api.gettimes();
    response.fold(

          (error) =>   Navigator.of(context).pop(),
          (response) {
    Navigator.of(context).pop();
            TimeDataModel data=response;
            if(data.code==200){
              Navigator.pushNamed(context, Routes.examRegisterRoute,arguments: data);
            }
            else{
              toastMessage(
                'no_exam'.tr(),
                context,
                color: AppColors.error,
              );
            }
        //data = response.data;
      //  emit(NotificationPageLoaded());
      },
    );
  }

}
