import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:elmazoon/core/models/student_report_model.dart';
import 'package:elmazoon/core/remote/service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:open_filex/open_filex.dart';
import 'package:pdf/widgets.dart';

import '../../../../core/models/times_model.dart';
import '../../../../core/models/user_model.dart';
import '../../../../core/preferences/preferences.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_routes.dart';
import '../../../../core/utils/show_dialog.dart';
import '../../../../core/utils/toast_message_method.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:google_fonts/google_fonts.dart';

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

  Future<void> getReport(BuildContext context) async {
    createProgressDialog(context, 'wait'.tr());
    var response = await api.getStudentReport();
    response.fold(
          (l) => Navigator.of(context).pop(),
          (r) {
        Navigator.of(context).pop();
        if (r.code == 200) {
          getPermission(r);
          //   Navigator.pushNamed(context, Routes.examRegisterRoute,arguments: data);
        } else {
          toastMessage(
            r.message,
            context,
            color: AppColors.error,
          );
        }
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
            Future.delayed(Duration(milliseconds: 500), () {
              getProfileData(isUpdate: true);
            });
          },
        );
      },
    );
  }

  Future<void> makePdf(StudentReportModel? studentReportModel) async {
    final pdf = pw.Document();
    String lan = await Preferences.instance.getSavedLang();

    final font = await rootBundle.load("assets/fonts/font_normal.ttf");
    final ttf = Font.ttf(font);
    pw.Font? tamilFont = pw.Font.ttf(font);

    pdf.addPage(
      pw.Page(
          textDirection:
          lan == 'ar' ? pw.TextDirection.rtl : pw.TextDirection.ltr,
          pageFormat: PdfPageFormat.a4,
          theme: pw.ThemeData(
              defaultTextStyle: pw.TextStyle(
                font: tamilFont,
              )),
          build: (pw.Context context) =>
              pw.ListView(children: [
                pw.Center(
                    child: pw.SizedBox(
                      child: pw.Text(studentReportModel!.data!.user!.name!,
                          textDirection: pw.TextDirection.rtl,
                          softWrap: true,
                          tightBounds: true,
                          overflow: pw.TextOverflow.span,
                          style: pw.TextStyle(
                            font: ttf,
                            fontSize: 40,
                            fontBold: tamilFont,
                          )),
                    )),
                pw.Center(
                  child: pw.Text(studentReportModel.data!.user!.phone!,
                      textDirection: pw.TextDirection.rtl,
                      style:
                      pw.TextStyle(font: ttf, fontSize: 14, fontBold: ttf)),
                ),
                pw.SizedBox(height: 20),
                pw.Center(
                    child: pw.SizedBox(
                      child: pw.Text('app_exam'.tr(),
                          textDirection: lan == 'ar' ? pw.TextDirection.rtl : pw
                              .TextDirection.ltr,
                          softWrap: true,
                          tightBounds: true,
                          overflow: pw.TextOverflow.span,
                          style: pw.TextStyle(
                            font: ttf,
                            fontSize: 40,
                            fontBold: tamilFont,
                          )),
                    )),
                pw.SizedBox(height: 2),
                pw.Table(
                    children:
                    lan == 'ar' ?
                    List.generate(

                        studentReportModel.data!.exams!.length, (index) {
                      return pw.TableRow(children: [
                        pw.Expanded(
                            child: pw.Container(
                                child: pw.Center(child: pw.Text(
                                    studentReportModel.data!.exams![index].per!,
                                    style: pw.TextStyle(
                                      font: ttf,
                                      fontSize: 14,
                                    ))),
                                decoration: pw.BoxDecoration(
                                    shape: pw.BoxShape.rectangle,
                                    border: pw.Border(
                                        top: pw.BorderSide(
                                            color: PdfColors.black),
                                        bottom:
                                        pw.BorderSide(color: PdfColors.black),
                                        right:
                                        pw.BorderSide(color: PdfColors.black),
                                        left: pw.BorderSide(
                                            color: PdfColors.black))
                                ),
                                height: 50
                            )
                        ),
                        pw.Expanded(

                            child: pw.Container(

                                child: pw.Center(child: pw.Text(
                                    studentReportModel
                                        .data!.exams![index].fullDegree!,
                                    textDirection: pw.TextDirection.rtl,
                                    style: pw.TextStyle(
                                        font: ttf,
                                        fontSize: 14,
                                        fontBold: ttf)),
                                ),
                                decoration: pw.BoxDecoration(
                                    shape: pw.BoxShape.rectangle,
                                    border: pw.Border(
                                        top: pw.BorderSide(
                                            color: PdfColors.black),
                                        bottom:
                                        pw.BorderSide(color: PdfColors.black),
                                        right:
                                        pw.BorderSide(color: PdfColors.black),
                                        left: pw.BorderSide(
                                            color: PdfColors.black))
                                ),
                                height: 50
                            )),

                        pw.Expanded(

                            child:
                            pw.Container(
                                child: pw.Center(child: pw.Text(
                                    studentReportModel.data!.exams![index]
                                        .exam!,
                                    textDirection: pw.TextDirection.rtl,
                                    style: pw.TextStyle(
                                        font: ttf,
                                        fontSize: 14,
                                        fontBold: ttf))),
                                decoration: pw.BoxDecoration(
                                    shape: pw.BoxShape.rectangle,
                                    border: pw.Border(
                                        top: pw.BorderSide(
                                            color: PdfColors.black),
                                        bottom:
                                        pw.BorderSide(color: PdfColors.black),
                                        right:
                                        pw.BorderSide(color: PdfColors.black),
                                        left:
                                        pw.BorderSide(color: PdfColors.black))),
                                height: 50),
                            flex: 2),
                      ]);
                    }) :
                    List.generate(
                        studentReportModel.data!.exams!.length, (index) {
                      return pw.TableRow(children: [
                        pw.Expanded(

                            child: pw.Container(
                                child: pw.Center(child: pw.Text(
                                    studentReportModel.data!.exams![index]
                                        .exam!,
                                    textDirection: pw.TextDirection.rtl,
                                    style: pw.TextStyle(
                                        font: ttf,
                                        fontSize: 14,
                                        fontBold: ttf))),
                                decoration: pw.BoxDecoration(
                                    shape: pw.BoxShape.rectangle,
                                    border: pw.Border(
                                        top: pw.BorderSide(
                                            color: PdfColors.black),
                                        bottom:
                                        pw.BorderSide(color: PdfColors.black),
                                        right:
                                        pw.BorderSide(color: PdfColors.black),
                                        left:
                                        pw.BorderSide(color: PdfColors.black))),
                                height: 50),
                            flex: 2),
                        pw.Expanded(
                            child: pw.Container(
                                child: pw.Center(child: pw.Text(
                                    studentReportModel
                                        .data!.exams![index].fullDegree!,
                                    textDirection: pw.TextDirection.rtl,
                                    style: pw.TextStyle(
                                        font: ttf,
                                        fontSize: 14,
                                        fontBold: ttf)),
                                ),
                                decoration: pw.BoxDecoration(
                                    shape: pw.BoxShape.rectangle,
                                    border: pw.Border(
                                        top: pw.BorderSide(
                                            color: PdfColors.black),
                                        bottom:
                                        pw.BorderSide(color: PdfColors.black),
                                        right:
                                        pw.BorderSide(color: PdfColors.black),
                                        left: pw.BorderSide(
                                            color: PdfColors.black))
                                ),
                                height: 50)),
                        pw.Expanded(
                            child: pw.Container(
                                child: pw.Center(child: pw.Text(
                                    studentReportModel.data!.exams![index].per!,
                                    style: pw.TextStyle(
                                      font: ttf,
                                      fontSize: 14,
                                    ))),
                                decoration: pw.BoxDecoration(
                                    shape: pw.BoxShape.rectangle,
                                    border: pw.Border(
                                        top: pw.BorderSide(
                                            color: PdfColors.black),
                                        bottom:
                                        pw.BorderSide(color: PdfColors.black),
                                        right:
                                        pw.BorderSide(color: PdfColors.black),
                                        left: pw.BorderSide(
                                            color: PdfColors.black))),
                                height: 50
                            )
                        ),
                      ]);
                    })),
                pw.SizedBox(height: 20),
                pw.Center(
                    child: pw.SizedBox(
                      child: pw.Text('paper_exam'.tr(),
                          textDirection: lan == 'ar' ? pw.TextDirection.rtl : pw
                              .TextDirection.ltr,
                          softWrap: true,
                          tightBounds: true,
                          overflow: pw.TextOverflow.span,
                          style: pw.TextStyle(
                            font: ttf,
                            fontSize: 40,
                            fontBold: tamilFont,
                          )),
                    )),
                pw.SizedBox(height: 2),
                pw.Table(
                    children:
                    lan == 'ar' ?
                    List.generate(
                        studentReportModel.data!.papelSheet!.length, (index) {
                      return pw.TableRow(children: [
                        pw.Expanded(
                          child: pw.Container(
                              child: pw.Center(child: pw.Text(
                                  studentReportModel
                                      .data!.papelSheet![index].per!,
                                  textDirection: pw.TextDirection.rtl,
                                  style: pw.TextStyle(
                                      font: ttf,
                                      fontSize: 14,
                                      fontBold: ttf))),
                              decoration: pw.BoxDecoration(
                                  shape: pw.BoxShape.rectangle,
                                  border: pw.Border(
                                      top: pw.BorderSide(
                                          color: PdfColors.black),
                                      bottom:
                                      pw.BorderSide(color: PdfColors.black),
                                      right:
                                      pw.BorderSide(color: PdfColors.black),
                                      left: pw.BorderSide(
                                          color: PdfColors.black))),
                              height: 50
                          ),

                        ),
                        pw.Expanded(

                            child: pw.Container(
                                child:
                                pw.Center(child: pw.Text(
                                    studentReportModel
                                        .data!.papelSheet![index].fullDegree!,
                                    textDirection: pw.TextDirection.rtl,
                                    style: pw.TextStyle(
                                        font: ttf,
                                        fontSize: 14,
                                        fontBold: ttf))),
                                decoration: pw.BoxDecoration(
                                    shape: pw.BoxShape.rectangle,
                                    border: pw.Border(
                                        top: pw.BorderSide(
                                            color: PdfColors.black),
                                        bottom:
                                        pw.BorderSide(color: PdfColors.black),
                                        right:
                                        pw.BorderSide(color: PdfColors.black),
                                        left: pw.BorderSide(
                                            color: PdfColors.black))
                                ),
                                height: 50
                            )
                        ),

                        pw.Expanded(
                            child: pw.Container(
                                child: pw.Center(child: pw.Text(
                                    studentReportModel.data!.papelSheet![index]
                                        .exam!,
                                    textDirection: pw.TextDirection.rtl,
                                    style: pw.TextStyle(
                                        font: ttf,
                                        fontSize: 14,
                                        fontBold: ttf))),
                                decoration: pw.BoxDecoration(
                                    shape: pw.BoxShape.rectangle,
                                    border: pw.Border(
                                        top: pw.BorderSide(
                                            color: PdfColors.black),
                                        bottom: pw.BorderSide(
                                            color: PdfColors.black),
                                        right: pw.BorderSide(
                                            color: PdfColors.black),
                                        left: pw.BorderSide(
                                            color: PdfColors.black))),
                                height: 50
                            ),
                            flex: 2
                        ),

                      ]);
                    }) :
                    List.generate(
                        studentReportModel.data!.papelSheet!.length, (index) {
                      return pw.TableRow(children: [
                        pw.Expanded(
                            child: pw.Container(
                                child: pw.Center(child: pw.Text(
                                    studentReportModel.data!.papelSheet![index]
                                        .exam!,
                                    textDirection: pw.TextDirection.rtl,
                                    style: pw.TextStyle(
                                        font: ttf,
                                        fontSize: 14,
                                        fontBold: ttf))),
                                decoration: pw.BoxDecoration(
                                    shape: pw.BoxShape.rectangle,
                                    border: pw.Border(
                                        top: pw.BorderSide(
                                            color: PdfColors.black),
                                        bottom: pw.BorderSide(
                                            color: PdfColors.black),
                                        right: pw.BorderSide(
                                            color: PdfColors.black),
                                        left: pw.BorderSide(
                                            color: PdfColors.black))),
                                height: 50

                            ),
                            flex: 2),
                        pw.Expanded(

                          child: pw.Container(
                              child:
                              pw.Center(child: pw.Text(
                                  studentReportModel
                                      .data!.papelSheet![index].fullDegree!,
                                  textDirection: pw.TextDirection.rtl,
                                  style: pw.TextStyle(
                                      font: ttf, fontSize: 14, fontBold: ttf))),
                              decoration: pw.BoxDecoration(
                                  shape: pw.BoxShape.rectangle,
                                  border: pw.Border(
                                      top: pw.BorderSide(
                                          color: PdfColors.black),
                                      bottom:
                                      pw.BorderSide(color: PdfColors.black),
                                      right:
                                      pw.BorderSide(color: PdfColors.black),
                                      left: pw.BorderSide(
                                          color: PdfColors.black))),
                              height: 50
                          )
                          ,
                        ),
                        pw.Expanded(
                            child: pw.Container(

                                child: pw.Center(child: pw.Text(
                                    studentReportModel
                                        .data!.papelSheet![index].per!,
                                    textDirection: pw.TextDirection.rtl,
                                    style: pw.TextStyle(
                                        font: ttf,
                                        fontSize: 14,
                                        fontBold: ttf))),
                                decoration: pw.BoxDecoration(
                                    shape: pw.BoxShape.rectangle,
                                    border: pw.Border(
                                        top: pw.BorderSide(
                                            color: PdfColors.black),
                                        bottom:
                                        pw.BorderSide(color: PdfColors.black),
                                        right:
                                        pw.BorderSide(color: PdfColors.black),
                                        left: pw.BorderSide(
                                            color: PdfColors.black))),
                                height: 50

                            )),
                      ]);
                    })),
              ])),
    );
    var dir = await (Platform.isIOS
        ? getApplicationSupportDirectory()
        : getApplicationDocumentsDirectory());
    final file = File(dir.path + '/example.pdf');
    await file.writeAsBytes(await pdf.save());
    OpenFilex.open(file.path);
  }

  void getPermission(StudentReportModel? studentReportModel) async {
    var status = await Permission.storage.status;
    if (status.isDenied) {
      var status1 = await Permission.storage.request();
      if (status1.isGranted) {
        makePdf(studentReportModel);
      }
      ;
      // We didn't ask for permission yet or the permission has been denied before but not permanently.
    } else {
      makePdf(studentReportModel);
    }
  }
}
