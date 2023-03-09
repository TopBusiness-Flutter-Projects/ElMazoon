import 'package:calendar_view/calendar_view.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:elmazoon/core/utils/app_colors.dart';
import 'package:flutter/material.dart';

import '../../../../core/models/month_plan_model.dart';
import '../../../../core/utils/assets_manager.dart';
import '../../../../core/widgets/custom_app_bar.dart';

class MonthPlanDetails extends StatelessWidget {
  final List<Plans> plans;
  final DateTime dateTime;

  const MonthPlanDetails(
      {Key? key, required this.plans, required this.dateTime})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    String lang = EasyLocalization.of(context)!.locale.languageCode;

    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 80,
          titleSpacing: 0,
          title: CustomAppBar(
            title: 'month_plan'.tr(),
            subtitle: 'month_course'.tr(),
          ),
          flexibleSpace: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(ImageAssets.appBarImage),
                fit: BoxFit.fill,
              ),
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Container(

                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,

                    children: [
                      Center(
                        child: Text(DateFormat('EEEE',lang).format(dateTime),
                        style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15,
                        color: AppColors.gray1
                        ),

                        ),
                      ),
                      Center(
                        child: Text(dateTime.day.toString(),
                          style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15,
                              color: AppColors.gray1
                          ),

                        ),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(width: 5,),
              Expanded(
                child: ListView.builder(
                  itemCount: plans.length,
                  itemBuilder: (context, index) {
                   return Padding(
                     padding: const EdgeInsets.all(8.0),
                     child: Container(
                       // width: MediaQuery.of(context).size.width - 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(18),
                          gradient: LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: [
                              AppColors.blueLiteColor1,
                              AppColors.blueLiteColor2,
                            ],
                          ),
                        ),
                        child: Padding(
                          padding:  EdgeInsets.all(10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                              'title'.tr(),
                                style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.secondPrimary),
                              ),
                              SizedBox(
                                height: 1,
                              ),
                              Text(
                                plans.elementAt(index).title!,
                                style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.secondPrimary),
                              ),
                              SizedBox(
                                height: 1,
                              ),


                            ],
                          ),
                        ),
                      ),
                   );
                },),
              )
            ],
          ),
        ));
  }
}
