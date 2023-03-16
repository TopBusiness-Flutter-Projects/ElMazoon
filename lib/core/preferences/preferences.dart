import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/exam_answer_list_model.dart';
import '../models/user_model.dart';
import '../utils/app_strings.dart';

class Preferences {
  static final Preferences instance = Preferences._internal();

  Preferences._internal();

  factory Preferences() => instance;

  Future<void> setFirstInstall() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('onBoarding', 'Done');
  }

  Future<String?> getFirstInstall() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? jsonData = prefs.getString('onBoarding');
    return jsonData;
  }

  Future<void> setUser(UserModel userModel) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString(
      'user',
      jsonEncode(
        UserModel.fromJson(
          userModel.toJson(),
        ),
      ),
    );
  }

  Future<UserModel> getUserModel() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? jsonData = preferences.getString('user');
    UserModel userModel;
    if (jsonData != null) {
      userModel = UserModel.fromJson(jsonDecode(jsonData));
      // userModel.data?.isLoggedIn = true;
    } else {
      userModel = UserModel();
    }
    return userModel;
  }
  Future<void> setexam(ExamAnswerListModel examAnswerListModel) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString(
      'exam',
      jsonEncode(
        ExamAnswerListModel.fromJson(
          examAnswerListModel.toJson(),
        ),
      ),
    );
  }

  Future<ExamAnswerListModel> getExamModel() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? jsonData = preferences.getString('exam');
    ExamAnswerListModel examAnswerListModel;
    if (jsonData != null) {
      examAnswerListModel = ExamAnswerListModel.fromJson(jsonDecode(jsonData));
      // userModel.data?.isLoggedIn = true;
    } else {
      examAnswerListModel = ExamAnswerListModel(answers: null, id: 0, time: '');
    }
    return examAnswerListModel;
  }

  Future<bool> clearUserData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.remove('user');
  }

  Future<String> getSavedLang() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(AppStrings.locale) ?? 'en';
  }

  Future<void> savedLang(String local) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString(AppStrings.locale, local);
  }

}
