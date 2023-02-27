import 'package:elmazoon/feature/mainscreens/notificationpage/presentation/screens/widget/notification_details_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
          return state is NotificationPageLoading
              ? ShowLoadingIndicator()
              : ListView(
            children: [
              ...List.generate(
                cubit.data!.length,
                    (index) => InkWell(

                  child:
                  NotificationDetailsWidget(
                    notificationModel: cubit.data!.elementAt(index),

                  ),
                ),
              ),

            ],
          );
        },
      ),

    );
  }
}
