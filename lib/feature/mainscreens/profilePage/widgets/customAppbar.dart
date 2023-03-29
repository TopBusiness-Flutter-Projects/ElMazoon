import 'package:easy_localization/easy_localization.dart';
import 'package:elmazoon/core/utils/assets_manager.dart';
import 'package:elmazoon/feature/navigation_bottom/cubit/navigation_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/restart_app_class.dart';
import '../../../../../core/widgets/my_svg_widget.dart';
import '../../../../core/widgets/network_image.dart';
import '../../../navigation_bottom/screens/navigation_bottom.dart';
import '../screens/profile_page_deatils.dart';

class CustomAppBar extends StatefulWidget {
  const CustomAppBar({Key? key}) : super(key: key);

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    String lang = EasyLocalization.of(context)!.locale.languageCode;
    return BlocBuilder<NavigationCubit, NavigationState>(
      builder: (context, state) {
        NavigationCubit cubit = context.read<NavigationCubit>();
        // if(state is NavigationGetUserLoading){}
        if (cubit.userModel == null) {
          return Center(
            child: Text(
              'no_user'.tr(),
            ),
          );
        }
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 15),
          child: Row(
            children: [
              ManageNetworkImage(
                imageUrl: cubit.userModel!.data!.image,
                width: 50,
                height: 50,
              ),
              SizedBox(width: 15),
              Expanded(
                child: Column(
                  children: [
                    Align(
                      alignment:
                          lang == 'ar' ? Alignment.topRight : Alignment.topLeft,
                      child: Text(
                        cubit.userModel!.data!.name,
                        style: TextStyle(
                            color: AppColors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              cubit.userModel!.data!.code,
                              style: TextStyle(
                                color: AppColors.white,
                                fontSize: 13,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                            SizedBox(width: 15),
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: AppColors.primary,
                                  shape: BoxShape.rectangle,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Text(
                                    lang == 'ar'
                                        ? cubit.userModel!.data!.season.nameAr
                                        : cubit.userModel!.data!.season.nameEn,
                                    style: TextStyle(
                                        color: AppColors.white,
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: AppColors.primary,
                                  shape: BoxShape.rectangle,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Text(
                                    lang == 'ar'
                                        ? cubit.userModel!.data!.term.nameAr
                                        : cubit.userModel!.data!.term.nameEn,
                                    style: TextStyle(
                                        color: AppColors.white,
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 15),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    PageTransition(
                      type: lang == 'ar'
                          ? PageTransitionType.leftToRight
                          : PageTransitionType.rightToLeft,
                      alignment: lang == 'ar'
                          ? Alignment.centerLeft
                          : Alignment.centerRight,
                      duration: const Duration(milliseconds: 700),
                      child: ProfilePageDetails(),
                      childCurrent: NavigatorBar(),
                    ),
                  );
                },
                child: MySvgWidget(
                  path: ImageAssets.settingIcon,
                  size: 30,
                  imageColor: AppColors.white,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
