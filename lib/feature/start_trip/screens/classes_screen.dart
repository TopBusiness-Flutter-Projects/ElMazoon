import 'package:calendar_view/calendar_view.dart';
import 'package:elmazoon/core/utils/app_colors.dart';
import 'package:elmazoon/core/utils/hex_color.dart';
import 'package:elmazoon/core/widgets/network_image.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../widgets/item_one_class_widget.dart';

class ClassesScreen extends StatelessWidget {
   ClassesScreen({Key? key}) : super(key: key);

  List<String> classNumber = ['الفصل الاول','الفصل الثانى','الفصل الثالث'];
  List<String> classTitle = ['عنوان 1','عنوان 2','عنوان 3'];
  List<String> classPresents = ['50','20','0'];
  List<String> lessonsNumbers = ['3','2','4'];
  List<String> videoNumbers = ['5','2','5'];
  List<String> hourNumbers = ['2','1','3'];
  List<Color> mainColors = [HexColor('#48B8E0'),HexColor('#E4312A'),HexColor('#009541'),];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GridView.builder(
        // physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: .87,
          mainAxisSpacing: 15,
          crossAxisSpacing: 20,
          crossAxisCount: 2,
        ),
        itemCount: classNumber.length,
        itemBuilder: (BuildContext context, int index) {

          return ItemOfOneClassWidget(
            classNum: classNumber[index],
            classTitle: classTitle[index],
            classPresentFinished: classPresents[index],
            lessonNum: lessonsNumbers[index],
            videoNum: videoNumbers[index],
            hourNum: hourNumbers[index],
            mainColor: mainColors[index],
            imagePath: 'https://elmazone.topbusiness.io/classes/1.png',
          );
        },
      ),
    );
  }
}
