import 'package:get/get.dart';

class HomeFilterController extends GetxController {
  List data = [
    {'value': 'Advice', 'isSelected': false},
    {'value': 'Mistakes', 'isSelected': false},
    {'value': 'Strategies', 'isSelected': false},
    {'value': 'Motivational', 'isSelected': false},
    {'value': 'Success Stories', 'isSelected': false},
  ];
  RxList selectedData = RxList([].obs);
  onselectValue(value) {
    for (var i = 0; i < data.length; i++) {
      if (value == i) {
        // log(data[i].toString());
        if (data[i]['isSelected'] != true) {
          selectedData.value.add(data[i]['value']);
          data[i]['isSelected'] = true;

          // getServiceApiCall(data[i]['value'], data[i]['isSelected']);
          update();
        } else {
          data[i]['isSelected'] = false;
          selectedData.value.remove(data[i]['value']);
          // getServiceApiCall(data[i]['value'], data[i]['isSelected']);
          update();
        }
      }
    }
    update();
  }
}
