import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pitch_me_app/main.dart';
import 'package:pitch_me_app/utils/colors/colors.dart';
import 'package:record/record.dart';

import '../../../../../utils/styles/styles.dart';

class AdminUserChatController extends GetxController {
  File imagePath = File('');

  TextEditingController messageController = TextEditingController();
  dynamic userData;

  RxString filepath = "".obs;
  RxString audioPath = ''.obs;
  RxString downloadFirebaseUrl = ''.obs;
  RxString senderID = ''.obs;
  RxString chatID = ''.obs;
  RxString recieverid = ''.obs;

  RxBool readOnly = false.obs;
  RxBool isloading = false.obs;
  RxBool isKeyboardOpen = false.obs;
  RxBool showPlayer = false.obs;
  RxBool isRecorder = false.obs;

  RxInt recordDuration = 0.obs;
  Rx<Timer> timer = Timer(Duration(seconds: 0), () {}).obs;
  final audioRecorder = AudioRecorder().obs;
  StreamSubscription<RecordState>? recordSub;
  RecordState recordState = RecordState.stop;
  StreamSubscription<Amplitude>? amplitudeSub;
  Amplitude? amplitude;

  late UploadTask task;

  void userID() async {
    senderID.value = 'admin';
  }

  Future<void> selectImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);

      imagePath = File(image!.path);
      downloadUrl(imagePath);
      update();
    } on PlatformException catch (e) {}
  }

  void downloadUrl(File path) async {
    openDilog();
    try {
      String url = 'https://curveinfotech.com/file/upload.php';
      final request = http.MultipartRequest('POST', Uri.parse(url));

      request.files.add(await http.MultipartFile.fromPath(
          'fileToUpload', path.path,
          filename: path.path.split('/').last));

      var res = await request.send();

      var response = await res.stream.bytesToString();

      var jsonData = jsonDecode(response);

      if (jsonData['status'] == 1) {
        print('data = ' + jsonData.toString());
        downloadFirebaseUrl.value = jsonData['data'];
        sendMessage();
        Navigator.of(Get.context!).pop();
      } else {
        Navigator.of(Get.context!).pop();
      }
    } catch (e) {
      Navigator.of(Get.context!).pop();
      print('data 2 = ' + e.toString());
    }
  }

  void downloadAudioUrl(File path) async {
    openDilog();
    try {
      String url = 'https://curveinfotech.com/file/upload.php';
      final request = http.MultipartRequest('POST', Uri.parse(url));

      request.files.add(await http.MultipartFile.fromPath(
          'fileToUpload', path.path.replaceAll('file:///', ''),
          filename: path.path.split('/').last));

      var res = await request.send();

      var response = await res.stream.bytesToString();

      var jsonData = jsonDecode(response);

      if (jsonData['status'] == 1) {
        print('data = ' + jsonData.toString());
        audioPath.value = jsonData['data'];
        sendMessage();
        Navigator.of(Get.context!).pop();
      } else {
        Navigator.of(Get.context!).pop();
      }
    } catch (e) {
      Navigator.of(Get.context!).pop();
      print('data 2 = ' + e.toString());
    }
  }

  // voiceMsg
  String formatNumber(int number) {
    String numberStr = number.toString();
    if (number < 10) {
      numberStr = '0$numberStr';
    }

    return numberStr;
  }

  void startTimer() {
    timer.value.cancel();

    timer.value = Timer.periodic(const Duration(seconds: 1), (Timer t) {
      recordDuration.value++;
      update();
    });
  }

  Future<void> start() async {
    try {
      if (await audioRecorder.value.hasPermission()) {
        // We don't do anything with this but printing
        final isSupported = await audioRecorder.value.isEncoderSupported(
          AudioEncoder.aacLc,
        );
        if (kDebugMode) {
          print('${AudioEncoder.aacLc.name} supported: $isSupported');
        }

        // final devs = await audioRecorder.listInputDevices();
        // final isRecording = await audioRecorder.isRecording();
        final appDocDir = Platform.isAndroid
            ? await getExternalStorageDirectory() //FOR ANDROID
            : await getTemporaryDirectory();
        if (appDocDir != null) {
          var d = DateTime.now().toString();
          String savePath = appDocDir.path + '/Sales-pitch-' + d + ".m4a";
          await audioRecorder.value.start(const RecordConfig(), path: savePath);
          recordDuration.value = 0;

          startTimer();
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Future<void> stop() async {
    timer.value.cancel();
    recordDuration.value = 0;

    final path = await audioRecorder.value.stop();

    if (path != null) {
      audioPath.value = path;
      print('file path = ' + audioPath.value);
      //streamController.add(audioPath.value);
      downloadAudioUrl(File(audioPath.value));
      update();
    }
  }

  Future<void> pause() async {
    timer.value.cancel();
    await audioRecorder.value.pause();
  }

  Future<void> resume() async {
    startTimer();
    await audioRecorder.value.resume();
  }

  void sendMessage() {
    String messageText = messageController.text.trim();

    if (messageText != '' ||
        downloadFirebaseUrl.value != '' ||
        audioPath.value != '' ||
        senderID.value != '') {
      var messagePost = {
        'message': messageText,
        'image': downloadFirebaseUrl.value,
        'voice': audioPath.value,
        'video': '',
        'sendorid': senderID.value,
        'chatid': chatID.value,
        'recieverid': recieverid.value,
      };
      log(messagePost.toString());
      socket.emit('sendmessage_admin', messagePost);
    } else {
      ScaffoldMessenger.of(Get.context!)
          .showSnackBar(const SnackBar(content: Text('Please enter message')));
    }

    downloadFirebaseUrl.value = '';
    messageController.clear();
    audioPath.value = '';
  }

  void openDilog() {
    showDialog(
        barrierDismissible: false,
        context: Get.context!,
        builder: (context) => showLoading());
  }

  Widget showLoading() {
    return Center(
        child: SizedBox(
            height: 170,
            width: 200,
            child: AlertDialog(
                backgroundColor: DynamicColor.lightGrey,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                alignment: Alignment.center,
                content: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(color: DynamicColor.gredient2),
                    SizedBox(height: 20),
                    Text(
                      'Sending',
                      style: gredient115,
                    ),
                  ],
                ))));
  }
}
