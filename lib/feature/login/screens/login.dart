import 'package:easy_localization/easy_localization.dart';
import 'package:elmazoon/core/utils/app_colors.dart';
import 'package:elmazoon/core/utils/toast_message_method.dart';
import 'package:elmazoon/core/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../core/utils/assets_manager.dart';
import '../../../../../core/widgets/circle_image_widget.dart';
import '../../../core/utils/call_method.dart';
import '../../../core/utils/show_dialog.dart';
import '../../navigation_bottom/screens/navigation_bottom.dart';
import '../cubit/login_cubit.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _userScreenState();
}

class _userScreenState extends State<LoginScreen> {
  final keyForm = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    timeDilation = 1.5;
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
                      if (state is userLoading) {
                        return SizedBox(
                          height: 120,
                          child: Center(
                            child: CircularProgressIndicator(
                              color: AppColors.primary,
                            ),
                          ),
                        );
                      }
                      if (state is userLoaded) {
                        Future.delayed(
                          Duration(milliseconds: 300),
                          () {
                            Future.delayed(
                              Duration(milliseconds: 500),
                              () {
                                toastMessage(
                                  'user_success'.tr(),
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
                                      // userDataModel: userDataModel,
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
                                      'user_account'.tr(),
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
                                              controller: context
                                                  .read<LoginCubit>()
                                                  .codeController,
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
                                      text: 'user'.tr(),
                                      color: AppColors.secondPrimary,
                                      onClick: () {
                                        if (keyForm.currentState!.validate()) {
                                          context
                                              .read<LoginCubit>()
                                              .userWithCode(context);
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
                  SizedBox(height: 30),
                  Text(
                    'contact_us_from'.tr(),
                    style: TextStyle(
                      color: AppColors.gray1,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  SizedBox(height: 30),
                  BlocBuilder<LoginCubit, LoginState>(
                    builder: (context, state) {
                      LoginCubit cubit = context.read<LoginCubit>();
                      return SizedBox(
                        width: double.maxFinite,
                        child: Center(
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              InkWell(
                                onTap: () {
                                  if (state is userCommunicationError) {
                                    createProgressDialog(context, 'wait'.tr());
                                    cubit.getCommunicationData().whenComplete(
                                      () {
                                        Navigator.of(context).pop();
                                        if (cubit.isCommunicationData) {
                                          getCommunicationTab(
                                            'facebook',
                                            cubit,
                                          );
                                        } else {
                                          toastMessage(
                                            'error_to_get_data'.tr(),
                                            context,
                                            color: AppColors.error,
                                          );
                                        }
                                      },
                                    );
                                  } else {
                                    getCommunicationTab(
                                      'facebook',
                                      cubit,
                                    );
                                  }
                                },
                                child: Image.asset(
                                  ImageAssets.facebookImage,
                                  width: 40.0,
                                  height: 40.0,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              const SizedBox(width: 16.0),
                              InkWell(
                                onTap: () async {
                                  if (state is userCommunicationError) {
                                    createProgressDialog(context, 'wait'.tr());
                                    cubit.getCommunicationData().whenComplete(
                                      () {
                                        Navigator.of(context).pop();
                                        if (cubit.isCommunicationData) {
                                          getCommunicationTab(
                                            'youtube',
                                            cubit,
                                          );
                                        } else {
                                          toastMessage(
                                            'error_to_get_data'.tr(),
                                            context,
                                            color: AppColors.error,
                                          );
                                        }
                                      },
                                    );
                                  } else {
                                    getCommunicationTab(
                                      'youtube',
                                      cubit,
                                    );
                                  }
                                },
                                child: Image.asset(
                                  ImageAssets.youtubeImage,
                                  width: 40.0,
                                  height: 40.0,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              const SizedBox(width: 16.0),
                              InkWell(
                                onTap: () {
                                  if (state is userCommunicationError) {
                                    createProgressDialog(context, 'wait'.tr());
                                    cubit.getCommunicationData().whenComplete(
                                      () {
                                        Navigator.of(context).pop();
                                        if (cubit.isCommunicationData) {
                                          getCommunicationTab('call', cubit);
                                        } else {
                                          toastMessage(
                                            'error_to_get_data'.tr(),
                                            context,
                                            color: AppColors.error,
                                          );
                                        }
                                      },
                                    );
                                  } else {
                                    getCommunicationTab('call', cubit);
                                  }
                                },
                                child: Image.asset(
                                  ImageAssets.callImage,
                                  width: 40.0,
                                  height: 40.0,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  )
                ],
              ),
            ),
          )),
    );
  }

  getCommunicationTab(String type, LoginCubit cubit) async {
    if (type == 'facebook') {
      await launchUrl(Uri.parse(cubit.communicationData.facebookLink));
    } else if (type == 'youtube') {
      await launchUrl(Uri.parse(cubit.communicationData.youtubeLink));
    } else {
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
                  cubit.communicationData.phones.length,
                  (index) => InkWell(
                    onTap: () {
                      phoneCallMethod(
                        cubit.communicationData.phones[index].phone,
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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(cubit
                                    .communicationData.phones[index].phone),
                                Text(cubit.communicationData.phones[index].note)
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
    }
  }
}
