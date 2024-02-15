import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'video_compress_ios.dart';

class VideoCompressHelper {
  Future<bool?> compressVideo(
      {required String atPath, required String destinationPath}) async {
    if (defaultTargetPlatform == TargetPlatform.iOS) {
      final compressHelper = await VideoCompressiOSHelper()
          .checkVideoCompression(
              atPath: atPath, destinationPath: destinationPath);
      return compressHelper;
    } else {
      return null;
    }
  }
}
