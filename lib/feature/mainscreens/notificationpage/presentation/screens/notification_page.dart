import 'package:elmazoon/core/utils/app_colors.dart';
import 'package:elmazoon/feature/mainscreens/notificationpage/presentation/screens/widget/notification_details_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/widgets/no_data_widget.dart';
import '../../../../../core/widgets/show_loading_indicator.dart';
import '../../cubit/notification_cubit.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    NotificationCubit cubit=context.read<NotificationCubit>();

    return  Scaffold(
      body: BlocBuilder<NotificationCubit, NotificationState>(
        builder: (context, state) {
          if (state is NotificationPageError) {
            return NoDataWidget(onclick: () => cubit.getAllNotification(),title: 'no_date',);
          }
          return state is NotificationPageLoading
              ? ShowLoadingIndicator()
              : RefreshIndicator(
                onRefresh: () async{
                  cubit.getAllNotification();
                },
            color: AppColors.primary,
            backgroundColor: AppColors.secondPrimary,
                child: ListView(
            children: [
                ...List.generate(
                  cubit.data!=null?cubit.data!.length:0,
                      (index) => InkWell(

                    child:
                    NotificationDetailsWidget(
                      notificationModel: cubit.data!.elementAt(index),

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
