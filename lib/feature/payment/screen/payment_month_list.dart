import 'package:easy_localization/easy_localization.dart';
import 'package:elmazoon/core/utils/app_colors.dart';
import 'package:elmazoon/core/utils/toast_message_method.dart';
import 'package:elmazoon/core/widgets/show_loading_indicator.dart';
import 'package:elmazoon/feature/payment/cubit/payment_cubit.dart';
import 'package:elmazoon/feature/payment/cubit/payment_cubit.dart';
import 'package:elmazoon/feature/payment/screen/pay_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/widgets/custom_appbar_widget.dart';
import '../../../core/widgets/custom_button.dart';
import '../widgets/month_list_check_widget.dart';

class PaymentMonthList extends StatelessWidget {
  const PaymentMonthList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String lang = EasyLocalization.of(context)!.locale.languageCode;

    return Scaffold(
      appBar: CustomAppBarWidget(appBarTitle: 'payment_online'.tr()),
      body: BlocBuilder<PaymentCubit, PaymentState>(
        builder: (context, state) {
          PaymentCubit cubit = context.read<PaymentCubit>();
          if (state is PaymentMonthLoading) {
            return ShowLoadingIndicator();
          }
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: RefreshIndicator(
              onRefresh: () async {
                cubit.getPaymentMonth();
              },
              backgroundColor: AppColors.secondPrimary,
              color: AppColors.primary,
              child: ListView(
                children: [
                  ...List.generate(
                    cubit.subscribesList.length,
                    (index) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: MonthListCheckWidget(
                        subscribesDatum: cubit.subscribesList[index],
                      ),
                    ),
                  ),
                  SizedBox(height: 35),
                  CustomButton(
                    text: 'pay'.tr(),
                    color: AppColors.primary,
                    paddingHorizontal: 80,
                    onClick: () {
                      print(cubit.tempSubscribesList.length);
                      print(cubit.totalPayment);
                      print(cubit.paymentList);
                      print(cubit.monthNumber);
                      cubit.testMonth(context,lang);

                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
