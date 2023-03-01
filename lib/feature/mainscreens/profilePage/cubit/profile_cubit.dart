import 'package:bloc/bloc.dart';
import 'package:elmazoon/core/remote/service.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

import '../../../../core/models/user_model.dart';
import '../../../../core/preferences/preferences.dart';

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
    cityName.text = loginModel.data!.country.name;
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
}
