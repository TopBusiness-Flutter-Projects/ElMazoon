import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:elmazoon/core/models/answer_model.dart';
import 'package:elmazoon/core/remote/service.dart';
import 'package:elmazoon/core/utils/show_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';

import '../../../core/models/question_model.dart';
import '../../../core/models/questiones_data_model.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/app_routes.dart';
import '../../../core/utils/toast_message_method.dart';
import '../models/answer_exam_model.dart';

part 'exam_state.dart';

class ExamCubit extends Cubit<ExamState> {
  final ServiceApi api;
  int index = 0;
  List<int> pendinglist = [];
  QuestionData? questionesDataModel = QuestionData();
  AnswerExamModel answerExamModel = AnswerExamModel();
  TextEditingController answerController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  XFile? imageFile;
  String imagePath = '';
  String audioPath = '';

  ExamCubit(this.api) : super(ExamInitial());

  pickImage({required String type}) async {
    audioPath = '';
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
    // questionesDataModel!.questions[index].type='image';

    //questionesDataModel!.questions[index].answer=imagePath;
    emit(ExamPagePickImageSuccess());
  }

  getExam(int exam_id, String exam_type) async {
    final response = await api.getQuestion(exam_id, exam_type);
    response.fold(
      (error) => {},
      (response) {
        if (response.code == 200) {
          questionesDataModel = response.data!;
          index = 0;
          for (int i = 0; i < questionesDataModel!.questions.length; i++) {
            answerExamModel.answer.add("");
            answerExamModel.audio.add("");
            answerExamModel.image.add("");
          }

          //List<Questions> qu=questionesDataModel!.questions;
          //Questions data=qu.elementAt(0);
          // data.status='pending';
          ///qu.removeAt(1);
          //qu.insert(1, data);
          //questionesDataModel!.questions=qu;
          emit(Questionupdate());
          // Navigator.pushNamed(context, Routes.examRegisterRoute,arguments: data);
        } else {}
        //data = response.data;
        //  emit(NotificationPageLoaded());
      },
    );
  }

  void updateindex(int index) {
    if (pendinglist.contains(questionesDataModel!.questions[this.index].id!)) {
      //  pendinglist.add(questionesDataModel!.questions[index].id!);
      List<Questions> qu = questionesDataModel!.questions;
      Questions data = qu.elementAt(this.index);
      data.status = 'pending';
      qu.removeAt(this.index);
      qu.insert(this.index, data);
      questionesDataModel!.questions = qu;
    }

    this.index = index;
    emit(Questionupdate());
  }

  void updateSelectAnswer(int index, int index2) {
    List<Answers>? answers = questionesDataModel!.questions[index].answers;
    for (int i = 0; i < answers!.length; i++) {
      if (index2 == i) {
        answers[i].status = 'select';
      } else {
        answers[i].status = '';
      }
    }
    emit(Questionupdate());
  }

  void postponeQuestion(int index) {
    if (!pendinglist.contains(questionesDataModel!.questions[index].id!)) {
      pendinglist.add(questionesDataModel!.questions[index].id!);
    }
    List<Questions> qu = questionesDataModel!.questions;
    Questions data = qu.elementAt(index);
    data.status = 'pending';
    qu.removeAt(index);
    qu.insert(index, data);
    questionesDataModel!.questions = qu;
    emit(Questionupdate());
  }

  void answerQuestion(int index, String type) {
    if (type == 'choice') {
      List<Answers>? answers = questionesDataModel!.questions[index].answers;
      for (int i = 0; i < answers!.length; i++) {
        if (answers[i].status == 'select') {
          answerExamModel.answer.removeAt(index);
          answerExamModel.answer.insert(index, answers[i].id.toString());
        }
      }
    } else {
      print('dldldll');
      print(type);
      if (type == 'audio') {
        answerExamModel.answer.removeAt(index);
        answerExamModel.answer.insert(index, "");
        answerExamModel.image.removeAt(index);
        answerExamModel.image.insert(index, "");

        answerExamModel.audio.removeAt(index);
        answerExamModel.audio
            .insert(index, questionesDataModel!.questions[index].answer);
      } else if (type == 'image') {
        answerExamModel.answer.removeAt(index);
        answerExamModel.answer.insert(index, "");
        answerExamModel.audio.removeAt(index);
        answerExamModel.audio.insert(index, "");
        answerExamModel.image.removeAt(index);

        answerExamModel.image
            .insert(index, questionesDataModel!.questions[index].answer);
      } else {
        answerExamModel.audio.removeAt(index);
        answerExamModel.audio.insert(index, '');
        answerExamModel.image.removeAt(index);
        answerExamModel.image.insert(index, '');
        answerExamModel.answer.removeAt(index);

        answerExamModel.answer
            .insert(index, questionesDataModel!.questions[index].answer);
      }
    }
  }

  void addanswer(String s) {
    answerController.text = '';
    questionesDataModel!.questions[index].type = s;

    if (s == 'audio') {
      imagePath = "";
      questionesDataModel!.questions[index].answer = audioPath;
    } else {
      audioPath = "";
      questionesDataModel!.questions[index].answer = imagePath;
    }
  }

  Future<void> endExam(int time,BuildContext context,String type) async {
    print(answerExamModel.answer);
    print(answerExamModel.audio);
    print(answerExamModel.image);
    print(time);
    createProgressDialog(context, 'wait'.tr());
    var response = await api.answerExam(answerExamModel: answerExamModel,questionData: questionesDataModel!,time: time,type: type);
    response.fold(
          (l) =>  Navigator.of(context).pop(),
          (r) {
        Navigator.of(context).pop();
        if(r.code==200){
          print(r);
          // Navigator.pushNamed(
          //     context,
          //     Routes.confirmexamRegisterRoute,
          //
          //     arguments: r);
          // //   Navigator.pushNamed(context, Routes.examRegisterRoute,arguments: data);
        }
        else{
          toastMessage(
            r.message,
            context,
            color: AppColors.error,
          );
        }

      },
    );
  }

  void addtextanswer() {
    questionesDataModel!.questions[index].type = "text";
    questionesDataModel!.questions[index].answer = answerController.text;

    print(
        "questionesDataModel!.questions[index].answerquestionesDataModel!.questions[index].answer");
    print(questionesDataModel!.questions[index].answer);
  }
}
