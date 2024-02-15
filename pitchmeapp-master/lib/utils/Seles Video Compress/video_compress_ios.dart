import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'video_compress_agument_model.dart';

class VideoCompressiOSHelper {
  static const platform = MethodChannel('com.workstories.videoCompressChannel');

  Future<bool> checkVideoCompression(
      {required String atPath, required String destinationPath}) async {
    try {
      final arguments = VideoCompressChannelArgumentModel(
          sourcePath: atPath, destinationPath: destinationPath);
      final dynamic result =
          await platform.invokeMethod('compressVideo', arguments.toJson());
      final jsonResult = jsonDecode(result);
      final responseModel =
          VideoCompressChannelArgumentResponseModel.fromMap(jsonResult);
      if (responseModel.error.isEmpty) {
        return true;
      } else {
        debugPrint('Error while compressing ${responseModel.error}');
        return false;
      }
    } catch (e) {
      debugPrint('Error while calling method ${e.toString()}');
      rethrow;
    }
  }
}
