import 'package:easy_localization/easy_localization.dart';
import 'package:elmazoon/core/widgets/show_loading_indicator.dart';
import 'package:elmazoon/feature/downloads_videos/cubit/downloads_videos_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/app_routes.dart';
import '../../../core/utils/assets_manager.dart';
import '../../../core/widgets/no_data_widget.dart';

class DownloadsVideos extends StatefulWidget {
  const DownloadsVideos({Key? key}) : super(key: key);

  @override
  State<DownloadsVideos> createState() => _DownloadsVideosState();
}

class _DownloadsVideosState extends State<DownloadsVideos> {


  @override
  void initState() {
    super.initState();
    context.read<DownloadsVideosCubit>().getSavedVideosInShared().whenComplete(
          () => context.read<DownloadsVideosCubit>().getVideos(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        titleSpacing: 0,
        title: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Text(
            'downloads_videos'.tr(),
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(ImageAssets.appBarImage),
              fit: BoxFit.fill,
            ),
          ),
        ),
      ),
      body: BlocBuilder<DownloadsVideosCubit, DownloadsVideosState>(
        builder: (context, state) {
          DownloadsVideosCubit cubit = context.read<DownloadsVideosCubit>();
          if (state is DownloadsVideosList) {
            print("ddkdkdkk");
            print(state.files);
          }
          if (state is DownloadsVideosLoading) {
            return ShowLoadingIndicator();
          }
          if (state is DownloadsVideosError) {
            return NoDataWidget(
              onclick: () => cubit
                  .getSavedVideosInShared()
                  .whenComplete(() => cubit.getVideos()),
              title: 'no_video',
            );
          } else {
            return cubit.files.isEmpty
                ? NoDataWidget(
                    onclick: () => cubit
                        .getSavedVideosInShared()
                        .whenComplete(() => cubit.getVideos()),
                    title: 'no_video',
                  )
                : RefreshIndicator(
                    onRefresh: () async {
                      cubit.getSavedVideosInShared().whenComplete(
                            () => cubit.getVideos(),
                          );
                    },
                    child: ListView.builder(
                      itemCount: cubit.files.length,
                      itemBuilder: (context, index) {
                        return Card(
                          elevation: 3,
                          color: AppColors.white,
                          margin: EdgeInsets.all(8),
                          child: InkWell(
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                Routes.downloadvideoplayRoute,
                                arguments: cubit.files
                                    .elementAt(index)
                                    .absolute
                                    .toString(),
                              );
                            },
                            child: Container(
                              child: Column(
                                children: [
                                  Icon(Icons.video_library, size: 50),
                                  SizedBox(height: 10),
                                  Text(cubit.savedList[index].videoName),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  );
          }
        },
      ),
    );
  }
}
