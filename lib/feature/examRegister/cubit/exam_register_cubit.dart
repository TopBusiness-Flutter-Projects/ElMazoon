import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

import '../../../core/models/user_model.dart';
import '../../../core/preferences/preferences.dart';

part 'exam_register_state.dart';

class ExamRegisterCubit extends Cubit<ExamRegisterState> {
  TextEditingController studentName = TextEditingController();
  TextEditingController phoneName = TextEditingController();
  TextEditingController studentCode = TextEditingController();
  TextEditingController suggest = TextEditingController();
  ExamRegisterCubit() : super(ExamRegisterInitial()){
    getProfileData();
  }

   UserModel? loginModel;

  getProfileData() async {
    loginModel = await Preferences.instance.getUserModel();
    studentName.text = loginModel!.data!.name;
    studentCode.text = loginModel!.data!.code;
    phoneName.text = loginModel!.data!.phone;
   // suggest.clear();
    //emit(ProfileGetUserData());
  }




}
