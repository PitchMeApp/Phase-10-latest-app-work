import 'package:get/get.dart';
import 'package:pitch_me_app/devApi%20Service/get_api.dart';

class FeebackController extends GetxController {
  RxBool isLoading = false.obs;

  Future readAllNotiApi(id) async {
    isLoading.value = true;
    try {
      await GetApiService().readNotificationApi(id).then((value) {
        isLoading.value = false;
      });
    } catch (e) {
      isLoading.value = false;
    }
  }

  // @override
  // void onInit() {
  //   readAllNotiApi();
  //   super.onInit();
  // }
}
