import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_document_picker/flutter_document_picker.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pitch_me_app/View/Profile/Biography/confirmation_bio.dart';
import 'package:pitch_me_app/View/Profile/Biography/model/model.dart';
import 'package:pitch_me_app/View/Profile/Biography/success_bio.dart';
import 'package:pitch_me_app/core/urls.dart';
import 'package:pitch_me_app/devApi%20Service/get_api.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../utils/extras/extras.dart';

class BiographyController extends GetxController {
  File idImagePath = File('');
  File fackCheckImagePath = File('');
  File profileImagePath = File('');
  File skillImagePath = File('');
  File proofImagePath = File('');
  File signature = File('');

  //String proofFilePath = "";
  String userID = '';
  String location = '';
  String skill = '';
  String education = '';
  String experience = '';
  String wealth = '';
  String add = '';
  String nda = '';

  int idImageStatus = 0;
  int fackCheckImageStatus = 0;

  int skillImageStatus = 0;
  int proofImageStatus = 0;
  int signatureStatus = 0;

  RxBool isLoading = false.obs;
  RxBool isSignature = false.obs;
  BioDoc? bioDoc;

  Future<void> selectImage(String type) async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final imageTemporary = File(image.path);

      switch (type) {
        case 'Id':
          idImagePath = imageTemporary;
          break;
        case 'Profile':
          profileImagePath = imageTemporary;
          break;

        case 'Skill':
          skillImagePath = imageTemporary;
          break;
        default:
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

      proofImagePath = File(path!);
      int sizeInBytes = File(path).lengthSync();
      double sizeInMb = sizeInBytes / (1024 * 1024);
      if (sizeInMb > 15) {
        proofImagePath = File('');
        myToast(context, msg: 'Note: Maximum 15MB file size allowed');
        update();
        return;
      }
      // FilePickerResult? result = await FilePicker.platform
      //     .pickFiles(allowedExtensions: ['pdf', 'doc'], type: FileType.custom);

      // if (result != null) {
      //   // PlatformFile file = result.files.first;
      //   //proofFilePath = result.files.first.name.toString();
      //   proofImagePath = File(result.files.single.path!);
      //   // log(proofFilePath);
      // } else {}
    } on PlatformException {}

    update();
  }

  void handleSaveButtonPressed(signaturePadKey, type) async {
    nda = type;
    final data = await signaturePadKey.currentState!.toImage(pixelRatio: 3.0);
    final bytes = await data.toByteData(format: ui.ImageByteFormat.png);

    try {
      signature = await writeToFile(bytes);
      // log(signature.path);
      Get.to(() => ConfirmationBio());
      update();
    } catch (e) {}
  }

  Future<File> writeToFile(ByteData data) async {
    final buffer = data.buffer;
    Directory tempDir = await getTemporaryDirectory();
    String tempPath = tempDir.path;
    var filePath = tempPath + '/file_01.jpg';
    // log(filePath);
    return File(filePath).writeAsBytes(
        buffer.asUint8List(data.offsetInBytes, data.lengthInBytes));
  }

  Future postBiography(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userID = prefs.get('user_id').toString();
    isLoading.value = true;
    try {
      String url = '${BASE_URL}biography';
      final request = http.MultipartRequest('POST', Uri.parse(url));
      request.fields.addAll({
        'userid': userID,
        'nda': nda,
        'status': '1',
        'ProofFundsstatus': '1',
        'SkillCertificatestatus': '1',
        'Identitystatus': '1',
        'Location': location,
        'Skills': skill,
        'Education': education,
        'Experience': experience,
        'Wealth': wealth,
        'Add': add,
      });

      if (profileImagePath.path.isNotEmpty &&
          profileImagePath.path.contains('https') == false) {
        request.files.add(await http.MultipartFile.fromPath(
            'Picture', profileImagePath.path,
            filename: profileImagePath.path.split('/').last));
      }
      if (idImagePath.path.isNotEmpty &&
          idImagePath.path.contains('https') == false) {
        request.files.add(await http.MultipartFile.fromPath(
          'Identity',
          idImagePath.path,
          filename: idImagePath.path.split('/').last,
        ));
      }
      if (fackCheckImagePath.path.isNotEmpty &&
          fackCheckImagePath.path.contains('https') == false) {
        request.files.add(await http.MultipartFile.fromPath(
          'Face',
          fackCheckImagePath.path,
          filename: fackCheckImagePath.path.split('/').last,
        ));
      }
      if (skillImagePath.path.isNotEmpty &&
          skillImagePath.path.contains('https') == false) {
        request.files.add(await http.MultipartFile.fromPath(
          'SkillCertificate',
          skillImagePath.path,
          filename: skillImagePath.path..split('/').last,
        ));
      }
      if (proofImagePath.path.isNotEmpty &&
          proofImagePath.path.contains('https') == false) {
        request.files.add(await http.MultipartFile.fromPath(
          'ProofFunds',
          proofImagePath.path,
          filename: proofImagePath.path.split('/').last,
        ));
      }
      if (signature.path.contains('https') == false) {
        request.files.add(await http.MultipartFile.fromPath(
          'signature',
          signature.path,
          filename: signature.path.split('/').last,
        ));
      }

      var res = await request.send();
      var response = await res.stream.bytesToString();
      isLoading.value = false;
      var jsonData = jsonDecode(response);
      // log('responce = ' + jsonData.toString());
      if (res.statusCode == 201) {
        myToast(context, msg: jsonData['message']);

        Get.offAll(() => SuccessBioPage());
      } else {
        myToast(context, msg: jsonData['message']);
      }
    } catch (e) {
      isLoading.value = false;
      myToast(context, msg: 'Somthing went wrong');
      log('error = ' + e.toString());
    }
  }

  Future savedUserDetail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userID = prefs.get('user_id').toString();
    try {
      String url = '${BASE_URL}user/edit';
      final request = http.MultipartRequest('PUT', Uri.parse(url));
      request.fields.addAll({
        '_id': userID,
      });
      if (profileImagePath.path.contains('https') == false) {
        request.files.add(await http.MultipartFile.fromPath(
            'profile_pic', profileImagePath.path,
            filename: profileImagePath.path.split('/').last));
      }
      var res = await request.send();
      var response = await res.stream.bytesToString();

      var jsonData = jsonDecode(response);
    } catch (e) {
      log('error = ' + e.toString());
    }
  }

  Future<BioDoc> getBioApi() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    isLoading.value = true;
    try {
      await GetApiService()
          .getUserBioGraphyApi(prefs.get('user_id'))
          .then((value) {
        if (value.result.docs.isNotEmpty) {
          bioDoc = value.result.docs[0];
          // log(bioDoc!.toJson().toString());
          profileImagePath = File(bioDoc!.picture);
          location = bioDoc!.location;
          skill = bioDoc!.skills;
          education = bioDoc!.education;
          experience = bioDoc!.experience;
          wealth = bioDoc!.wealth;
          add = bioDoc!.add;

          if (bioDoc!.identity.isNotEmpty) {
            idImagePath = File(bioDoc!.identity);
            idImageStatus = bioDoc!.identitystatus;
          } else {
            idImagePath = File('https');
            idImageStatus = bioDoc!.identitystatus;
          }
          if (bioDoc!.face.isNotEmpty) {
            fackCheckImagePath = File(bioDoc!.face);
            fackCheckImageStatus = bioDoc!.status;
          } else {
            fackCheckImagePath = File('https');
            fackCheckImageStatus = bioDoc!.status;
          }
          if (bioDoc!.skillCertificate.isNotEmpty) {
            skillImagePath = File(bioDoc!.skillCertificate);
            skillImageStatus = bioDoc!.skillCertificatestatus;
          } else {
            skillImagePath = File('https');
            skillImageStatus = bioDoc!.skillCertificatestatus;
          }
          if (bioDoc!.proofFunds.isNotEmpty) {
            proofImagePath = File(bioDoc!.proofFunds);
            proofImageStatus = bioDoc!.proofFundsstatus;
          } else {
            proofImagePath = File('https');
            proofImageStatus = bioDoc!.proofFundsstatus;
          }

          signature = File(bioDoc!.signature);
          signatureStatus = bioDoc!.signaturestatus;
          nda = bioDoc!.nda;
          // skillImagePath = File(bioDoc!.skills);
          // proofImagePath = File(bioDoc!.proofFunds);
        }

        isLoading.value = false;
      });
    } catch (e) {
      log(e.toString());
      bioDoc = null;
      isLoading.value = false;
    }
    return bioDoc!;
  }
}
