import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:elmazoon/core/remote/service.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

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

  UserModel? userModel;

  XFile? imageFile;
  String imagePath = '';

  pickImage({required String type}) async {
    if (type == 'none') {
      imagePath = '';
      emit(PickImageSuccess());
    } else {
      imageFile = await ImagePicker().pickImage(
        source: type == 'camera' ? ImageSource.camera : ImageSource.gallery,
      );
      CroppedFile? croppedFile = await ImageCropper.platform.cropImage(
        sourcePath: imageFile!.path,
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.ratio7x5,
          CropAspectRatioPreset.ratio16x9
        ],
        cropStyle: CropStyle.rectangle,
        compressFormat: ImageCompressFormat.png,
        compressQuality: 90,
      );
      imagePath = croppedFile!.path;
      emit(PickImageSuccess());
    }
  }

  Future<void> getProfileData({bool? isUpdate = false}) async {
    if (isUpdate!) {
      userModel = await Preferences.instance.getUserModel();
      emit(ProfileGetUserData());
    } else {
      userModel = await Preferences.instance.getUserModel();
      studentName.text = userModel!.data!.name;
      studentCode.text = userModel!.data!.code;
      cityName.text = userModel!.data!.country!.nameAr;
      suggest.clear();
      emit(ProfileGetUserData());
    }
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
      (error) => Navigator.of(context).pop(),
      (response) {
        Navigator.of(context).pop();
        TimeDataModel data = response;
        if (data.code == 200) {
          Navigator.pushNamed(context, Routes.examRegisterRoute,
              arguments: data);
        } else {
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

  updateProfileImage() async {
    emit(ProfileUpdateLoading());
    final response = await api.updateProfile(imagePath: imagePath);
    response.fold(
      (error) => emit(ProfileSendSuggestError()),
      (res) {
        Preferences.instance.setUser(res).whenComplete(
              () {
                emit(ProfileSendSuggestLoaded());
                Future.delayed(Duration(milliseconds: 500),(){
                  getProfileData(isUpdate: true);
                });
              },
            );
      },
    );
  }
}
