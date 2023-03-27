import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:elmazoon/core/models/user_model.dart';
import 'package:elmazoon/core/preferences/preferences.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../core/models/comments_model.dart';
import '../../../../core/models/lessons_details_model.dart';
import '../../../../core/remote/service.dart';
import '../../../downloads_videos/models/save_video_model.dart';
import '../models/all_classes_model.dart';

part 'study_page_state.dart';

class StudyPageCubit extends Cubit<StudyPageState> {
  StudyPageCubit(this.api) : super(StudyPageInitial()) {
    getAllClasses().whenComplete(() => getUserData());
  }

  final dio = Dio();

  final ServiceApi api;
  final formKey = GlobalKey<FormState>();
  final replyFormKey = GlobalKey<FormState>();

  AllClassesDatum? allClassesDatum;
  LessonsDetailsModel? lessonsDetailsModel;
  Comments? comments;
  UserModel? userModel;

  List<CommentDatum> commentsList = [];
  List<CommentDatum> tempCommentsList = [];

  TextEditingController commentController = TextEditingController();
  TextEditingController replyController = TextEditingController();
  TextEditingController updateCommentController = TextEditingController();
  TextEditingController updateReplyController = TextEditingController();

  XFile? imageFile;
  String imagePath = '';
  String audioPath = '';
  bool isCommentFieldEnable = true;
  bool isValidUpdate = true;
  bool isDownloaded = false;
  String lan = 'en';
  int index = 0;
  int percentage = 0;
  var dir;

  getSavedDownloadedPaths(String path) async {
    emit(SavedDownloadedPathsLoading());
    isDownloaded = await Preferences.instance.searchOnSavedDownloadPaths(path);
    print('################################  $isDownloaded');
    emit(SavedDownloadedPathsLoaded());
  }

  getUserData() async {
    userModel = await Preferences.instance.getUserModel();
    lan = await Preferences.instance.getSavedLang();
    emit(StudyPageGetUserModel());
  }

  changeValidUpdate(bool isValid) {
    isValidUpdate = isValid;
    emit(UpdateButtonValid());
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
    dir = await (Platform.isIOS
        ? getApplicationSupportDirectory()
        : getApplicationDocumentsDirectory());
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
        response.data.videos.forEach(
          (element) {
            element.downloadSavedPath =
                dir.path + "/videos/" + element.link!.split("/").toList().last;
          },
        );
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
    final response = await api.getMoreComments(comments!.links.next);
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

  updateCommentAndReply(int commentId, String type, int commentIndex) async {
    isCommentFieldEnable = false;
    emit(StudyPageUpdateCommentLoading());
    final response = await api.updateCommentAndReply(
      commentId,
      type,
      type == 'comment'
          ? updateCommentController.text
          : updateReplyController.text,
    );
    response.fold(
      (l) => emit(StudyPageUpdateCommentError()),
      (r) {
        type == 'comment'
            ? commentsList[commentIndex] = r.oneComment
            : commentsList[index].replies![commentIndex] = r.oneComment;
        isCommentFieldEnable = true;
        type == 'comment'
            ? updateCommentController.clear()
            : updateReplyController.clear();
        isValidUpdate = false;
        emit(StudyPageUpdateCommentLoaded());
        Future.delayed(Duration(milliseconds: 700), () {
          emit(StudyPageInitial());
        });
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

  Future<void> accessFirstVideo(int id, String type) async {
    emit(StudyPageAccessFirstVideoLoading());
    final response = await api.openFirstVideo(type: type, id: id);
    response.fold(
      (l) => emit(StudyPageAccessFirstVideoError()),
      (r) => emit(StudyPageAccessFirstVideoLoaded()),
    );
  }

  Future<void> accessNextVideo(int id, String type, context) async {
    emit(StudyPageAccessFirstVideoLoading());
    final response = await api.openNextVideo(id: id, type: type);
    response.fold(
      (l) => emit(StudyPageAccessFirstVideoError()),
      (res) {
        if (type == 'lesson') {
          Navigator.pop(context);
        }
        emit(StudyPageAccessFirstVideoLoaded());
      },
    );
  }

  deleteReply(int id, int commentIndex, int index) async {
    final response = await api.deleteReply(id);
    response.fold(
      (l) {
        emit(StudyPageDeleteReplyError());
        Future.delayed(Duration(milliseconds: 500), () {
          emit(StudyPageDeleteReplyLoading());
        });
      },
      (r) {
        if (r.code != 200) {
          emit(StudyPageDeleteReplyError());
          Future.delayed(Duration(milliseconds: 500), () {
            emit(StudyPageDeleteReplyLoading());
          });
        } else {
          commentsList[commentIndex].replies!.removeAt(index);
          emit(StudyPageDeleteReplyLoaded());
          Future.delayed(Duration(milliseconds: 500), () {
            emit(StudyPageDeleteReplyLoading());
          });
        }
      },
    );
  }

  deleteComment(int id, int index) async {
    final response = await api.deleteComment(id);
    response.fold(
      (l) {
        emit(StudyPageDeleteCommentError());
        Future.delayed(Duration(milliseconds: 500), () {
          emit(StudyPageDeleteCommentLoading());
        });
      },
      (r) {
        if (r.code != 200) {
          emit(StudyPageDeleteCommentError());
          Future.delayed(Duration(milliseconds: 500), () {
            emit(StudyPageDeleteCommentLoading());
          });
        } else {
          commentsList.removeAt(index);
          emit(StudyPageDeleteCommentLoaded());
          Future.delayed(Duration(milliseconds: 500), () {
            emit(StudyPageDeleteCommentLoading());
          });
        }
      },
    );
  }

  void getPermission(String video_url, String video_name) async {
    var status = await Permission.storage.status;
    if (status.isDenied) {
      var status1 = await Permission.storage.request();
      if (status1.isGranted) {
        downloadVideo(video_url, video_name);
      }
      ;
      // We didn't ask for permission yet or the permission has been denied before but not permanently.
    } else {
      downloadVideo(video_url, video_name);
    }
  }

  downloadVideo(String video_url, String video_name) async {
    var dir = await (Platform.isIOS
        ? getApplicationSupportDirectory()
        : getApplicationDocumentsDirectory());
    await dio.download(
      video_url,
      dir.path + "/videos/" + video_url.split("/").toList().last,
      onReceiveProgress: (count, total) {
        percentage = ((count / total) * 100).floor();
        emit(DownloadVideoPercentage());
        print(percentage);
      },
    ).whenComplete(
      () {
        Preferences.instance.saveDownloadVideos(
          SaveVideoModel(
            videoName: video_name,
            videoPath:
                dir.path + "/videos/" + video_url.split("/").toList().last,
          ),
        ).whenComplete(() => print('Doooooooooooooooooooooooooooooone'));

        Preferences.instance
            .saveDownloadPaths(
          dir.path + "/videos/" + video_url.split("/").toList().last,
        )
            .whenComplete(() {
          getSavedDownloadedPaths(
            dir.path + "/videos/" + video_url.split("/").toList().last,
          );
          percentage = 0;
          emit(DownloadVideoPercentage());
        });
      },
    );
  }
}
