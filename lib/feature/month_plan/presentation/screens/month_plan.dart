import 'package:easy_localization/easy_localization.dart';
import 'package:elmazoon/core/utils/app_colors.dart';
import 'package:elmazoon/core/utils/app_routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import '../../../../core/models/month_plan_model.dart';
import '../../../../core/utils/assets_manager.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../cubit/month_plan_cubit.dart';

class MonthPage extends StatelessWidget {
  const MonthPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        titleSpacing: 0,
        title:Row( children: [CustomAppBar(
          title: 'month_plan'.tr(),
          subtitle: 'month_course'.tr(),
        ),
        Expanded(child: Container()),
         InkWell(
           onTap: () {
             context.read<MonthPlanCubit>().getMonthPlan();
           },
           child: Icon (
              Icons.refresh,
             color: AppColors.white,

            ),
         )
        ],),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(ImageAssets.appBarImage),
              fit: BoxFit.fill,
            ),
          ),
        ),
      ),
      body: BlocBuilder<MonthPlanCubit, MonthPlanState>(
        builder: (context, state) {
          return SfCalendar(

            view: CalendarView.month,
            dataSource: PlansDataSource(_getDataSource(context)),

            onTap: (calendarTapDetails) {
              List<Plans>? plans =
                  calendarTapDetails.appointments!.cast<Plans>();
              Navigator.pushNamed(
                context,
                Routes.monthplanDetialsRoute,
                arguments: [plans, calendarTapDetails.date],
              );
            },
            monthViewSettings: const MonthViewSettings(
              agendaStyle: AgendaStyle(
                appointmentTextStyle: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              appointmentDisplayMode: MonthAppointmentDisplayMode.appointment,
            ),
          );
        },
      ),
    );
  }

  List<Plans> _getDataSource(BuildContext context) {
    List<MothData>? monthList = context.read<MonthPlanCubit>().monthDataList;
    final List<Plans> meetings = <Plans>[];
    for (int i = 0; i < monthList.length; i++) {
      meetings.addAll(monthList.elementAt(i).plans!);
    }
    return meetings;
  }
}

class PlansDataSource extends CalendarDataSource {
  PlansDataSource(List<Plans> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return DateTime.parse(_getPlansData(index).start!);
  }

  @override
  DateTime getEndTime(int index) {
    return DateTime.parse(_getPlansData(index).end!);
  }

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
