import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_document_picker/flutter_document_picker.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_pickers/image_pickers.dart';
import 'package:pitch_me_app/utils/extras/extras.dart';

import '../../utils/colors/colors.dart';

class AddImageController extends GetxController {
  List listImagePaths = [];
  List ischackIndex = [
    {'check': false},
    {'check': false},
    {'check': false},
    {'check': false},
  ];
  GalleryMode _galleryMode = GalleryMode.image;

  int count = 4;
  String filePath = "";
  File fileFullPath = File('');

  Future<void> selectImages() async {
    listImagePaths.clear();
    try {
      _galleryMode = GalleryMode.image;
      await ImagePickers.pickerPaths(
        galleryMode: _galleryMode,
        showGif: true,
        selectCount: 3,
        showCamera: true,
        cropConfig: CropConfig(enableCrop: true, height: 1, width: 1),
        compressSize: 500,
        uiConfig: UIConfig(
          uiThemeColor: DynamicColor.gredient1,
        ),
      ).then((value) {
        value.forEach((element) {
          listImagePaths.add(element.path);
        });
      });

      update();
    } on PlatformException {}
  }

  Future<void> selectImage(int index) async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final imageTemporary = File(image.path);
      for (var i = 0; i < ischackIndex.length; i++) {
        if (index == i) {
          if (ischackIndex[i]['check'] != true) {
            ischackIndex[i]['check'] = true;
            listImagePaths.add(imageTemporary.path);
          } else {
            listImagePaths.remove(listImagePaths[i]);
            listImagePaths.add(imageTemporary.path);
          }
        }
      }

      update();
    } on PlatformException catch (e) {}
  }

  Future<void> getDocumnetFile(BuildContext context) async {
    try {
      FlutterDocumentPickerParams params = FlutterDocumentPickerParams(
        allowedFileExtensions: ['pdf', 'doc'],
        invalidFileNameSymbols: ['/'],
      );

      final path = await FlutterDocumentPicker.openDocument(params: params);
      filePath = path.toString();
      fileFullPath = File(path!);
      int sizeInBytes = File(filePath).lengthSync();
      double sizeInMb = sizeInBytes / (1024 * 1024);
      if (sizeInMb > 15) {
        filePath = '';
        fileFullPath = File('');
        myToast(context, msg: 'Note: Maximum 15MB file size allowed');
        update();
        return;
      }
      // FilePickerResult? result = await FilePicker.platform
      //     .pickFiles(allowedExtensions: ['pdf', 'doc'], type: FileType.custom);

      // if (result != null) {
      //   PlatformFile file = result.files.first;
      //   filePath = path.toString();
      //   fileFullPath = File(path!);
      // } else {}
    } on PlatformException {}

    update();
  }
}
