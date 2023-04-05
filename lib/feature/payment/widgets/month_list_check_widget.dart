import 'package:easy_localization/easy_localization.dart';
import 'package:elmazoon/core/utils/app_colors.dart';
import 'package:elmazoon/feature/payment/cubit/payment_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/models/subscribes_model.dart';

class MonthListCheckWidget extends StatefulWidget {
  const MonthListCheckWidget({Key? key, required this.subscribesDatum})
      : super(key: key);
  final SubscribesDatum subscribesDatum;

  @override
  State<MonthListCheckWidget> createState() => _MonthListCheckWidgetState();
}

class _MonthListCheckWidgetState extends State<MonthListCheckWidget> {
  bool isCheck = false;
  bool formOpenFlag = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          context.read<PaymentCubit>().addOrRemoveModel(
                widget.subscribesDatum,
                isCheck ? 'remove' : 'add',
              );
          isCheck = !isCheck;
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 8,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: isCheck ? AppColors.secondPrimary : AppColors.paymentContainer,
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Text(
                      widget.subscribesDatum.monthName!,
                      style: TextStyle(
                        color:
                            isCheck ? AppColors.white : AppColors.secondPrimary,
                      ),
                    ),
                    Text(
                      widget.subscribesDatum.price.toString(),
                      style: TextStyle(
                        color:
                            isCheck ? AppColors.white : AppColors.secondPrimary,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
                Checkbox(
                  value: isCheck,
                  onChanged: (value) {},
                  activeColor: AppColors.primary,
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: ExpansionTile(
                textColor: AppColors.white,
                initiallyExpanded: formOpenFlag,
                collapsedShape:
                    Border.all(width: 0, color: AppColors.transparent),
                shape: Border.all(width: 0, color: AppColors.transparent),
                iconColor: AppColors.white,
                onExpansionChanged: (val) {
                  formOpenFlag = val; // update here on change
                },
                //     : AppColors.white,
                // collapsedTextColor: isCheck
                //     ? AppColors.white
                //     : AppColors.secondPrimary,
                // key: PageStorageKey<Entry>(root),
                title: Text('month_plan'.tr()),
                children: [
                  if (widget.subscribesDatum.mothData!.isEmpty) ...{
                    Text('no_date'.tr()),
                  } else ...{
                    ...List.generate(
                      widget.subscribesDatum.mothData!.length,
                      (planIndex) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: isCheck
                                ? AppColors.white
                                : AppColors.secondPrimary,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          // padding:
                          //     EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                          child: Row(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: AppColors.primary,

                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    widget
                                        .subscribesDatum.mothData![planIndex].date!,
                                    style: TextStyle(
                                      color: !isCheck
                                          ? AppColors.white
                                          : AppColors.secondPrimary,
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                                  child: Column(
                                    children: [
                                      ...List.generate(
                                        widget.subscribesDatum
                                            .mothData![planIndex].plans!.length,
                                        (index) => Text(
                                          '- ${widget.subscribesDatum.mothData![planIndex].plans![index].title}',
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: !isCheck
                                                ? AppColors.white
                                                : AppColors.secondPrimary,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  },
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
