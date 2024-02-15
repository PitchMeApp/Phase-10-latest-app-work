class VideoCompressChannelArgumentModel {
  final String sourcePath;
  final String destinationPath;

  VideoCompressChannelArgumentModel(
      {required this.sourcePath, required this.destinationPath});

  factory VideoCompressChannelArgumentModel.fromMap(Map<String, dynamic> json) {
    return VideoCompressChannelArgumentModel(
        sourcePath: json['sourcePath'],
        destinationPath: json['destinationPath']);
  }
  Map<String, dynamic> toJson() =>
      {"sourcePath": sourcePath, "destinationPath": destinationPath};
}

class VideoCompressChannelArgumentResponseModel {
  final String error;

  VideoCompressChannelArgumentResponseModel({required this.error});

  factory VideoCompressChannelArgumentResponseModel.fromMap(
      Map<String, dynamic> json) {
    return VideoCompressChannelArgumentResponseModel(error: json["error"]);
  }

  Map<String, dynamic> toJson() => {"error": error};
}
