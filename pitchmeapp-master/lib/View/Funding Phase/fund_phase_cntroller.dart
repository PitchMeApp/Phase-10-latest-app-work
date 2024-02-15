import 'package:get/get.dart';

class FundingPhaseController extends GetxController {
  List fundingFaseList = [
    {'value': 'Pre-Seed'},
    {'value': 'Seed'},
    {'value': 'Series A'},
    {'value': 'Series B'},
    {'value': 'Series C'},
    {'value': 'Series D'},
  ];
  RxString isSelectedFundingPhaseItem = ''.obs;
  RxInt isChecked = 0.obs;

  // onselectFundingPhase(value) {
  //   for (var element in fundingFaseList) {
  //     if (value == element) {
  //       if (element['isSelected'] != true) {
  //         isSelectedFundingPhaseItem.value.add(element['value']);

  //         element['isSelected'] = true;
  //       } else {
  //         element['isSelected'] = false;
  //         isSelectedFundingPhaseItem.value.remove(element['value']);

  //         update();
  //       }

  //       update();
  //     }
  //   }
  // }
}
