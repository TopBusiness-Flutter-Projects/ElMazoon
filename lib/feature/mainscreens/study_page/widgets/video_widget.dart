import 'package:chewie/chewie.dart';
import 'package:elmazoon/core/utils/app_colors.dart';
import 'package:elmazoon/feature/mainscreens/study_page/cubit/study_page_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_player/video_player.dart';

class VideoWidget extends StatefulWidget {
  const VideoWidget({Key? key, required this.videoLink, required this.videoId}) : super(key: key);
  final String videoLink;
  final int videoId;

  @override
  State<VideoWidget> createState() => _VideoWidgetState();
}

class _VideoWidgetState extends State<VideoWidget> {
  late VideoPlayerController _videoPlayerController;
  ChewieController? _chewieController;

  void checkVideo() {
    if (_videoPlayerController.value.position ==
        Duration(seconds: 0, minutes: 0, hours: 0)) {
      print('video Started');
    }
    if (_videoPlayerController.value.position ==
        _videoPlayerController.value.duration) {
      // context.read<StudyPageCubit>().accessNextVideo(widget.videoId);
      print('video Ended');
    }
  }

  @override
  void initState() {
    super.initState();
    initializePlayer();
  }

  Future<void> initializePlayer() async {
    _videoPlayerController = VideoPlayerController.network(widget.videoLink);
    _videoPlayerController.addListener(
      () {
        checkVideo();
      },
    );
    await Future.wait([_videoPlayerController.initialize()]);
    _createChewieController();
    setState(() {});
  }

  void _createChewieController() {
    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController,
      autoPlay: false,
      controlsSafeAreaMinimum: EdgeInsets.zero,
      looping: false,
      hideControlsTimer: const Duration(seconds: 3),

    );
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _chewieController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 4,
      width: double.infinity,
      child: _chewieController != null &&
              _chewieController!.videoPlayerController.value.isInitialized
          ?
      Stack(
          children: [

      Positioned(
        bottom: 0,
        right: 0,
        left: 0,
      top: 0,
      child: Chewie(controller: _chewieController!))
            ,
            Positioned(
                top: 0,
                right: 0,
                left: 0,
                child:
            InkWell(
                onTap: () {
                  context.read<StudyPageCubit>().getPermission(widget.videoLink);
                },
                child: Icon(Icons.download,color: AppColors.white,))
            )
      ])

          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const [
                CircularProgressIndicator(),
              ],
            ),
    );
  }
}
