import 'package:elmazoon/core/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import '../../../../core/models/comments_model.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/widgets/custom_appbar_widget.dart';
import '../../../../core/widgets/network_image.dart';

class RepliesScreen extends StatelessWidget {
  const RepliesScreen({Key? key, required this.commentDatum}) : super(key: key);
  final CommentDatum commentDatum;

  @override
  Widget build(BuildContext context) {
    timeDilation = 1.5;
    return Scaffold(
      appBar: CustomAppBarWidget(appBarTitle: 'lessons.name'),
      body: Column(
        children: [
          Hero(
            tag: '${commentDatum.id}',
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 3),
              child: Card(
                color: AppColors.commentBackground,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 60,
                        height: 60,
                        child: CircleAvatar(
                          radius: 60,
                          backgroundColor: AppColors.transparent,
                          child: ManageNetworkImage(
                            imageUrl: commentDatum.user!.image,
                            width: 60,
                            height: 60,
                            borderRadius: 60,
                          ),
                        ),
                      ),
                      SizedBox(width: 18),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    commentDatum.user!.name,
                                    style: TextStyle(
                                      color: AppColors.secondPrimary,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Text(
                                    '${commentDatum.createdAt!.year}-${commentDatum.createdAt!.month}-${commentDatum.createdAt!.day}',
                                    style: TextStyle(
                                        color: AppColors.primary, fontSize: 12),
                                  ),
                                )
                              ],
                            ),
                            SizedBox(height: 8),
                            Text(
                              commentDatum.comment!,
                              style: TextStyle(
                                color: AppColors.textBackground,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
