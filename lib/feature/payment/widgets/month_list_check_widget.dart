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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Text(
                  widget.subscribesDatum.monthName!,
                  style: TextStyle(
                    color:
                        isCheck ? AppColors.primary : AppColors.secondPrimary,
                  ),
                ),
                Text(
                  widget.subscribesDatum.price.toString(),
                  style: TextStyle(
                    color:
                        isCheck ? AppColors.primary : AppColors.secondPrimary,
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
      ),
    );
  }
}
