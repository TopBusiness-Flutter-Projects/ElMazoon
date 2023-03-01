import 'package:bloc/bloc.dart';
import 'package:elmazoon/core/models/user_model.dart';
import 'package:elmazoon/core/preferences/preferences.dart';
import 'package:flutter/cupertino.dart';

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

  late AllClassesDatum allClassesDatum;
  late LessonsDetailsModel lessonsDetailsModel;
  late Comments comments;
  late UserModel userModel;

  List<CommentDatum> commentsList = [];
  List<CommentDatum> tempCommentsList = [];
  String lan = 'en';

  bool isCommentFieldEnable = true;
  TextEditingController commentController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  getUserData() async {
    userModel = await Preferences.instance.getUserModel();
    lan = await Preferences.instance.getSavedLang();
    emit(StudyPageGetUserModel());
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
      comment: commentController.text,
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
}
