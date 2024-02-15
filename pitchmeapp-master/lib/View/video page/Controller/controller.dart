import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_pickers/image_pickers.dart';
import 'package:pitch_me_app/utils/extras/extras.dart';

import '../../../utils/colors/colors.dart';

class VideoFirstPageController extends GetxController {
  final TextEditingController editingController = TextEditingController();
  RxString videoUrl = ''.obs;

  List<Media> listImagePaths = [];

  Future<void> selectVideos(BuildContext context) async {
    try {
      // FlutterDocumentPickerParams params = FlutterDocumentPickerParams(
      //   allowedFileExtensions: ['mp4', 'MOV', 'WMV', 'WEBM', 'AVI', 'FLV'],
      //   invalidFileNameSymbols: ['/'],
      // );

      // final path = await FlutterDocumentPicker.openDocument(params: params);
      // videoUrl.value = path.toString();

      listImagePaths = await ImagePickers.pickerPaths(
        galleryMode: GalleryMode.video,
        showGif: true,
        selectCount: 1,
        showCamera: true,
        videoSelectMaxSecond: 60,
        cropConfig: CropConfig(enableCrop: true, height: 1, width: 1),
        compressSize: 100,
        uiConfig: UIConfig(
          uiThemeColor: DynamicColor.gredient1,
        ),
      );
      videoUrl.value = listImagePaths[0].path.toString();
      int sizeInBytes = File(listImagePaths[0].path!).lengthSync();
      double sizeInMb = sizeInBytes / (1024 * 1024);
      listImagePaths.clear();
      if (sizeInMb > 15) {
        videoUrl.value = '';
        myToast(context, msg: 'Note: Maximum 15MB file size allowed');
        update();
        return;
      }
      update();
    } on PlatformException {}
  }
}
