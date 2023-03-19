import 'package:easy_localization/easy_localization.dart';
import 'package:elmazoon/core/utils/assets_manager.dart';
import 'package:elmazoon/core/widgets/my_svg_widget.dart';
import 'package:elmazoon/feature/payment/screen/payment_month_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/utils/app_colors.dart';
import '../../../core/utils/call_method.dart';
import '../../../core/utils/show_dialog.dart';
import '../../../core/utils/toast_message_method.dart';
import '../../../core/widgets/custom_appbar_widget.dart';
import '../../login/cubit/login_cubit.dart';

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarWidget(appBarTitle: 'payment'.tr()),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SizedBox(height: 30),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PaymentMonthList(),
                  ),
                );
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 40),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: AppColors.paymentContainer,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'payment_online'.tr(),
                      style: TextStyle(
                        color: AppColors.secondPrimary,
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                      ),
                    ),
                    MySvgWidget(
                      path: ImageAssets.paymentOnlineIcon,
                      imageColor: AppColors.secondPrimary,
                      size: 50,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 30),
            InkWell(
              onTap: () {
                createProgressDialog(context, 'wait'.tr());
                context
                    .read<LoginCubit>()
                    .getCommunicationData()
                    .whenComplete(() {
                  Navigator.of(context).pop();
                  if (context.read<LoginCubit>().communicationData != null) {
                    showDialog(
                      barrierDismissible: false,
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          backgroundColor: AppColors.white,
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(vertical: 8),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: AppColors.secondPrimary,
                                ),
                                width: double.infinity,
                                child: Center(
                                  child: Text(
                                    'contact_us_from'.tr(),
                                    style: TextStyle(
                                      color: AppColors.white,
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 25),
                              ...List.generate(
                                context
                                    .read<LoginCubit>()
                                    .communicationData!
                                    .phones
                                    .length,
                                (index) => InkWell(
                                  onTap: () {
                                    phoneCallMethod(
                                      context
                                          .read<LoginCubit>()
                                          .communicationData!
                                          .phones[index]
                                          .phone,
                                    );
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        Image.asset(
                                          ImageAssets.callImage,
                                          width: 30.0,
                                          height: 30.0,
                                          fit: BoxFit.cover,
                                        ),
                                        SizedBox(width: 20),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Text(context
                                                  .read<LoginCubit>()
                                                  .communicationData!
                                                  .phones[index]
                                                  .phone),
                                              Text(context
                                                  .read<LoginCubit>()
                                                  .communicationData!
                                                  .phones[index]
                                                  .note)
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 25),
                              InkWell(
                                onTap: () => Navigator.of(context).pop(),
                                child: Container(
                                  padding: EdgeInsets.symmetric(vertical: 12),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: AppColors.primary,
                                  ),
                                  width: double.infinity,
                                  child: Center(
                                    child: Text(
                                      'close'.tr(),
                                      style: TextStyle(
                                        color: AppColors.white,
                                        fontSize: 20,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  } else {
                    toastMessage(
                      'no_date'.tr(),
                      context,
                      color: AppColors.error,
                    );
                  }
                });
                // Navigator.pushNamed(context, Routes.suggestRoute);
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 40),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: AppColors.paymentContainer,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'payment_cash'.tr(),
                      style: TextStyle(
                        color: AppColors.secondPrimary,
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                      ),
                    ),
                    MySvgWidget(
                      path: ImageAssets.paymentCashIcon,
                      imageColor: AppColors.secondPrimary,
                      size: 50,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
