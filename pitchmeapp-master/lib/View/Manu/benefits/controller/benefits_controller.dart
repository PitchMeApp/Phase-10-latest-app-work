import 'dart:developer';

import 'package:get/get.dart';
import 'package:pitch_me_app/View/Manu/benefits/webview.dart';
import 'package:pitch_me_app/devApi%20Service/get_api.dart';
import 'package:pitch_me_app/devApi%20Service/post_api.dart';

import '../../../../utils/extras/extras.dart';

class BenefitsController extends GetxController {
  RxBool isLoading = false.obs;

  RxInt isCheckProUser = 0.obs;
  void generatepaymentApi(context) async {
    isLoading.value = true;
    try {
      await PostApiServer().generatepaymentApi().then((value) {
        //  log('https://uae.paymob.com/unifiedcheckout/?publicKey=${value['private_key']}&clientSecret=${value['result']['client_secret']}');

        if (value['status'] == 1) {
          //are_pk_test_1T35qVuR8mI3p6d5NjozcanRwGmPwxHE
          // launchUrl(
          //     Uri.parse(
          //         'https://uae.paymob.com/unifiedcheckout/?publicKey=${value['private_key']}&clientSecret=${value['result']['client_secret']}'),
          //     mode: LaunchMode.externalApplication);
          Get.off(() => WebViewPage(
                webUrl:
                    'https://uae.paymob.com/unifiedcheckout/?publicKey=${value['private_key']}&clientSecret=${value['result']['client_secret']}',
                clientKey: value['result']['client_secret'].toString(),
                publickKey: value['private_key'],
              ));

          //  startSdk(context, value['result']['token']);
        } else {
          myToast(context, msg: value['message']);
        }

        isLoading.value = false;
      });
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
    }
  }

  void checkProUserApi(context) async {
    isLoading.value = true;
    try {
      await GetApiService().checkProUserApi().then((value) {
        if (value['data'] != null) {
          log(value.toString());
          isCheckProUser.value = value['data'];
        }

        isLoading.value = false;
      });
      isLoading.value = false;
    } catch (e) {
      log(e.toString());
      isCheckProUser.value = 0;
      isLoading.value = false;
    }
  }
}
