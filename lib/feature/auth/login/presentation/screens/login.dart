import 'package:easy_localization/easy_localization.dart';
import 'package:elmazoon/core/utils/app_colors.dart';
import 'package:elmazoon/core/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../../core/utils/assets_manager.dart';
import '../../../../../core/widgets/circle_image_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SafeArea(

          top: false,
          maintainBottomViewPadding: true,
          child: CircleImageWidget(
            myWidget: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(
                    height: 100,
                  ),
                  Container(
                    height: 300,
                    width: 300,

                    child: SizedBox(
                        width: 300,
                        height: 150,
                        child: Image.asset('assets/images/logo.png',

                        )),
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Container(
                        decoration:  BoxDecoration(
                            color: AppColors.primary,
                            borderRadius: const BorderRadius.all(Radius.circular(20))),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Column(
                            children: [
                              const SizedBox(height: 15,),

                              Text('login_account'.tr(),style: TextStyle(color: AppColors.white,fontWeight: FontWeight.bold,fontSize: 15),),
                              const SizedBox(height: 15,),
                              Text('please_write_code'.tr(),style: TextStyle(color: AppColors.white,fontWeight: FontWeight.normal,fontSize: 13),),
                              Container(

                                child: Row(
                                  children: [

                                    const SizedBox(width: 25),
                                    Expanded(
                                      child: TextFormField(
                                        maxLines: 1,
                                        autofocus: false,
                                        cursorColor: AppColors.primary,
                                        keyboardType: TextInputType.text,
                                        obscureText: true,
                                        textInputAction: TextInputAction.done,


                                        decoration: const InputDecoration(
                                            border: InputBorder.none

                                           ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Divider(
                                color: AppColors.white,
                                height: 3,
                                thickness: 3,
                              ),
                              const SizedBox(height: 30,),
                              CustomButton(
                                text: 'login'.tr(),
                                color:  AppColors.secondPrimary,
                                onClick: () {

                                },
                                paddingHorizontal: 60,
                                borderRadius: 10,
                              ),
                              const SizedBox(height: 30,),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
               SizedBox(
                      height: 30,),
                  Text('contact_us_from'.tr(),style: TextStyle(color: AppColors.gray1,fontWeight: FontWeight.bold,fontSize: 15),),
                  SizedBox(
                    height: 30,),
                  SizedBox(
                    width: double.maxFinite,
                    child: Center(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          InkWell(

                              child: Image.asset(
                                ImageAssets.facebookImage,
                                width: 40.0,
                                height: 40.0,
                                fit: BoxFit.cover,
                              )),
                          const SizedBox(
                            width: 16.0,
                          ),
                          InkWell(
                              child: Image.asset(
                                ImageAssets.youtubeImage,
                                width: 40.0,
                                height: 40.0,
                                fit: BoxFit.cover,
                              )),
                          const SizedBox(
                            width: 16.0,
                          ),
                          InkWell(
                              child: Image.asset(
                                ImageAssets.callImage,
                                width: 40.0,
                                height: 40.0,
                                fit: BoxFit.cover,
                              )),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          )),
    );
  }
}
