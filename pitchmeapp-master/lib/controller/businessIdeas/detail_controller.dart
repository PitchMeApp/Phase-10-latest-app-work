import 'package:get/get.dart';
import 'package:pitch_me_app/View/posts/model.dart';
import 'package:pitch_me_app/core/apis/postScreenApi.dart';

class DetailController extends GetxController {
  BusinessIdeasApi businessIdeasApi = BusinessIdeasApi();

  var salespitch = SalesPitchListModel().obs;

  getSalesPitchDataApi() async {
    try {
      await businessIdeasApi.getPost2().then((value) {
        if (value != null) {
          salespitch.value = value;

          // log('message 2');
        } else {
          salespitch.value.result = null;
        }
      });
    } catch (e) {
      salespitch.value.result = null;
    }
  }
}
