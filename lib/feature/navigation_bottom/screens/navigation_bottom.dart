import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:elmazoon/app.dart';
import 'package:elmazoon/core/utils/app_colors.dart';
import 'package:elmazoon/core/widgets/my_svg_widget.dart';
import 'package:elmazoon/feature/mainscreens/profilePage/screens/profile_page.dart';
import 'package:elmazoon/feature/navigation_bottom/cubit/navigation_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/preferences/preferences.dart';
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
        toolbarHeight:_page!=2? 90:0,
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
          MySvgWidget(
            path: ImageAssets.openBookIcon,
            size: _page != 0 ? 25 : 40,
            imageColor: _page != 0 ? AppColors.white : AppColors.primary,
          ),
          MySvgWidget(
            path: ImageAssets.booksIcon,
            size: _page != 1 ? 25 : 40,
            imageColor: _page != 1 ? AppColors.white : AppColors.primary,
          ),
          MySvgWidget(
            path: ImageAssets.homeIcon,
            size: _page != 2 ? 25 : 40,
            imageColor: _page != 2 ? AppColors.white : AppColors.primary,
          ),
          MySvgWidget(
            path: ImageAssets.notificationIcon,
            size: _page != 3 ? 25 : 40,
            imageColor: _page != 3 ? AppColors.white : AppColors.primary,
          ),
          MySvgWidget(
            path: ImageAssets.moreIcon,
            size: _page != 4 ? 25 : 40,
            imageColor: _page != 4 ? AppColors.white : AppColors.primary,
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
      return SizedBox();
      // return BlocBuilder<NavigationCubit, NavigationState>(
      //   builder: (context, state) {
      //     return Column(
      //       crossAxisAlignment: CrossAxisAlignment.center,
      //       mainAxisAlignment: MainAxisAlignment.center,
      //       children: [
      //         Row(
      //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //           children: [
      //             Row(
      //               children: [
      //                 Text(
      //                   'hello'.tr(),
      //                   style: TextStyle(
      //                     fontSize: 18,
      //                     color: AppColors.white,
      //                   ),
      //                 ),
      //                 SizedBox(width: 8),
      //                 Text(
      //                   context.read<NavigationCubit>().userModel != null
      //                       ? context
      //                           .read<NavigationCubit>()
      //                           .userModel!
      //                           .data!
      //                           .name
      //                       : '',
      //                   style: TextStyle(
      //                     fontSize: 22,
      //                     fontWeight: FontWeight.bold,
      //                     color: AppColors.primary,
      //                   ),
      //                 ),
      //               ],
      //             ),
      //             InkWell(
      //               onTap: () {
      //                 // setState(() {
      //                 //   //15860B
      //                 //   //00B3DC
      //                 //   Preferences.instance.setPrimaryColor('#00B3DC').then(
      //                 //     (value) {
      //                 //       return AppColors.getPrimaryColor();
      //                 //     },
      //                 //   ).then(
      //                 //     (value) {
      //                 //       _bottomNavigationKey.currentState!.setState(() {
      //                 //         _page = 2;
      //                 //       });
      //                 //     },
      //                 //   );
      //                 // });
      //               },
      //               child: Text(
      //                 monthSeason(),
      //                 style: TextStyle(fontSize: 14),
      //               ),
      //             )
      //           ],
      //         ),
      //         SizedBox(
      //           width: MediaQuery.of(context).size.width,
      //           child: Text(
      //             'home_page'.tr(),
      //             textAlign: TextAlign.center,
      //             style: TextStyle(
      //               color: AppColors.white,
      //               fontSize: 20,
      //               fontWeight: FontWeight.bold,
      //             ),
      //           ),
      //         ),
      //       ],
      //     );
      //   },
      // );
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

  String monthSeason() {
    int nowMonth = DateTime.now().month;
    if (nowMonth >= DateTime.august) {
      return '${DateTime.now().year}/${DateTime.now().year + 1}';
    } else {
      return '${DateTime.now().year - 1}/${DateTime.now().year}';
    }
  }
}
