import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:flutter_beep/flutter_beep.dart';
import 'package:get/get.dart';

import '../../../devApi Service/get_api.dart';
import 'notification_Model.dart';

class NotificationController extends GetxController {
  var post = notification().obs;
  RxInt totalNotiCount = 0.obs;
  RxBool isLoading = true.obs;
  Timer timer = Timer(const Duration(seconds: 0), () {});

  Future<notification> getAllNotificationListApi(BuildContext context) async {
    // isLoading.value = false;
    try {
      await GetApiService().getAllNotificationList().then((value) {
        //log(value!.toJson().toString());
        post.value = value!;
        if (post.value.unreadNotification! > totalNotiCount.value) {
          if (Platform.isAndroid) {
            FlutterBeep.playSysSound(AndroidSoundIDs.TONE_SUP_RADIO_NOTAVAIL);
          } else {
            FlutterBeep.playSysSound(iOSSoundIDs.SMSReceived_Alert1);
          }
        }
        totalNotiCount.value = post.value.unreadNotification!;
        //  log('total = ' + totalNotiCount.value.toString());
        update();
        isLoading.value = false;
      });
    } catch (e) {
      post.value.result = [];
      totalNotiCount.value = 0;
      isLoading.value = false;
      timer.cancel();
    }
    return post.value;
  }

  void startTimer(BuildContext context) {
    post.value.result = [];
    getAllNotificationListApi(context);
    timer.cancel();
    try {
      timer = Timer.periodic(const Duration(seconds: 3), (timer) {
        getAllNotificationListApi(context);
        //  log('count = ' + timer.tick.toString());
      });
    } catch (e) {
      log('notify = ' + e.toString());
      timer.cancel();
      timer = Timer.periodic(const Duration(seconds: 3), (timer) {
        getAllNotificationListApi(context);
        // log('count = ' + timer.tick.toString());
      });
      // log('error = ' + e.toString());
    }

    update();
  }

  void closeTimer(BuildContext context) {
    // timer.cancel();
    if (Platform.isAndroid) {
      post.value.result = [];
      totalNotiCount.value = 0;
    }

    update();
    log('timer close');
  }

  @override
  void onInit() {
    super.onInit();
    startTimer(Get.context!);
  }

  @override
  void onClose() {
    super.onClose();
    closeTimer(Get.context!);
    log('close timer close');
  }

  @override
  void dispose() {
    super.dispose();
    closeTimer(Get.context!);
    log('dispose timer close');
  }
}
