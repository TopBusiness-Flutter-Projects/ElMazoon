import 'package:easy_localization/easy_localization.dart';
import 'package:elmazoon/core/utils/app_colors.dart';
import 'package:elmazoon/core/utils/toast_message_method.dart';
import 'package:elmazoon/core/widgets/custom_button.dart';
import 'package:elmazoon/core/widgets/show_loading_indicator.dart';
import 'package:elmazoon/feature/auth/login/presentation/cubit/login_cubit.dart';
import 'package:elmazoon/feature/auth/login/presentation/cubit/login_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';

import '../../../../../core/utils/assets_manager.dart';
import '../../../../../core/widgets/circle_image_widget.dart';
import '../../../../navigation_bottom/screens/navigation_bottom.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final keyForm = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    timeDilation = 1.5; // 1.0 means normal animation speed.
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
                  Hero(
                    tag: 'logo',
                    child: Container(
                      height: 300,
                      width: 300,
                      child: SizedBox(
                        width: 300,
                        height: 150,
                        child: Image.asset(
                          'assets/images/logo.png',
                        ),
                      ),
                    ),
                  ),
                  BlocBuilder<LoginCubit, LoginState>(
                    builder: (context, state) {
                      if (state is LoginLoading) {
                        return SizedBox(
                            height: 120,
                            child: Center(
                              child: CircularProgressIndicator(
                                color: AppColors.primary,
                              ),
                            ));
                      }
                      if (state is LoginLoaded) {

                        Future.delayed(
                          Duration(milliseconds: 300),
                              () {
                                Future.delayed(
                                  Duration(milliseconds: 500),
                                      () {
                                    toastMessage(
                                      'login_success'.tr(),
                                      context,
                                      color: AppColors.success,
                                    );
                                  },
                                );
                                Navigator.pushAndRemoveUntil(
                                    context,
                                    PageTransition(
                                      type: PageTransitionType.fade,
                                      alignment: Alignment.center,
                                      duration: const Duration(milliseconds: 1300),
                                      child: NavigatorBar(
                                        // loginDataModel: loginDataModel,
                                      ),
                                    ),
                                        (route) => false);
                          },
                        );
                      }
                      return Form(
                        key: keyForm,
                        child: Center(
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: Container(
                              decoration: BoxDecoration(
                                color: AppColors.primary,
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(20),
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0),
                                child: Column(
                                  children: [
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    Text(
                                      'login_account'.tr(),
                                      style: TextStyle(
                                          color: AppColors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15),
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    Text(
                                      'please_write_code'.tr(),
                                      style: TextStyle(
                                          color: AppColors.white,
                                          fontWeight: FontWeight.normal,
                                          fontSize: 13),
                                    ),
                                    Container(
                                      child: Row(
                                        children: [
                                          const SizedBox(width: 25),
                                          Expanded(
                                            child: TextFormField(
                                              maxLines: 1,
                                              autofocus: false,
                                              textAlign: TextAlign.center,
                                              controller: context.read<LoginCubit>().codeController,
                                              cursorColor: AppColors.primary,
                                              keyboardType: TextInputType.text,
                                              obscureText: true,
                                              textInputAction:
                                                  TextInputAction.done,
                                              decoration: const InputDecoration(
                                                border: InputBorder.none,
                                              ),
                                              validator: (value) {
                                                if (value == null ||
                                                    value.isEmpty) {
                                                  return 'field_required'.tr();
                                                } else {
                                                  return null;
                                                }
                                              },
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
                                    const SizedBox(
                                      height: 30,
                                    ),
                                    CustomButton(
                                      text: 'login'.tr(),
                                      color: AppColors.secondPrimary,
                                      onClick: () {
                                        if (keyForm.currentState!.validate()) {
                                          context
                                              .read<LoginCubit>()
                                              .loginWithCode(context);
                                        }
                                      },
                                      paddingHorizontal: 60,
                                      borderRadius: 10,
                                    ),
                                    const SizedBox(
                                      height: 30,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    'contact_us_from'.tr(),
                    style: TextStyle(
                        color: AppColors.gray1,
                        fontWeight: FontWeight.bold,
                        fontSize: 15),
                  ),
                  SizedBox(
                    height: 30,
                  ),
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
