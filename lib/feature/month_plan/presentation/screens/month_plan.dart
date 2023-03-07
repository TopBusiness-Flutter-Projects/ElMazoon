import 'package:easy_localization/easy_localization.dart';
import 'package:elmazoon/core/models/times_model.dart';
import 'package:elmazoon/core/utils/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../../../../core/models/exam_model.dart';
import '../../../../core/models/month_plan_model.dart';
import '../../../../core/utils/assets_manager.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../../../core/widgets/custom_appbar_widget.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../cubit/month_plan_cubit.dart';

class MonthPage extends StatelessWidget {

  const MonthPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBarWidget(appBarTitle: 'confirm_exam'),
        body: BlocBuilder<MonthPlanCubit, MonthPlanState>(
          builder: (context, state) {

            return SfCalendar(
              view: CalendarView.month,
              dataSource: PlansDataSource(_getDataSource(context)),
              // by default the month appointment display mode set as Indicator, we can
              // change the display mode as appointment using the appointment display
              // mode property
              monthViewSettings: const MonthViewSettings(
                  appointmentDisplayMode: MonthAppointmentDisplayMode
                      .appointment),
            );
          },
        ));
  }

  List<Plans> _getDataSource(BuildContext context) {
    List<MothData>? monthlist=context.read<MonthPlanCubit>().monthdataList;
    final List<Plans> meetings = <Plans>[];

    for(int i=0;i<monthlist.length;i++){
      meetings.addAll(monthlist.elementAt(i).plans!);

    }
    return meetings;

  }

}
class PlansDataSource extends CalendarDataSource {
  /// Creates a Plans data source, which used to set the appointment
  /// collection to the calendar
  PlansDataSource(List<Plans> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    print("flflfllfl");
    print(_getPlansData(index).start!);
    return DateTime.parse(_getPlansData(index).start!);
  }

  @override
  DateTime getEndTime(int index) {
    return DateTime.parse(_getPlansData(index).end!);  }

  @override
  String getSubject(int index) {
    return _getPlansData(index).title!;
  }

  @override
  Color getColor(int index) {
    return AppColors.secondPrimary;
  }



  Plans _getPlansData(int index) {
    final Plans plans = appointments![index];


    return plans;
  }
}
