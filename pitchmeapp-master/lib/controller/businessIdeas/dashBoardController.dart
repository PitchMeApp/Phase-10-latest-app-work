import 'dart:developer';

import 'package:get/get.dart';
import 'package:pitch_me_app/View/posts/model.dart';
import 'package:pitch_me_app/core/apis/postScreenApi.dart';
import 'package:pitch_me_app/models/post/postModel.dart';
import 'package:pitch_me_app/models/statisticsModel/statisticsModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DashboardController extends GetxController {
  BusinessIdeasApi businessIdeasApi = BusinessIdeasApi();
  var postModel = PostModel().obs,
      hasError = false.obs,
      staticModel = StatisticsModel().obs,
      visibleSaveSeen = false.obs,
      isLoadingPost = false.obs,
      isLoadingPost2 = false.obs,
      isLoadingStats = false.obs,
      isFinish = false.obs,
      isFinish2 = false.obs,
      salespitch = SalesPitchListModel().obs;
  getPost(
      Function(int index, String title, bool isFinish) onSwipe, filter) async {
    try {
      isLoadingPost.value = true;
      hasError.value = false;
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await businessIdeasApi.getPost(filter).then((value) {
        //log(value!.result!.length.toString());
        if (value!.result!.isNotEmpty) {
          var userID = prefs.getString('user_id').toString();
          if (userID.isNotEmpty && userID != 'null') {
            postModel.value = value;
            isLoadingPost.value = false;
            onSwipe(0, postModel.value.result![0].title!.toString(), false);
          } else {
            if (prefs.getString('count_swipe') == null) {
              postModel.value = value;
              isLoadingPost.value = false;
              onSwipe(0, postModel.value.result![0].title!.toString(), false);
            } else {
              var seencount =
                  int.parse(prefs.getString('count_swipe').toString());
              if (value.result != null) {
                var data = value;
                List<Results> list = [];
                var i = 1;
                value.result!.forEach((element) {
                  if (i > seencount) {
                    list.add(element);
                  }
                  i++;
                });

                data.result = list;
                postModel.value = data;
              } else {
                postModel.value = value;
              }
            }
            isLoadingPost.value = false;
            onSwipe(0, postModel.value.result![0].title!.toString(), false);
          }
        } else {
          // Fluttertoast.showToast(
          //     msg: 'check = ' + value!.message!.toString(),
          //     gravity: ToastGravity.CENTER);

          hasError.value = true;
        }
      });
    } catch (e) {
      log("Error at get post is ${e.toString()}");
      // Fluttertoast.showToast(
      //     msg: 'Error at get post is = ' + e.toString(),
      //     gravity: ToastGravity.CENTER);
      isLoadingPost.value = false;
      hasError.value = true;
    }
  }

  getPost2(
    Function(int index, String title, bool isFinish) onSwipe,
  ) async {
    try {
      isLoadingPost2.value = true;
      hasError.value = false;
      await businessIdeasApi.getPost2().then((value) {
        if (value != null) {
          isLoadingPost2.value = false;
          onSwipe(0, value.result!.docs[0].title, false);
          salespitch.value = value;

          // log('message 2');
        } else {
          hasError.value = true;
          salespitch.value.result = null;
          isLoadingPost2.value = false;
        }
      });
    } catch (e) {
      salespitch.value.result = null;
      log("Error at get post is ${e.toString()}");
      isLoadingPost2.value = false;
      hasError.value = true;
    }
  }

  getStatic() async {
    try {
      isLoadingStats.value = true;
      await businessIdeasApi.getStatistics().then((value) {
        isLoadingStats.value = false;
        if (value != null) {
          staticModel.value = value;
        } else {}
      });
    } catch (e) {
      print("Error at get post is ${e.toString()}");
      isLoadingStats.value = false;
    }
  }
}
