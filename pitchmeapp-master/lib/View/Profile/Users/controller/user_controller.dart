import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../devApi Service/get_api.dart';
import '../../../../screens/businessIdeas/BottomNavigation.dart';
import '../../../../utils/colors/colors.dart';
import '../../../../utils/styles/styles.dart';
import '../../../Add Image Page/controller.dart';
import '../../../Fund Page/fund_neccessar_controller.dart';
import '../../../Funding Phase/fund_phase_cntroller.dart';
import '../../../Location Page/location_page_con.dart';
import '../../../Need page/need_page_controller.dart';
import '../../../Notification/notify_controller.dart';
import '../../../Select industry/industry_controller.dart';
import '../../../navigation_controller.dart';
import '../../../offer_page/controller.dart';
import '../../../video page/Controller/controller.dart';
import '../../../what need/who_need_page_controller.dart';
import '../../Biography/controller/controller.dart';
import '../Model/model.dart';

class UsersController extends GetxController {
  RxBool isLoading = false.obs;

  RxList<Doc> businessIdeaUsersList = RxList([]);
  RxList<Doc> businessOwnerUsersList = RxList([]);
  RxList<Doc> investorUsersList = RxList([]);
  RxList<Doc> facilitatorUsersList = RxList([]);

  NotificationController notificationController =
      Get.put(NotificationController());

  void getAllUsersApiCall() async {
    businessIdeaUsersList.clear();
    businessOwnerUsersList.clear();
    investorUsersList.clear();
    facilitatorUsersList.clear();
    isLoading.value = true;
    try {
      await GetApiService().getAllUsersList().then((value) {
        List<Doc> allUsersList = value.result.docs;
        if (allUsersList.isNotEmpty) {
          for (var item in allUsersList) {
            switch (item.logType) {
              case 1:
                businessIdeaUsersList.value.add(item);
                break;
              case 2:
                businessOwnerUsersList.value.add(item);
                break;
              case 3:
                investorUsersList.value.add(item);
                break;
              case 4:
                facilitatorUsersList.value.add(item);
                break;
              default:
            }
          }
        }
        isLoading.value = false;
      });
      update();
    } catch (e) {
      businessIdeaUsersList.value = [];
      businessOwnerUsersList.value = [];
      investorUsersList.value = [];
      facilitatorUsersList.value = [];
      isLoading.value = false;
    }
    update();
  }

  onselectValue(value, List<Doc> list, BuildContext context) async {
    openDilog();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    for (var i = 0; i < list.length; i++) {
      if (value == i) {
        // log(list[i].toJson().toString());
        if (list[i].isSelected != true) {
          list[i].isSelected = true;

          prefs.remove('industry');
          prefs.remove('location');
          prefs.remove('needs');
          prefs.setString("bot", '1');
          prefs.setString('switch_user', jsonEncode(list[i]));
          prefs.setString("user_id", list[i].id.toString());
          prefs.setString("user_name", list[i].username.toString());
          prefs.setString("tok", list[i].token.toString());
          prefs.setString("log_type", list[i].logType.toString());
          prefs.setBool('hometutorial', list[i].hometutorial);
          prefs.setBool('salespitchtutorial', list[i].salespitchtutorial);
          prefs.setBool('addsalespitchtutoria', list[i].addsalespitchtutoria);
          prefs.setBool('dealtutorial', list[i].dealtutorial);
          prefs.setBool('profiletutorial', list[i].profiletutorial);

          Get.delete<BiographyController>(force: true);
          Get.delete<InsdustryController>(force: true);
          Get.delete<LocationPageController>(force: true);
          Get.delete<WhoNeedController>(force: true);
          Get.delete<FundNacessaryController>(force: true);
          Get.delete<NeedPageController>(force: true);
          Get.delete<OfferPageController>(force: true);
          Get.delete<AddImageController>(force: true);
          Get.delete<VideoFirstPageController>(force: true);
          Get.delete<NavigationController>(force: true);
          Get.delete<FundingPhaseController>(force: true);
          //  Get.delete<SalesPitchFilterController>(force: true);
          // Get.delete<NotificationController>(force: true);
          notificationController.totalNotiCount.value = 0;
          notificationController.post.value.result = [];
          notificationController.timer.cancel();

          Timer(const Duration(seconds: 4), () {
            Get.back();

            Get.offAll(() => Floatbar(0));
            list[i].isSelected = false;
          });

          update();
        } else {
          Get.back();

          list[i].isSelected = false;
          // prefs.remove('switch_user');
          update();
        }
      }
    }

    update();
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
                      'Switch...',
                      style: gredient115,
                    ),
                  ],
                ))));
  }
}
