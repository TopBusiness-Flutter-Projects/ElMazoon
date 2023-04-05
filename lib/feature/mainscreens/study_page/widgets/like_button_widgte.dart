import 'dart:js';

import 'package:elmazoon/core/utils/app_colors.dart';
import 'package:elmazoon/feature/mainscreens/study_page/cubit/study_page_cubit.dart';
import 'package:elmazoon/feature/mainscreens/study_page/cubit/study_page_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:like_button/like_button.dart';

import '../../../../core/models/lessons_details_model.dart';
import '../../../../core/utils/assets_manager.dart';
import '../../../../core/widgets/my_svg_widget.dart';

class LikeButtonWidget extends StatelessWidget {
  const LikeButtonWidget(
      {Key? key,
      required this.lessons,
      required this.iconColor,
      required this.kind})
      : super(key: key);
  final Lessons lessons;
  final Color iconColor;
  final String kind;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StudyPageCubit, StudyPageState>(
      builder: (context, state) {
        StudyPageCubit cubit =context.read<StudyPageCubit>();
        return LikeButton(
          size: 25,
          circleColor: CircleColor(
            start: iconColor,
            end: iconColor,
          ),
          bubblesColor: BubblesColor(
            dotPrimaryColor: iconColor,
            dotSecondaryColor: iconColor,
          ),
          likeBuilder: (bool isLiked) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                MySvgWidget(
                  path: kind == 'like'
                      ? ImageAssets.likeIcon
                      : ImageAssets.dislikeIcon,
                  size: 25,
                  imageColor: isLiked ? iconColor : Colors.grey,
                ),
              ],
            );
          },
          isLiked: likeTypeBool(),
          onTap: (isLike) async {
            onTapLikeIcon(cubit);
            return !isLike;
          },
          likeCount: likeCount(),
          countBuilder: (int? count, bool isLiked, String text) {
            var color = isLiked ? iconColor : AppColors.gray;
            return Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Text(
                text,
                textAlign: TextAlign.center,
                style: TextStyle(color: color),
              ),
            );
          },
        );
      },
    );
  }

  bool likeTypeBool() {
    if (kind == 'like') {
      if (lessons.rate == 'like') {
        return true;
      } else {
        return false;
      }
    } else {
      if (lessons.rate == 'dislike') {
        return true;
      } else {
        return false;
      }
    }
  }

  onTapLikeIcon(StudyPageCubit cubit) {
    if (kind == 'like') {
      lessons.rate = (lessons.rate == 'no_rate' || lessons.rate == 'dislike')
          ? 'like'
          : 'no_rate';
      cubit.changeLikeType('like');
      // lessons.likeCount = lessons.rate == 'dislike'
      //     ? null
      //     : lessons.rate == 'no_rate'
      //         ? lessons.likeCount! - 1
      //         : lessons.likeCount! + 1;
      //
      // lessons.dislikeCount = lessons.rate == 'dislike'
      //     ? lessons.dislikeCount! - 1
      //     : lessons.dislikeCount;
    } else {
      lessons.rate = (lessons.rate == 'no_rate' || lessons.rate == 'like')
          ? 'dislike'
          : 'no_rate';
      cubit.changeLikeType('dislike');
    }
  }

  int likeCount() {
    if (kind == 'like') {
      return lessons.likeCount!;
    } else {
      return lessons.dislikeCount!;
    }
  }
}
