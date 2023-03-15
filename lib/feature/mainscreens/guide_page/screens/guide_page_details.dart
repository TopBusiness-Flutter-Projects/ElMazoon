import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/models/guide_model.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/assets_manager.dart';
import '../../study_page/screens/all_lecture/pdf_screen.dart';
import '../../study_page/widgets/structure_details_widget.dart';

class GuidePageDetails extends StatelessWidget {
  const GuidePageDetails({Key? key, required this.innerItems}) : super(key: key);

  final   List<InnerItem> innerItems;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'important_ques'.tr(),
                style: TextStyle(
                  color: AppColors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'important_ques_desc'.tr(),
                style: TextStyle(
                  color: AppColors.primary,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
        flexibleSpace: Container(
          decoration:  BoxDecoration(
            image: DecorationImage(
              image: AssetImage(ImageAssets.appBarImage),
              fit: BoxFit.fill,
            ),
          ),
        ),
      ),
      body:ListView(
        children: [
          ...List.generate(
            innerItems.length,
                (index) => InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PdfScreen(
                      pdfLink: innerItems[index].filePath!,
                      pdfTitle:innerItems[index].title!,
                    ),
                  ),
                );
              },
              child: StructureDetailsWidget(
                title: innerItems[index].title!,
                titleIcon: Icons.picture_as_pdf,
                color1:  AppColors.blueLiteColor1,
                color2:AppColors.blueLiteColor2,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
