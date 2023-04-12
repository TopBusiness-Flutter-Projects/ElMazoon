import 'package:elmazoon/core/utils/assets_manager.dart';
import 'package:flutter/material.dart';

import '../widgets/expansion_tile_widget.dart';

class ClassesExamsScreen extends StatelessWidget {
  const ClassesExamsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(ImageAssets.chooseClassMessageImage),
          fit: BoxFit.contain,
        ),
      ),
      child: Column(
        children: [
          SizedBox(height: 20),
          ExpansionTileWidget(title: 'اختر الفصل',)
        ],
      ),
    );
  }
}
