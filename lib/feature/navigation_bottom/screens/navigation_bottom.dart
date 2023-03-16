import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:elmazoon/core/utils/app_colors.dart';
import 'package:elmazoon/core/widgets/my_svg_widget.dart';
import 'package:elmazoon/feature/mainscreens/profilePage/screens/profile_page.dart';
import 'package:elmazoon/feature/navigation_bottom/cubit/navigation_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/utils/assets_manager.dart';
import '../../mainscreens/guide_page/screens/guide_page.dart';
import '../../mainscreens/homePage/screens/home_page.dart';
import '../../mainscreens/notificationpage/presentation/screens/notification_page.dart';
import '../../mainscreens/profilePage/widgets/customAppbar.dart';
import '../../mainscreens/study_page/screens/study_page.dart';

class NavigatorBar extends StatefulWidget {
  const NavigatorBar({Key? key}) : super(key: key);

  // final userDataModel userDataModel;

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
        toolbarHeight: 90,
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
      return const StudyPage();
    } else if (_page == 1) {
      return GuidePage();
    } else if (_page == 2) {
      return HomePage();
    } else if (_page == 3) {
      return NotificationScreen();
    } else {
      return const ProfilePage();
    }
  }

  Widget appbar() {
    if (_page == 0) {
      return Column(
        children: [
          Text(
            'study'.tr(),
            style: TextStyle(
              color: AppColors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            'lecture_exam'.tr(),
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
            'guide'.tr(),
            style: TextStyle(
              color: AppColors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            'sources_references'.tr(),
            style: TextStyle(
              color: AppColors.primary,
              fontSize: 16,
            ),
          ),
        ],
      );
    } else if (_page == 2) {
      return BlocBuilder<NavigationCubit, NavigationState>(
  builder: (context, state) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              Text(
                'hello'.tr(),
                style: TextStyle(
                  fontSize: 18,
                  color: AppColors.white,
                ),
              ),
              SizedBox(width: 8),
              Text(
                context.read<NavigationCubit>().userModel != null
                    ? context.read<NavigationCubit>().userModel!.data!.name
                    : '',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Text(
              'home_page'.tr(),
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      );
  },
);
    } else if (_page == 3) {
      return Column(
        children: [
          Text(
            'notification'.tr(),
            style: TextStyle(
              color: AppColors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            'important_notification'.tr(),
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
