import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:path_provider/path_provider.dart';

part 'downloads_videos_state.dart';

class DownloadsVideosCubit extends Cubit<DownloadsVideosState> {
  List<FileSystemEntity> files=[];

  DownloadsVideosCubit() : super(DownloadsVideosInitial()){
    getVideos();
  }

  void getVideos() async{
    var dir = await (Platform.isIOS
        ? getApplicationSupportDirectory()
        : getApplicationDocumentsDirectory());
    Directory directory=Directory(dir.path+"/videos/");
    files = directory.listSync().toList();
    print("object");
    print(files.length);
   emit(DownloadsVideosList(files));
  }
}
