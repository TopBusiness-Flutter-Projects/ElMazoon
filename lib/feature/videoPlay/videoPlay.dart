import 'dart:io';

import 'package:elmazoon/core/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_player/video_player.dart';

class VideoPlay extends StatefulWidget {
  final String videopath;

  VideoPlay({Key? key, required this.videopath}) : super(key: key);

  @override
  State<VideoPlay> createState() => _VideoPlayState();
}

class _VideoPlayState extends State<VideoPlay> {
  VideoPlayerController? _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.file(File(""));

    getvideo();
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print("ddddee");
    print(widget.videopath);
    return Scaffold(
      backgroundColor: AppColors.white,
        body: Center(
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: <Widget>[
          VideoPlayer(_controller!),
          Positioned(
            top: 0,
            bottom: 0,
            right: 0,
            left: 0,
            child: Center(
                child: InkWell(
              onTap: () {
                if (_controller!.value.isPlaying) {
                  _controller!.pause();
                } else {
                  _controller!.play();
                }
              },
              child: Icon(
                _controller!.value.isPlaying ? Icons.pause : Icons.play_arrow,
                color: AppColors.secondPrimary,
                size: 60,
              ),
            )),
          ),
        ],
      ),
    ));
  }

  void getvideo() async {
    var dir = await (Platform.isIOS
        ? getApplicationSupportDirectory()
        : getApplicationDocumentsDirectory());
    Directory directory = Directory(dir.path +
        "/videos/" +
        widget.videopath
            .split("/")[widget.videopath.split("/").length - 1]
            .replaceAll("'", ""));
    print("ddfkfkfk");
    print(directory);
    _controller = VideoPlayerController.file(File(directory.path))
      ..addListener(() => setState(() {}))
      ..initialize().then((_) {
        setState(() {});
      });
  }
}
