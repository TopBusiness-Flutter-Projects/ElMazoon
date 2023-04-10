import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/toast_message_method.dart';
import '../../../../core/widgets/container_with_two_color_widget.dart';
import '../../../exam/cubit/exam_cubit.dart';
import '../../study_page/models/all_classes_model.dart';
import '../../study_page/screens/all_lecture/class_name_screen.dart';

class HomePageStartStudyWidget extends StatelessWidget {
  const HomePageStartStudyWidget({Key? key, required this.classes}) : super(key: key);
 final  List<ClassLessons> classes ;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.25,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'start_study'.tr(),
                  style: TextStyle(
                    // color: AppColors.secondPrimary,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 4),
                Container(
                  height: 1,
                  width: MediaQuery.of(context).size.width * 0.22,
                  color: AppColors.primary,
                )
              ],
            ),
          ),
        ),
        SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(
              // childAspectRatio: .9,
              mainAxisSpacing: 30,
              crossAxisSpacing: 0,
              crossAxisCount: 3,
            ),
            itemCount: classes.length,
            itemBuilder:
                (BuildContext context, int index) {
              return InkWell(
                onTap: () {
                  if (classes[index].status ==
                      'lock') {
                    toastMessage(
                      'open_class'.tr(),
                      context,
                      color: AppColors.error,
                    );
                  } else {
                    context
                        .read<ExamCubit>()
                        .examSubjectClassIndex = index;
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            ClassNameScreen(
                              model: classes[index],
                            ),
                      ),
                    );
                  }
                },
                child: ContainerWithTwoColorWidget(
                  title: classes[index].name,
                  imagePath: classes[index].image,
                  color1: AppColors.blueColor1,
                  color2: AppColors.blueColor2,
                  textColor: AppColors.secondPrimary,
                  isHome: true,
                ),
              );
            },
          ),
        )
      ],
    );
  }
}
