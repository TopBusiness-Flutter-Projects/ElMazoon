import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:elmazoon/core/models/answer_model.dart';
import 'package:elmazoon/core/remote/service.dart';
import 'package:elmazoon/core/utils/show_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';

import '../../../core/models/exam_answer_list_model.dart';
import '../../../core/models/exam_answer_model.dart';
import '../../../core/models/question_model.dart';
import '../../../core/models/questiones_data_model.dart';
import '../../../core/preferences/preferences.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/app_routes.dart';
import '../../../core/utils/toast_message_method.dart';
import '../../exam_degree_detials/cubit/exam_degree_cubit.dart';
import '../../mainscreens/homePage/cubit/home_page_cubit.dart';
import '../../mainscreens/study_page/cubit/study_page_cubit.dart';
import '../models/answer_exam_model.dart';

part 'exam_state.dart';

class ExamCubit extends Cubit<ExamState> {
  final ServiceApi api;
  int index = 0;
  int pendingNumberIndex = 0;
  int examTypeId = 0;
  int examVideoIndex = 0;
  int examSubjectClassIndex = 0;
  List<int> pendingList = [];
  List<int> pendingListNumber = [];
  QuestionData? questionsDataModel;
  var minute = "0";
  var second = "0";

  AnswerExamModel? answerExamModel;

  TextEditingController? answerController;
  int minutes = -1;
  int seconed = -1;
  final formKey = GlobalKey<FormState>();

  XFile? imageFile;
  List<String> imagePath = [];

  List<String> audioPath = [];

  ExamCubit(this.api) : super(ExamInitial()) {
    questionsDataModel = QuestionData();
    audioPath = [];
    imagePath = [];
    pendingList = [];
    answerExamModel = AnswerExamModel(answer: [], audio: [], image: []);
    answerController = TextEditingController();
    index = 0;
  }

  pickImage({required String type}) async {
    audioPath[index] = '';
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
    imagePath[index] = croppedFile!.path;
    // questionesDataModel!.questions[index].type='image';

    //questionesDataModel!.questions[index].answer=imagePath;
    emit(ExamPagePickImageSuccess());
  }

  getExam(int exam_id, String exam_type) async {
    emit(ExamInitial());
    audioPath = [];
    imagePath = [];
    final response = await api.getQuestion(exam_id, exam_type);
    response.fold(
      (error) => {},
      (response) {
        if (response.code == 200) {
          questionsDataModel = response.data!;
          index = 0;
          for (int i = 0; i < questionsDataModel!.questions.length; i++) {
            answerExamModel!.answer.add("");
            answerExamModel!.audio.add("");
            answerExamModel!.image.add("");
            audioPath.add('');
            imagePath.add('');
          }

          //List<Questions> qu=questionesDataModel!.questions;
          //Questions data=qu.elementAt(0);
          // data.status='pending';
          ///qu.removeAt(1);
          //qu.insert(1, data);
          //questionesDataModel!.questions=qu;
          getExamDataFromPreference();
          // Navigator.pushNamed(context, Routes.examRegisterRoute,arguments: data);
        } else {}
        //data = response.data;
        //  emit(NotificationPageLoaded());
      },
    );
  }

  void updateIndex(int index) {
    if (pendingList.contains(questionsDataModel!.questions[this.index].id!)) {
      List<Questions> qu = questionsDataModel!.questions;
      Questions data = qu.elementAt(this.index);
      data.status = 'pending';
      qu.removeAt(this.index);
      qu.insert(this.index, data);
      questionsDataModel!.questions = qu;
    }
    this.index = index;
    emit(Questionupdate());
  }

  void updateSelectAnswer(int index2) {
    List<Answers>? answers = questionsDataModel!.questions[index].answers;
    for (int i = 0; i < answers!.length; i++) {
      if (index2 == i) {
        answers[i].status = 'select';
      } else {
        answers[i].status = '';
      }
    }
    emit(Questionupdate());
  }

  void postponeQuestion(int index, String type) {
    questionsDataModel!.questions[index].status = 'pending';

    if (!pendingList.contains(questionsDataModel!.questions[index].id!)) {
      pendingList.add(questionsDataModel!.questions[index].id!);
      pendingNumberIndex = index;
      pendingNumberIndex = pendingNumberIndex + 1;
      pendingListNumber.add(pendingNumberIndex);
    }

    if (type == 'choice') {
      List<Answers>? answers = questionsDataModel!.questions[index].answers;
      for (int i = 0; i < answers!.length; i++) {
        if (answers[i].status == 'select') {
          answerExamModel!.answer.removeAt(index);
          answerExamModel!.answer.insert(index, '');
        }
      }
    } else {
      if (type == 'audio') {
        answerExamModel!.answer.removeAt(index);
        answerExamModel!.answer.insert(index, "");
        answerExamModel!.image.removeAt(index);
        answerExamModel!.image.insert(index, "");
        answerExamModel!.audio.removeAt(index);
        answerExamModel!.audio.insert(index, '');
      } else if (type == 'image') {
        answerExamModel!.answer.removeAt(index);
        answerExamModel!.answer.insert(index, "");
        answerExamModel!.audio.removeAt(index);
        answerExamModel!.audio.insert(index, "");
        answerExamModel!.image.removeAt(index);
        answerExamModel!.image.insert(index, '');
      } else {
        answerExamModel!.audio.removeAt(index);
        answerExamModel!.audio.insert(index, '');
        answerExamModel!.image.removeAt(index);
        answerExamModel!.image.insert(index, '');
        answerExamModel!.answer.removeAt(index);
        answerExamModel!.answer.insert(index, '');
      }
    }

    emit(Questionupdate());
  }

  void answerQuestion(int index, String type) {
    questionsDataModel!.questions[index].status = 'answered';
    if (pendingList.contains(questionsDataModel!.questions[index].id)) {
      pendingList.remove(questionsDataModel!.questions[index].id);
      pendingNumberIndex = index;
      pendingNumberIndex = pendingNumberIndex + 1;
      pendingListNumber.remove(pendingNumberIndex);
    }
    if (type == 'choice') {
      List<Answers>? answers = questionsDataModel!.questions[index].answers;
      for (int i = 0; i < answers!.length; i++) {
        if (answers[i].status == 'select') {
          answerExamModel!.answer.removeAt(index);
          answerExamModel!.answer.insert(index, answers[i].id.toString());
        }
      }
    } else {
      if (type == 'audio') {
        answerExamModel!.answer.removeAt(index);
        answerExamModel!.answer.insert(index, "");
        answerExamModel!.image.removeAt(index);
        answerExamModel!.image.insert(index, "");
        answerExamModel!.audio.removeAt(index);
        answerExamModel!.audio
            .insert(index, questionsDataModel!.questions[index].answer);
      } else if (type == 'image') {
        answerExamModel!.answer.removeAt(index);
        answerExamModel!.answer.insert(index, "");
        answerExamModel!.audio.removeAt(index);
        answerExamModel!.audio.insert(index, "");
        answerExamModel!.image.removeAt(index);
        answerExamModel!.image
            .insert(index, questionsDataModel!.questions[index].answer);
      } else {
        answerExamModel!.audio.removeAt(index);
        answerExamModel!.audio.insert(index, '');
        answerExamModel!.image.removeAt(index);
        answerExamModel!.image.insert(index, '');
        answerExamModel!.answer.removeAt(index);
        answerExamModel!.answer
            .insert(index, questionsDataModel!.questions[index].answer);
      }
    }
    emit(Questionupdate());
  }

  void addAnswer(String s) {
    answerController!.text = '';
    questionsDataModel!.questions[index].type = s;

    if (s == 'audio') {
      imagePath[index] = "";
      questionsDataModel!.questions[index].answer = audioPath[index];
    } else {
      audioPath[index] = "";
      questionsDataModel!.questions[index].answer = imagePath[index];
    }
  }

  Future<void> endExam(int time, BuildContext context, String type) async {
    print(answerExamModel!.answer);
    print(answerExamModel!.audio);
    print(answerExamModel!.image);
    print(time);
    createProgressDialog(context, 'wait'.tr());
    var response = await api.answerExam(
      answerExamModel: answerExamModel!,
      questionData: questionsDataModel!,
      time: time,
      type: type,
    );
    response.fold(
      (l) => Navigator.of(context).pop(),
      (r) {
        Navigator.of(context).pop();
        if (r.code == 200) {
          audioPath = [];
          imagePath = [];
          pendingList = [];
          answerExamModel = AnswerExamModel(answer: [], audio: [], image: []);
          Preferences.instance
              .setexam(new ExamAnswerListModel(answers: null, id: 0, time: ''));

          if (r.data!.instruction!.exam_type != 'full_exam') {
            print(
                '*************************  انا هنااااااااااااا  **********************************');
            if (r.data!.depends == 'depends') {
              context
                ..read<StudyPageCubit>()
                    .accessNextVideo(
                  examTypeId,
                  r.data!.instruction!.exam_type,
                  context,
                )
                    .whenComplete(
                  () {
                    context..read<ExamDegreeCubit>().examAnswerModel = r;
                    context..read<ExamDegreeCubit>().getExamDetails(r);
                    changeInstructionOfExam(
                      r,
                      context.read<StudyPageCubit>(),
                      context.read<HomePageCubit>(),
                    );
                    type == 'lesson'
                        ? Navigator.pop(context)
                        : type == 'subject_class'
                            ? Navigator.pop(context)
                            : null;
                    Navigator.pushReplacementNamed(
                      context,
                      Routes.examdegreeDetialsRoute,
                      arguments: r,
                    );
                  },
                );
            }
            else {
              changeInstructionOfExam(
                r,
                context.read<StudyPageCubit>(),
                context.read<HomePageCubit>(),
              );
              Navigator.pop(context);
              Navigator.pop(context);
              toastMessage(
                'not_depended'.tr(),
                context,
                color: AppColors.error,
                duration: 500,
              );
            }
          } else {
            if (r.data!.depends == 'depends') {
              context..read<ExamDegreeCubit>().examAnswerModel = r;
              context..read<ExamDegreeCubit>().getExamDetails(r);
              changeInstructionOfExam(
                r,
                context.read<StudyPageCubit>(),
                context.read<HomePageCubit>(),
              );
              Navigator.pushReplacementNamed(
                context,
                Routes.examdegreeDetialsRoute,
                arguments: r,
              );
            } else {
              changeInstructionOfExam(
                r,
                context.read<StudyPageCubit>(),
                context.read<HomePageCubit>(),
              );
              Navigator.pop(context);
              Navigator.pop(context);
              toastMessage(
                'not_depended'.tr(),
                context,
                color: AppColors.error,
                duration: 500,
              );
            }
          }
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

  changeInstructionOfExam(
      ExamAnswerModel model, StudyPageCubit cubit, HomePageCubit homeCubit) {
    if (model.data!.instruction!.exam_type == 'video') {
      print('###########   video   #########');
      cubit.lessonsDetailsModel!.data.videos[examVideoIndex].exams!.first
          .instruction = model.data!.instruction;
    } else if (model.data!.instruction!.exam_type == 'lesson') {
      print('###########   lesson   #########');
      cubit.lessonsDetailsModel!.data.exams.first.instruction =
          model.data!.instruction;
      homeCubit.getHomePageData();
      cubit.getAllClasses();
    } else if (model.data!.instruction!.exam_type == 'subject_class') {
      print('###########   subject_class   #########');
      cubit.allClassesDatum!.classes[examSubjectClassIndex].exams.first
          .instruction = model.data!.instruction;
      homeCubit.classes[examSubjectClassIndex].exams.first.instruction =
          model.data!.instruction;
      homeCubit.getHomePageData();
      cubit.getAllClasses();
    }
  }

  Future<void> endExamTime(int time, BuildContext context, String type) async {
    createProgressDialog(context, 'wait'.tr());

    var response = await api.updateAcessTime(
      time: time,
      type: type,
      exam_id: questionsDataModel!.id!,
    );
    response.fold(
      (l) => Navigator.of(context).pop(),
      (r) {
        Navigator.of(context).pop();
        if (r.code == 200) {
          Preferences.instance
              .setexam(new ExamAnswerListModel(answers: null, id: 0, time: ''));
          Navigator.of(context).pop();
          toastMessage(
            'time_out'.tr(),
            context,
            color: AppColors.error,
          );
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

  void addTextAnswer() {
    questionsDataModel!.questions[index].type = "text";
    questionsDataModel!.questions[index].answer = answerController!.text;
  }

  Future<void> getExamDataFromPreference() async {
    ExamAnswerListModel examAnswerListModel =
        await Preferences.instance.getExamModel();
    print('dlkdkddkk');
    print(examAnswerListModel.id);
    print(questionsDataModel!.id);
    if (examAnswerListModel.id == questionsDataModel!.id) {
      print('dlkdkddkk');
      print(examAnswerListModel.answers!.answer);
      answerExamModel = examAnswerListModel.answers;
      minutes = int.parse(examAnswerListModel.time.split(":")[0]);
      seconed = int.parse(examAnswerListModel.time.split(":")[1]);
      print(minutes);
      print(seconed);
      // questionesDataModel.quizMinute=examAnswerListModel.
      for (int i = 0; i < questionsDataModel!.questions.length; i++) {
        List<Answers>? answers = questionsDataModel!.questions[i].answers;
        if (answers!.length > 0) {
          for (int j = 0; j < answers.length; j++) {
            print('dlkssssdkddkk');
            print(answerExamModel!.answer.elementAt(i));
            print('dlkdkddksseeek');
            print(answers.elementAt(j).id.toString());
            if (answerExamModel!.answer.elementAt(i) ==
                answers.elementAt(j).id.toString()) {
              answers.elementAt(j).status = "select";
              index = i;
            }
          }
          questionsDataModel!.questions[i].answers = answers;
        } else {
          audioPath[i] = answerExamModel!.audio.elementAt(i);
          imagePath[i] = answerExamModel!.image.elementAt(i);
          answerController!.text = answerExamModel!.answer[i];
          if (audioPath[i].isNotEmpty ||
              imagePath[i].isNotEmpty ||
              answerExamModel!.answer[i].isNotEmpty) {
            index = i;
          }
        }
      }
    }

    emit(Questionupdate());
  }

  Future<void> saveExam(String s) async {
    print("ooi999");
    ExamAnswerListModel examAnswerListModel =
        await Preferences.instance.getExamModel();
    if (examAnswerListModel.id == 0) {
      ExamAnswerListModel examAnswerListModel = ExamAnswerListModel(
          answers: answerExamModel, id: questionsDataModel!.id!, time: s);
      Preferences.instance.setexam(examAnswerListModel);
    }
  }

  void updateTime() {
    seconed = -1;
    minutes = -1;
    emit(Questionupdate());
  }
}
