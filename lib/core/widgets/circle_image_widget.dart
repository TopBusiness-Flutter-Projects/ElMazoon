import 'package:flutter/material.dart';

import '../utils/assets_manager.dart';

class CircleImageWidget extends StatelessWidget {
  const CircleImageWidget({Key? key, required this.myWidget, this.isUp = false})
      : super(key: key);

  final Widget myWidget;
  final bool? isUp;

  @override
  Widget build(BuildContext context) {
    return isUp! ? Stack(
      children: [
        myWidget,
        Positioned(
          top: -100,
          right: -105,
          child: Image.asset(
            width: 263,
            height:289,
            ImageAssets.twoCircleImage,


          ),
        ),
      ],
    ):Stack(
      children: [
        Positioned(

          right: -40,
          top: 0,
          child: Image.asset(
            ImageAssets.twoCircleImage,
              width: 263,
             height:200

          ),
        ),
        myWidget
      ],
    );
  }
}
