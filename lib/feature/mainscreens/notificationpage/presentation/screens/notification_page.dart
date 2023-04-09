import 'package:easy_localization/easy_localization.dart';
import 'package:elmazoon/core/utils/app_colors.dart';
import 'package:elmazoon/feature/mainscreens/notificationpage/presentation/screens/widget/notification_details_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/assets_manager.dart';
import '../../../../../core/widgets/no_data_widget.dart';
import '../../../../../core/widgets/painting.dart';
import '../../../../../core/widgets/show_loading_indicator.dart';
import '../../cubit/notification_cubit.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    NotificationCubit cubit = context.read<NotificationCubit>();

    return Scaffold(
      body: BlocBuilder<NotificationCubit, NotificationState>(
        builder: (context, state) {
          if (state is NotificationPageError) {
            return NoDataWidget(
              onclick: () => cubit.getAllNotification(),
              title: 'no_date',
            );
          }
          return state is NotificationPageLoading
              ? ShowLoadingIndicator()
              : RefreshIndicator(
                  onRefresh: () async {
                    cubit.getAllNotification();
                  },
                  color: AppColors.primary,
                  backgroundColor: AppColors.secondPrimary,
                  child: Stack(
                    children: [
                      ListView(
                        children: [
                          ...List.generate(
                            cubit.data != null ? cubit.data!.length : 0,
                            (index) => InkWell(
                              child: NotificationDetailsWidget(
                                notificationModel: cubit.data!.elementAt(index),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Positioned(
                        top: 0,
                        right: 0,
                        left: 0,
                        child: CustomPaint(
                          size: Size(
                            MediaQuery.of(context).size.width,
                            (MediaQuery.of(context).size.width *
                                0.38676844783715014)
                                .toDouble(),
                          ),
                          painter: RPSCustomPainter(),

                          child: Container(
                            // decoration:  BoxDecoration(
                            //   image: DecorationImage(
                            //     image: AssetImage(ImageAssets.appBarImage),
                            //     fit: BoxFit.fill,
                            //   ),
                            // ),
                            height: 120,

                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
                              child: Column(
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
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
        },
      ),
    );
  }
}
