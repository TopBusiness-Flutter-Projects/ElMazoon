class SaveVideoModelList {
  SaveVideoModelList({required this.savedList});

  final List<SaveVideoModel> savedList;

  factory SaveVideoModelList.fromJson(Map<String, dynamic> json) =>
      SaveVideoModelList(
        savedList: List<SaveVideoModel>.from(
          json["saved_list"].map((x) => SaveVideoModel.fromJson(x)),
        ),
      );

  Map<String, dynamic> toJson() => {'saved_list': savedList};
}

class SaveVideoModel {
  SaveVideoModel({required this.videoName, required this.videoPath});

  final String videoName;
  final String videoPath;

  factory SaveVideoModel.fromJson(Map<String, dynamic> json) => SaveVideoModel(
        videoName: json['video_name'],
        videoPath: json['video_path'],
      );

  Map<String, dynamic> toJson() => {
        'video_name': videoName,
        'video_path': videoPath,
      };
}
