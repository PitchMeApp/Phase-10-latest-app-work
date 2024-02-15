import 'dart:developer';

import 'package:get/get.dart';
import 'package:pitch_me_app/View/Profile/Biography/model/model.dart';
import 'package:pitch_me_app/devApi%20Service/get_api.dart';
import 'package:pitch_me_app/devApi%20Service/post_api.dart';

class HomeBiographyController extends GetxController {
  int skillImageStatus = 0;
  int proofImageStatus = 0;
  int signatureStatus = 0;
  int idImageStatus = 0;
  int fackCheckImageStatus = 0;

  RxString userName = ''.obs;
  RxString logType = ''.obs;
  RxString location = ''.obs;
  RxString skill = ''.obs;
  RxString education = ''.obs;
  RxString experience = ''.obs;
  RxString wealth = ''.obs;
  RxString add = ''.obs;

  RxBool isLoading = false.obs;

  BioDoc? bioDoc;

  RxList getChat = [].obs;

  Future<BioDoc> getBioApi(userID) async {
    isLoading.value = true;
    try {
      await GetApiService().getUserBioGraphyApi(userID).then((value) {
        if (value.result.docs.isNotEmpty) {
          bioDoc = value.result.docs[0];

          idImageStatus = bioDoc!.identitystatus;
          fackCheckImageStatus = bioDoc!.status;
          skillImageStatus = bioDoc!.skillCertificatestatus;
          proofImageStatus = bioDoc!.proofFundsstatus;
          proofImageStatus = bioDoc!.proofFundsstatus;
          userName.value = bioDoc!.user.username!;
          location.value = bioDoc!.location;
          skill.value = bioDoc!.skills;
          education.value = bioDoc!.education;
          experience.value = bioDoc!.experience;
          wealth.value = bioDoc!.wealth;
          add.value = bioDoc!.add;
          getUserType(bioDoc!.user.loginType);
          // skillImagePath = File(bioDoc!.skills);
          // proofImagePath = File(bioDoc!.proofFunds);
          isLoading.value = false;
        }
        if (value.user != null) {
          getUserType(value.user.logType);
          userName.value = value.user.username;
        }
        isLoading.value = false;
        update();
      });
    } catch (e) {
      log(e.toString());
      bioDoc = null;
      isLoading.value = false;
      logType.value = '';
    }
    return bioDoc!;
  }

  Future getUserType(type) async {
    if (type == 1) {
      logType.value = 'Business Idea';
    } else if (type == 2) {
      logType.value = 'Business Owner';
    } else if (type == 3) {
      logType.value = 'Investor';
    } else if (type == 4) {
      logType.value = 'Service Provider';
    } else {
      logType.value = 'Admin';
    }
  }

  Future getChatApi(reseverID) async {
    try {
      await PostApiServer().getChatDetailApi(reseverID).then((value) {
        getChat.value = value['result'];
        isLoading.value = false;
      });
    } catch (e) {
      isLoading.value = false;
    }
  }
}
