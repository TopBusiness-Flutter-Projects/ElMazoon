import 'package:bloc/bloc.dart';
import 'package:elmazoon/core/models/answer_model.dart';
import 'package:elmazoon/core/remote/service.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';

import '../../../core/models/question_model.dart';
import '../../../core/models/questiones_data_model.dart';

part 'exam_state.dart';

class ExamCubit extends Cubit<ExamState> {
  final ServiceApi api;
  int index = 0;
  List<int> pendinglist=[];
  QuestionData? questionesDataModel = QuestionData();
  TextEditingController answerController = TextEditingController();
  XFile? imageFile;
  String imagePath = '';
  String audioPath = '';
  ExamCubit(this.api) : super(ExamInitial());
  pickImage({required String type}) async {
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
    emit(ExamPagePickImageSuccess());
  }

  getExam(int exam_id, String exam_type) async {
    final response = await api.getQuestion(exam_id,exam_type);
    response.fold(
      (error) => {},
      (response) {
        if (response.code == 200) {
          questionesDataModel = response.data!;
          index = 0;
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
    if(pendinglist.contains(questionesDataModel!.questions[this.index].id!)){
    //  pendinglist.add(questionesDataModel!.questions[index].id!);
      List<Questions> qu=questionesDataModel!.questions;
      Questions data=qu.elementAt(this.index);
      data.status='pending';
      qu.removeAt(this.index);
      qu.insert(this.index, data);
      questionesDataModel!.questions=qu;
    }

    this.index=index;
    emit(Questionupdate());


  }

  void updateSelectAnswer(int index, int index2) {
    List<Answers>? answers=questionesDataModel!.questions[index].answers;
    for(int i=0;i<answers!.length;i++){
      if(index2==i){
        answers[i].status='select';
      }
      else{
        answers[i].status='';

      }
    }
    emit(Questionupdate());

  }

  void postponeQuestion(int index) {
    if(!pendinglist.contains(questionesDataModel!.questions[index].id!)){
      pendinglist.add(questionesDataModel!.questions[index].id!);

    }
    List<Questions> qu=questionesDataModel!.questions;
    Questions data=qu.elementAt(index);
     data.status='pending';
    qu.removeAt(index);
    qu.insert(index, data);
    questionesDataModel!.questions=qu;
    emit(Questionupdate());

  }
}
