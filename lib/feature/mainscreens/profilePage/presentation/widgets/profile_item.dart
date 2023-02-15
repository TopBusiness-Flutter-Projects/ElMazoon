import 'package:flutter/material.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/assets_manager.dart';
import '../../../../../core/widgets/my_svg_widget.dart';

class ProfileItemWidget extends StatelessWidget {
  final String image;
  final String title;
  final String subTitle;

  const ProfileItemWidget(
      {Key? key,
      required this.image,
      required this.title,
      required this.subTitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Row(
        children: [
          MySvgWidget(
            path:image,
            size: 25,
            imageColor: AppColors.primary,
          ),
          const SizedBox(width: 10,),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              Text(title,style: TextStyle(color: AppColors.gray1,fontWeight:FontWeight.bold,fontSize: 16),),
            const SizedBox(height: 3,),
              Text(subTitle,style: TextStyle(color: AppColors.gray1,fontWeight:FontWeight.normal,fontSize: 15),)
            ],),
          )
        ],
      ),
    );
  }
}
