import 'package:easy_localization/easy_localization.dart';
import 'package:elmazoon/core/widgets/custom_textfield.dart';
import 'package:elmazoon/feature/mainscreens/study_page/cubit/study_page_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/utils/app_colors.dart';
import '../../../core/widgets/dialog_choose_screen.dart';
import '../../../core/widgets/network_image.dart';
import '../cubit/exam_cubit.dart';
import '../../mainscreens/study_page/widgets/choose_icon_dialog.dart';

class AddAnswerWidget extends StatelessWidget {
  AddAnswerWidget(
      {Key? key, required this.id, required this.type, required this.index})
      : super(key: key);
  final int id;
  final String type;
  final int index;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExamCubit, ExamState>(
      builder: (context, state) {
        ExamCubit cubit = context.read<ExamCubit>();
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Container(
            height: 150,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: TextFormField(
                    minLines: 30,
                    maxLines: 45,
                    controller: cubit.answerController,
                    decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 14, horizontal: 14),
                      hintStyle: TextStyle(
                        color: AppColors.secondPrimary,
                        fontWeight: FontWeight.bold,
                      ),
                      hintText: 'answer'.tr(),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        borderSide: BorderSide.none,
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(Icons.attach_file),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (ctx) => AlertDialog(
                              title: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 5),
                                child: Text('choose'.tr()),
                              ),
                              contentPadding: EdgeInsets.zero,
                              content: SizedBox(
                                width: MediaQuery.of(context).size.width - 60,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    ChooseIconDialog(
                                      title: 'camera'.tr(),
                                      icon: Icons.camera_alt,
                                      onTap: () {
                                        cubit.pickImage(type: 'camera');
                                        Navigator.of(context).pop();
                                        Future.delayed(
                                            Duration(milliseconds: 500), () {
                                          showDialog(
                                            context: context,
                                            barrierDismissible: false,
                                            builder: (ctx) => AlertDialog(
                                              title: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                  vertical: 5,
                                                ),
                                                child: Text('photo'.tr()),
                                              ),
                                              contentPadding: EdgeInsets.zero,
                                              content: RecordWidget(
                                                type: 'image',
                                                sendType: type,
                                                id: id,
                                              ),
                                            ),
                                          );
                                        });
                                      },
                                    ),
                                    ChooseIconDialog(
                                      title: 'photo'.tr(),
                                      icon: Icons.photo,
                                      onTap: () {
                                        cubit.pickImage(type: 'photo');
                                        Navigator.of(context).pop();
                                        Future.delayed(
                                            Duration(milliseconds: 500), () {
                                          showDialog(
                                            context: context,
                                            barrierDismissible: false,
                                            builder: (ctx) => AlertDialog(
                                              title: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                  vertical: 5,
                                                ),
                                                child: Text('photo'.tr()),
                                              ),
                                              contentPadding: EdgeInsets.zero,
                                              content: RecordWidget(
                                                type: 'image',
                                                sendType: type,
                                                id: id,
                                              ),
                                            ),
                                          );
                                        });
                                      },
                                    ),
                                    ChooseIconDialog(
                                      title: 'voice'.tr(),
                                      icon: Icons.mic,
                                      onTap: () {
                                        Navigator.pop(context);
                                        Future.delayed(
                                            Duration(milliseconds: 500), () {
                                          showDialog(
                                            context: context,
                                            barrierDismissible: false,
                                            builder: (ctx) => AlertDialog(
                                              title: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                  vertical: 5,
                                                ),
                                                child: Text('voice'.tr()),
                                              ),
                                              contentPadding: EdgeInsets.zero,
                                              content: RecordWidget(
                                                type: 'voice',
                                                sendType: type,
                                                id: id,
                                              ),
                                            ),
                                          );
                                        });
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text('cancel'.tr()),
                                )
                              ],
                            ),
                          );
                        },
                      ),
                      fillColor: AppColors.commentBackground,
                      filled: true,
                    ),
                    keyboardType: TextInputType.text,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    if (cubit.formKey.currentState!.validate()) {
                      print('object');
                      print(cubit.answerController.text);
                      cubit.addtextanswer();
                    }
                  },
                  icon: Icon(
                    Icons.send,
                    color: AppColors.secondPrimary,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

/*






*/
