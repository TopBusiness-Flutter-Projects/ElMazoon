import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:elmazoon/core/utils/app_colors.dart';
import 'package:elmazoon/core/widgets/my_svg_widget.dart';
import 'package:flutter/material.dart';

import '../../../core/utils/assets_manager.dart';


class NavigatorBar extends StatefulWidget {
  const NavigatorBar({Key? key})
      : super(key: key);
  // final LoginDataModel loginDataModel;

  @override
  State<NavigatorBar> createState() => _NavigatorBarState();
}

class _NavigatorBarState extends State<NavigatorBar> {
  int _page = 2;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      // drawer: DrawerWidget(
      //   closeDrawer: () => _scaffoldKey.currentState!.closeDrawer(),
      //   loginDataModel: widget.loginDataModel,
      // ),
      bottomNavigationBar: CurvedNavigationBar(
        key: _bottomNavigationKey,
        index: 2,
        height: 60.0,
        items: [
          _page != 0
              ?  MySvgWidget(path: ImageAssets.openBookIcon, size: 15,imageColor: AppColors.white,)
              :  MySvgWidget(path: ImageAssets.openBookIcon, size: 25,imageColor: AppColors.primary,),
          _page != 1
              ?  SizedBox(width:30,height:30,child: MySvgWidget(path: ImageAssets.booksIcon, size: 15,imageColor: AppColors.white,))
              :  SizedBox(width:40,height:40,child: MySvgWidget(path: ImageAssets.booksIcon, size: 25,imageColor: AppColors.primary,)),
          _page != 2
              ?  MySvgWidget(path: ImageAssets.homeIcon, size: 30,imageColor: AppColors.white,)
              :  MySvgWidget(path: ImageAssets.homeIcon, size: 40,imageColor: AppColors.primary,),
          _page != 3
              ?  MySvgWidget(path: ImageAssets.notificationIcon, size: 30,imageColor: AppColors.white,)
              :  MySvgWidget(path: ImageAssets.notificationIcon, size: 40,imageColor: AppColors.primary,),
          _page != 4
              ?  MySvgWidget(path: ImageAssets.moreIcon, size: 30,imageColor: AppColors.white,)
              :  MySvgWidget(path: ImageAssets.moreIcon, size: 40,imageColor: AppColors.primary,),
        ],
        color: AppColors.secondPrimary,
        buttonBackgroundColor: AppColors.secondPrimary,
        backgroundColor: AppColors.transparent,
        animationCurve: Curves.linear,
        animationDuration: const Duration(milliseconds: 100),
        onTap: (index) {
          print(index);

        },
        letIndexChange: (index) {
          setState(() {
            _page = index;
          });
          return false;
        },
      ),
      body: SafeArea(
        child: pages(),
      ),
    );
  }

  Widget pages() {
    if (_page == 0) {
      return Container(color: Colors.orange,);
    } else if (_page == 1) {
      return Container(color: Colors.red,);
    } else if (_page == 2) {
      return Container(color: Colors.green,);
    } else if (_page == 3) {
      return Container(color: Colors.blue,);
    } else {
      return Container(color: Colors.teal,);
    }
  }
}
