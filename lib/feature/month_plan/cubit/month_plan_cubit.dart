import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:elmazoon/core/remote/service.dart';
import 'package:meta/meta.dart';

import '../../../core/models/month_plan_model.dart';

part 'month_plan_state.dart';

class MonthPlanCubit extends Cubit<MonthPlanState> {
 final ServiceApi api;
 List<MothData> monthdataList=[];

  MonthPlanCubit(this.api) : super(MonthPlanInitial()){
    getMonthPlan();
  }
  getMonthPlan() async {

    final response = await api.getMonthPlans();
    response.fold(

          (error) =>   {

          },
          (response) {

        if(response.code==200){

          monthdataList=response.data!;

          emit(MonthPlanupdate());
         // Navigator.pushNamed(context, Routes.examRegisterRoute,arguments: data);
        }
        else{

        }
        //data = response.data;
        //  emit(NotificationPageLoaded());
      },
    );
  }

}
