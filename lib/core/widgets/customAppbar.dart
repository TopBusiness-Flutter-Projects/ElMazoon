import 'package:elmazoon/core/utils/assets_manager.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatefulWidget {
  final Widget widget;
  const CustomAppBar({Key? key, required this.widget}) : super(key: key);

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    return
      Container(
        decoration: BoxDecoration(image: DecorationImage(image: Image.asset(ImageAssets.appBarImage).image,
        fit: BoxFit.cover)),
        child: widget.widget,
      );
  }

}
