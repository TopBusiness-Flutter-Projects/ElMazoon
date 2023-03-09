import 'package:flutter/material.dart';

import '../utils/assets_manager.dart';

PreferredSizeWidget CustomAppBarWidget({required String appBarTitle,}){
  return AppBar(
    toolbarHeight: 80,
    title: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
      child: Text(appBarTitle),
    ),
    flexibleSpace: Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(ImageAssets.appBarImage),
          fit: BoxFit.fill,
        ),
      ),
    ),
  );
}