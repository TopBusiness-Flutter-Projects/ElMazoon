import 'package:elmazoon/core/utils/assets_manager.dart';
import 'package:flutter/material.dart';

import '../../../core/utils/hex_color.dart';
import '../widgets/item_final_review_widget.dart';

class FinalReviewScreen extends StatelessWidget {
  FinalReviewScreen({Key? key}) : super(key: key);

  List<String> classNumber = [
    'الفصل الاول',
    'الفصل الثانى',
    'الفصل الثالث',
    'الفصل الرابع'
  ];
  List<Color> mainColors = [
    HexColor('#48B8E0'),
    HexColor('#E4312A'),
    HexColor('#009541'),
    HexColor('#F4BC35'),
  ];
  List<String> imagesPath = [
   ImageAssets.Image1,
   ImageAssets.Image2,
   ImageAssets.Image3,
   ImageAssets.Image4,
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15.0,right: 15,bottom: 15,top: 35),
      child: GridView.builder(
        // physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: 1,
          mainAxisSpacing: 15,
          crossAxisSpacing: 20,
          crossAxisCount: 2,
        ),
        itemCount: classNumber.length,
        itemBuilder: (BuildContext context, int index) {
          return ItemOfFinalReviewWidget(
            classNum: classNumber[index],
            imagePath: imagesPath[index],
            mainColor: mainColors[index],
          );
        },
      ),
    );
  }
}
