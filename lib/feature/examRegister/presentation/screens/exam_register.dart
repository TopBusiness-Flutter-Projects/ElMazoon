import 'package:easy_localization/easy_localization.dart';
import 'package:elmazoon/core/utils/assets_manager.dart';
import 'package:elmazoon/core/widgets/custom_button.dart';
import 'package:flutter/material.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/widgets/custom_app_bar.dart';

class ExmRegisterPage extends StatelessWidget {
  const ExmRegisterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            children: [
              Center(
                child: Image.asset(
                  ImageAssets.userexamImage,
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
                      child: Text(
                        'name',
                        style: TextStyle(
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
              const SizedBox(height: 25),
              Container(
                child: Row(
                  children: [
                    const SizedBox(width: 25),
                    Expanded(
                      child: Text(
                        'phone',
                        style: TextStyle(
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
              const SizedBox(height: 25),
              Container(
                child: Row(
                  children: [
                    const SizedBox(width: 25),
                    Expanded(
                      child: Text(
                        'code',
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
                      child: Text(
                        'exam num',
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
                        value: 'One',
                        iconSize: 15,
                        elevation: 16,
                        style: TextStyle(color: AppColors.secondPrimary),
                        underline: Container(
                          height: 2,
                          color: AppColors.transparent,
                        ),
                        onChanged: (newValue) {
                          // setState(() {
                          //   dropdownValue = newValue;
                          // });
                        },
                        items: ['One', 'Two', 'Free', 'Four']
                            .map<DropdownMenuItem>((String value) {
                          return DropdownMenuItem(
                              value: value,
                              child: Container(
                                  height: 100,
                                  width: 200,
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    value,
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
              const SizedBox(height: 25),
              Divider(
                color: AppColors.secondPrimary,
                height: 3,
                thickness: 3,
              ),
              const SizedBox(height: 40),
              CustomButton(
                text: 'record_data'.tr(),
                color: AppColors.primary,
                onClick: () {},
              ),
              const SizedBox(height: 25),
            ],
          ),
        ),
      ),
    );
  }
}
