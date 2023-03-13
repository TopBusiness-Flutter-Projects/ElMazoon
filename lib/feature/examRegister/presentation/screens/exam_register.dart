import 'package:easy_localization/easy_localization.dart';
import 'package:elmazoon/core/models/times_model.dart';
import 'package:elmazoon/core/models/times_model.dart';
import 'package:elmazoon/core/utils/assets_manager.dart';
import 'package:elmazoon/core/widgets/custom_button.dart';
import 'package:elmazoon/feature/examRegister/cubit/exam_register_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/models/TimeModel.dart';
import '../../../../core/models/times_model.dart';
import '../../../../core/models/times_model.dart';
import '../../../../core/models/times_model.dart';
import '../../../../core/models/times_model.dart';
import '../../../../core/models/times_model.dart';
import '../../../../core/models/times_model.dart';
import '../../../../core/models/times_model.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/widgets/custom_app_bar.dart';

class ExmRegisterPage extends StatefulWidget {
 final TimeDataModel timeDataModel;


   ExmRegisterPage({Key? key, required this.timeDataModel, }) : super(key: key);

  @override
  State<ExmRegisterPage> createState() => _ExmRegisterPageState();
}

class _ExmRegisterPageState extends State<ExmRegisterPage> {
  Time? dropdownValue;

  @override
  void initState() {
    super.initState();
    dropdownValue=widget.timeDataModel.data.times.elementAt(0);

  }

  @override
  Widget build(BuildContext context) {
    print("dldkkdk");
    print(widget.timeDataModel.data.times.length);
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        titleSpacing: 0,
        title:
        CustomAppBar(title:'register_paper_exam'.tr() ,subtitle: 'register_data_enter_exam'.tr() ,),


        flexibleSpace: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(ImageAssets.appBarImage),
              fit: BoxFit.fill,
            ),
          ),
        ),
      ),
      body: BlocBuilder<ExamRegisterCubit, ExamRegisterState>(
  builder: (context, state) {
    return SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            children: [
              Center(
                child: Image.asset(
                  ImageAssets.userExamImage,
                  fit: BoxFit.cover,
                  height: 300,
                ),
              ),
              const SizedBox(height: 25),
              Container(
                child: Row(
                  children: [
                    const SizedBox(width: 25),
                    Expanded(
                      child: TextFormField(
                        decoration: InputDecoration(
                          border: InputBorder.none,

                        ),
                        controller: context.read<ExamRegisterCubit>().studentName,
                        enabled: false,
                        style: TextStyle(
                            backgroundColor: AppColors.transparent,

                            color: AppColors.secondPrimary,
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 25),
              Divider(
                color: AppColors.secondPrimary,
                height: 3,
                thickness: 3,
              ),
              const SizedBox(height: 10),
              Container(
                child: Row(
                  children: [
                    const SizedBox(width: 25),
                    Expanded(
                      child:  TextFormField(
                        controller: context.read<ExamRegisterCubit>().phoneName,
                        enabled: false,
                        decoration: InputDecoration(
                          border: InputBorder.none,

                        ),
                        style: TextStyle(
                            backgroundColor: AppColors.transparent,

                            color: AppColors.secondPrimary,
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Divider(
                color: AppColors.secondPrimary,
                height: 3,
                thickness: 3,
              ),
              const SizedBox(height: 10),
              Container(
                child: Row(
                  children: [
                    const SizedBox(width: 25),
                    Expanded(
                      child:  TextFormField(

                        decoration: InputDecoration(
                          border: InputBorder.none,

                        ),
                        controller: context.read<ExamRegisterCubit>().studentCode,
                        enabled: false,
                        style: TextStyle(
                          backgroundColor: AppColors.transparent,
                            color: AppColors.secondPrimary,
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Divider(
                color: AppColors.secondPrimary,
                height: 3,
                thickness: 3,
              ),
              const SizedBox(height: 25),
              Container(
                child: Row(
                  children: [
                    const SizedBox(width: 25),
                    Expanded(
                      child: Text(
                        'exam_num'.tr()+" : ".tr()+widget.timeDataModel.data.id.toString(),
                        style: TextStyle(
                            color: AppColors.secondPrimary,
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 25),
              Divider(
                color: AppColors.secondPrimary,
                height: 3,
                thickness: 3,
              ),
              const SizedBox(height: 25),
              Container(
                child: Row(
                  children: [
                    const SizedBox(width: 25),
                    Expanded(
                      child: DropdownButton(
                        isExpanded: true,
                        icon: Icon(
                          Icons.expand_circle_down,
                          size: 30,

                          color: AppColors.secondPrimary,
                        ),
                        value:dropdownValue,
                        iconSize: 15,
                        elevation: 16,
                        style: TextStyle(color: AppColors.secondPrimary),
                        underline: Container(
                          height: 2,
                          color: AppColors.transparent,
                        ),
                        onChanged: (newValue) {
                          setState(() {
                            dropdownValue = newValue;
                          });
                        },
                        items:widget.timeDataModel.data.times
                            .map<DropdownMenuItem<Time>>((Time value) {
                          return DropdownMenuItem<Time>(
                              value: value,
                              child: Container(

                                  width: 200,

                                  child: Text(
                                   "group_time".tr()+":"+ value.from.replaceRange(value.from.length-3, value.from.length, '')+" - "+value.to.replaceRange(value.to.length-3, value.to.length, ''),
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15),
                                  )));
                        }).toList(),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Divider(
                color: AppColors.secondPrimary,
                height: 3,
                thickness: 3,
              ),
              const SizedBox(height: 40),

              const SizedBox(height: 25),       CustomButton(
                text: 'record_data'.tr(),
                color: AppColors.primary,
                onClick: () {
                  context.read<ExamRegisterCubit>().openexam(widget.timeDataModel, dropdownValue!, context);
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
