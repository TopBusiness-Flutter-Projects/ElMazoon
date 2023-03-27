part of 'downloads_videos_cubit.dart';

@immutable
abstract class DownloadsVideosState {}

class DownloadsVideosInitial extends DownloadsVideosState {}

class DownloadsVideosList extends DownloadsVideosState {
  final List<FileSystemEntity> files;

  DownloadsVideosList(this.files);
}

class DownloadsVideosLoading extends DownloadsVideosState {}
class DownloadsVideosError extends DownloadsVideosState {}

