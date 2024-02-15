import 'dart:developer';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';

class FirebaseApi {
  static UploadTask? uploadFile(String desti, File file) {
    try {
      print('check = ' + File(file.path).toString());
      final ref = FirebaseStorage.instance.ref(desti);
      return ref.putFile(File(file.path));
    } on FirebaseException catch (e) {
      log('file error = ' + e.toString());
      return null;
    }
  }

  static UploadTask? uploadPDF(String desti, Uint8List filebytes) {
    try {
      final ref = FirebaseStorage.instance.ref(desti);
      return ref.putData(filebytes);
    } on FirebaseException catch (e) {
      return null;
    }
  }
}
