import 'package:elmazoon/core/utils/assets_manager.dart';
import 'package:flutter/material.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/widgets/my_svg_widget.dart';

class CustomAppBar extends StatefulWidget {
  const CustomAppBar({Key? key}) : super(key: key);

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
      const EdgeInsets.symmetric(horizontal: 8.0, vertical: 15),
      child:
      Row(
        children: [
          Image.asset(
            ImageAssets.userImage,
            width: 50,
            height: 50,
          ),
          SizedBox(width: 7,),
          Column(children: [
            Text('name',style: TextStyle(color: AppColors.white,fontSize: 13,fontWeight: FontWeight.bold),),
            SizedBox(height: 5,),
            Text('code',style: TextStyle(color: AppColors.white,fontSize: 13,fontWeight: FontWeight.normal),),

          ],),
          SizedBox(width: 30,),
          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Align(alignment: Alignment.bottomCenter,
              child: Container(
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
                    color: AppColors.primary,
                    shape: BoxShape.rectangle
                ),
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Text('name',style: TextStyle(color: AppColors.white,fontSize: 13,fontWeight: FontWeight.bold),),
                ),
              ),
            ),
          ),
          Expanded(child: Container()),
          Center( child: MySvgWidget(
            path: ImageAssets.settingIcon,
            size: 40,
            imageColor: AppColors.white,
          ))
        ],
      ),
    );
  }

}
