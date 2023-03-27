import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:elmazoon/core/preferences/preferences.dart';
import 'package:meta/meta.dart';
import 'package:path_provider/path_provider.dart';

import '../models/save_video_model.dart';

part 'downloads_videos_state.dart';

class DownloadsVideosCubit extends Cubit<DownloadsVideosState> {
  List<FileSystemEntity> files = [];

  DownloadsVideosCubit() : super(DownloadsVideosInitial()) {
    getSavedVideosInShared().whenComplete(() => getVideos());
  }

  List<SaveVideoModel> savedList = [];

  void getVideos() async {
    emit(DownloadsVideosLoading());
    try {
      var dir = await (Platform.isIOS
          ? getApplicationSupportDirectory()
          : getApplicationDocumentsDirectory());
      Directory directory = Directory(dir.path + "/videos/");
      if (directory.existsSync()) {
        files = directory.listSync().toList();
        print(files.first.path);
      } else {
        files = [];
      }
      print("object");
      print(files.length);
      emit(DownloadsVideosList(files));
    } catch (e) {
      print(e);
      emit(DownloadsVideosError());
    }
  }

  Future<void> getSavedVideosInShared() async {
    emit(DownloadsVideosLoading());
    SaveVideoModelList saveVideoModelList =
        await Preferences.instance.getSavedDownloadVideos();
    savedList = saveVideoModelList.savedList;
  }
}
