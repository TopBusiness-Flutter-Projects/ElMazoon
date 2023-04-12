import 'package:elmazoon/core/preferences/preferences.dart';
import 'package:flutter/material.dart';

import 'hex_color.dart';

class AppColors {
  static Color primary = HexColor('#00B3DC');
  static Color secondPrimary = HexColor('#4455D7');
  static Color orangeThirdPrimary = HexColor('#FF9201');
  static final AppColors instance = AppColors._internal();

  AppColors._internal();

  factory AppColors() => instance;

  static Color scaffoldBackground = HexColor('#FDF5E8');
  static Color buttonBackground = HexColor('#594339');
  static Color textBackground = HexColor('#92603F');
  static Color onBoardingColor = HexColor('#DC8068');
  static Color containerBackgroundColor = HexColor('#F7DFB1');
  static Color iconBackgroundColor = HexColor('#402D26');
  static Color gray1 = HexColor('#404040');
  static Color unselectedTab = HexColor('#D9D9D9');
  static Color commentBackground = HexColor('#F3F2F2');
  static Color paymentContainer = HexColor('#F0D3AB');
  static Color textFormFieldColor = HexColor('#EDEDED');
  static Color descriptionBoardingColor = HexColor('#777777');
  static Color bottomNavigatorColor = HexColor('#F3F4F9');

  //from home
  static Color unselectedTabColor = HexColor('#EEEEEE');

  static Color blueLikeColor = HexColor('#2e7dea');
  static Color redDislikeColor = HexColor('#ff2c2c');

  static Color green = HexColor('#15860B');
  static Color blueColor1 = HexColor('#6A85B6');
  static Color blueColor2 = HexColor('#BAC8E0');
  static Color blueColor3 = HexColor('#1877F2');
  static Color blueLiteColor1 = HexColor('#429993');
  static Color blueLiteColor2 = HexColor('#7CD4CC');

  static Color hint = Colors.grey;
  static Color blackLite = Colors.black54;
  static Color error = Colors.red;
  static Color success = Colors.green;
  static Color white = Colors.white;
  static Color black = Colors.black;
  static Color gray = Colors.grey;
  static Color grayLite = Colors.grey[700]!;
  static Color gray4 = HexColor('#C4C4C4');
  static Color opacityWhite = Colors.white.withOpacity(0.5);
  static Color transparent = Colors.transparent;

  static getPrimaryColor() {
    Preferences.instance
        .getPrimaryColor()
        .then((value) => {primary = HexColor(value)});
  }
}

Color darken(Color color, [double amount = .1]) {
  assert(amount >= 0 && amount <= 1);

  final hsl = HSLColor.fromColor(color);
  final hslDark = hsl.withLightness((hsl.lightness - amount).clamp(0.0, 1.0));

  return hslDark.toColor();
}

Color lighten(Color color, [double amount = .1]) {
  assert(amount >= 0 && amount <= 1);

  final hsl = HSLColor.fromColor(color);
  final hslLight = hsl.withLightness((hsl.lightness + amount).clamp(0.0, 1.0));

  return hslLight.toColor();
}
