import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:elmazoon/core/utils/app_colors.dart';
import 'package:elmazoon/core/widgets/my_svg_widget.dart';
import 'package:elmazoon/feature/mainscreens/profilePage/presentation/pages/profile_page.dart';
import 'package:flutter/material.dart';

import '../../../core/utils/assets_manager.dart';
import '../../../core/widgets/customAppbar.dart';

class NavigatorBar extends StatefulWidget {
  const NavigatorBar({Key? key}) : super(key: key);

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
      appBar: AppBar(
        toolbarHeight: 80,
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
          child: appbar(),
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(ImageAssets.appBarImage),
              fit: BoxFit.fill,
            ),
          ),
        ),
      ),
      key: _scaffoldKey,
      bottomNavigationBar: CurvedNavigationBar(
        key: _bottomNavigationKey,
        index: 2,
        height: 60.0,
        items: [
          _page != 0
              ? MySvgWidget(
                  path: ImageAssets.openBookIcon,
                  size: 25,
                  imageColor: AppColors.white,
                )
              : MySvgWidget(
                  path: ImageAssets.openBookIcon,
                  size: 40,
                  imageColor: AppColors.primary,
                ),
          _page != 1
              ? MySvgWidget(
                  path: ImageAssets.booksIcon,
                  size: 25,
                  imageColor: AppColors.white,
                )
              : MySvgWidget(
                  path: ImageAssets.booksIcon,
                  size: 40,
                  imageColor: AppColors.primary,
                ),
          _page != 2
              ? MySvgWidget(
                  path: ImageAssets.homeIcon,
                  size: 25,
                  imageColor: AppColors.white,
                )
              : MySvgWidget(
                  path: ImageAssets.homeIcon,
                  size: 40,
                  imageColor: AppColors.primary,
                ),
          _page != 3
              ? MySvgWidget(
                  path: ImageAssets.notificationIcon,
                  size: 25,
                  imageColor: AppColors.white,
                )
              : MySvgWidget(
                  path: ImageAssets.notificationIcon,
                  size: 40,
                  imageColor: AppColors.primary,
                ),
          _page != 4
              ? MySvgWidget(
                  path: ImageAssets.moreIcon,
                  size: 25,
                  imageColor: AppColors.white,
                )
              : MySvgWidget(
                  path: ImageAssets.moreIcon,
                  size: 40,
                  imageColor: AppColors.primary,
                ),
        ],
        color: AppColors.secondPrimary,
        buttonBackgroundColor: AppColors.secondPrimary,
        backgroundColor: AppColors.transparent,
        animationCurve: Curves.linear,
        animationDuration: const Duration(milliseconds: 100),
        onTap: (index) {
          setState(() {
            _page = index;
          });
        },
        letIndexChange: (index) => true,
      ),
      body: SafeArea(
        child: pages(),
      ),
    );
  }

  Widget pages() {
    if (_page == 0) {
      return Container(
        color: Colors.orange,
      );
    } else if (_page == 1) {
      return Container(
        color: Colors.red,
      );
    } else if (_page == 2) {
      return Container(
        color: Colors.green,
      );
    } else if (_page == 3) {
      return Container(
        color: Colors.blue,
      );
    } else {
      return const ProfilePage();
    }
  }

  Widget appbar() {
    if (_page == 0) {
      return Column(
        children: [
          Text(
            'ذاكر',
            style: TextStyle(
              color: AppColors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            'محاضرات وامتحانات',
            style: TextStyle(
              color: AppColors.primary,
              fontSize: 16,
            ),
          ),
        ],
      );
    } else if (_page == 1) {
      return Column(
        children: [
          Text(
            'استكشاف',
            style: TextStyle(
              color: AppColors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            'مصادر ومراجع',
            style: TextStyle(
              color: AppColors.primary,
              fontSize: 16,
            ),
          ),
        ],
      );
    } else if (_page == 2) {
      return Column(
        children: [
          Text(
            'ذاكر',
            style: TextStyle(
              color: AppColors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            'محاضرات وامتحانات',
            style: TextStyle(
              color: AppColors.primary,
              fontSize: 16,
            ),
          ),
        ],
      );
    } else if (_page == 3) {
      return Column(
        children: [
          Text(
            'ذاكر',
            style: TextStyle(
              color: AppColors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            'محاضرات وامتحانات',
            style: TextStyle(
              color: AppColors.primary,
              fontSize: 16,
            ),
          ),
        ],
      );
    } else {
      return const CustomAppBar();
    }
  }
}
