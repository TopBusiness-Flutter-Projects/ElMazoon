import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../core/utils/app_colors.dart';
import '../core/widgets/audio_recorder_widget.dart';
import 'aduio_player.dart';

// void main() => runApp(const MyApp());

class RecordWidget extends StatefulWidget {
  const RecordWidget({Key? key}) : super(key: key);

  @override
  State<RecordWidget> createState() => _RecordWidgetState();
}

class _RecordWidgetState extends State<RecordWidget> {
  bool showPlayer = false;
  String? audioPath;

  @override
  void initState() {
    showPlayer = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(height: 25),
        showPlayer
            ? Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: AudioPlayer(
                  source: audioPath!,
                  onDelete: () {
                    setState(() => showPlayer = false);
                  },
                ),
              )
            : AudioRecorder(
                onStop: (path) {
                  if (kDebugMode) print('Recorded file path: $path');
                  setState(() {
                    audioPath = path;
                    showPlayer = true;
                  });
                },
              ),

        SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 6),
          child: Row(
            children: [
              showPlayer? TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Send'),
              ):SizedBox(width: 12),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Cancel'),
              ),

            ],
          ),
        )

      ],
    );
  }
}
