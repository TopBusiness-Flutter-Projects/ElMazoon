import 'package:bloc/bloc.dart';
import 'package:elmazoon/core/models/user_model.dart';
import 'package:elmazoon/core/preferences/preferences.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/models/comments_model.dart';
import '../../../../core/models/lessons_details_model.dart';
import '../../../../core/remote/service.dart';
import '../models/all_classes_model.dart';

part 'study_page_state.dart';

class StudyPageCubit extends Cubit<StudyPageState> {
  StudyPageCubit(this.api) : super(StudyPageInitial()) {
    getAllClasses().whenComplete(() => getUserData());
  }

  final ServiceApi api;

  AllClassesDatum? allClassesDatum;
  late LessonsDetailsModel lessonsDetailsModel;
  late Comments comments;
  late UserModel userModel;

  List<CommentDatum> commentsList = [];
  List<CommentDatum> tempCommentsList = [];
  String lan = 'en';
  int index = 0;

  bool isCommentFieldEnable = true;
  TextEditingController commentController = TextEditingController();
  TextEditingController replyController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final replyFormKey = GlobalKey<FormState>();
  XFile? imageFile;
  String imagePath = '';
  String audioPath = '';

  getUserData() async {
    userModel = await Preferences.instance.getUserModel();
    lan = await Preferences.instance.getSavedLang();
    emit(StudyPageGetUserModel());
  }

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
    emit(StudyPagePickImageSuccess());
  }

  Future<void> getAllClasses() async {
    emit(StudyPageLoading());
    final response = await api.getAllClasses();
    response.fold(
      (error) => emit(StudyPageError()),
      (response) {
        allClassesDatum = response.data;
        emit(StudyPageLoaded());
      },
    );
  }

  getLessonsDetails(int id) async {
    emit(StudyPageLessonsLoading());
    final response = await api.getLessonsDetails(id);
    response.fold(
      (error) => emit(StudyPageLessonsError()),
      (response) {
        lessonsDetailsModel = response;
        emit(StudyPageLessonsLoaded(response));
      },
    );
  }

  getCommentsLesson(int id) async {
    emit(StudyPageCommentsLessonsLoading());
    final response = await api.getCommentsByLesson(id);
    response.fold(
      (error) => emit(StudyPageCommentsLessonsError()),
      (response) {
        comments = response.comments;
        commentsList = response.comments.comment;
        emit(StudyPageCommentsLessonsLoaded());
      },
    );
  }

  getMoreCommentsLesson() async {
    emit(StudyPageMoreCommentsLessonsLoading());
    final response = await api.getMoreComments(comments.links.next);
    response.fold(
      (error) => emit(StudyPageMoreCommentsLessonsError()),
      (response) {
        comments = response.comments;
        commentsList = commentsList + response.comments.comment;
        emit(StudyPageMoreCommentsLessonsLoaded());
      },
    );
  }

  addComment(int lessonId, String type) async {
    isCommentFieldEnable = false;
    tempCommentsList = commentsList.reversed.toList();
    emit(StudyPageAddCommentLoading());
    final response = await api.addComment(
      lessonId,
      type,
      comment: type == 'text' ? commentController.text : null,
      image: type == 'file' ? imagePath : null,
      audio: type == 'audio' ? audioPath : null,
    );
    response.fold(
      (l) => emit(StudyPageAddCommentError()),
      (r) {
        tempCommentsList.add(r.oneComment);
        commentsList = tempCommentsList.reversed.toList();
        isCommentFieldEnable = true;
        commentController.clear();
        emit(StudyPageAddCommentLoaded());
      },
    );
  }

  addReply(int commentId, String type) async {
    isCommentFieldEnable = false;
    emit(StudyPageAddCommentLoading());
    final response = await api.addReply(
      commentId,
      type,
      replay: type == 'text' ? replyController.text : null,
      image: type == 'file' ? imagePath : null,
      audio: type == 'audio' ? audioPath : null,
    );
    response.fold(
      (l) => emit(StudyPageAddCommentError()),
      (r) {
        // tempReplyList.add(r.oneComment);
        commentsList[index].replies!.add(r.oneComment);
        isCommentFieldEnable = true;
        replyController.clear();
        emit(StudyPageAddCommentLoaded());
      },
    );
  }

  Future<void> accessFirstVideo(int id) async {
    emit(StudyPageAccessFirstVideoLoading());
    final response = await api.openFirstVideo(status: 'open', id: id);
    response.fold(
      (l) => emit(StudyPageAccessFirstVideoError()),
      (r) => emit(StudyPageAccessFirstVideoLoaded()),
    );
  }

  Future<void> accessNextVideo(int id) async {
    emit(StudyPageAccessFirstVideoLoading());
    final response = await api.openNextVideo(id: id);
    response.fold(
          (l) => emit(StudyPageAccessFirstVideoError()),
          (r) => emit(StudyPageAccessFirstVideoLoaded()),
    );
  }

}
