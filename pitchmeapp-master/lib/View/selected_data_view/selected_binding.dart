import 'package:get/get.dart';

import 'selected_controller.dart';

class SelectedBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SelectedController>(() => SelectedController());
  }
}
