import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OfferPageController extends GetxController {
  TextEditingController offrerTextController = TextEditingController();

  RxString selectedPerson = ''.obs;
  RxString selectedPerson2 = ''.obs;
  RxInt checkColor = 0.obs;

  List data = [
    {'value': 'Anyone', 'isSelected': false},
    {'value': 'Only Verified ID', 'isSelected': false},
    {'value': 'Only Verified Funds', 'isSelected': false},
    {'value': 'Only Verified Experience', 'isSelected': false},
    {'value': 'Only with NDA', 'isSelected': false},
  ];

  RxList selectedPersonType = RxList([].obs);
  RxList selectedPersonType2 = RxList([].obs);

  onselectValue(value) {
    for (var i = 0; i < data.length; i++) {
      if (value == i) {
        // log(data[i].toString());
        if (data[i]['isSelected'] != true) {
          selectedPersonType.value.add(data[i]);
          data[i]['isSelected'] = true;

          update();
        } else {
          data[i]['isSelected'] = false;
          selectedPersonType.value.remove(data[i]);
          selectedPerson.value = '';

          update();
        }
      }
      // log(selectedPersonType.value.toString());
    }
    update();
  }

  onselectValueForNomorepitch(value) {
    for (var i = 0; i < data.length; i++) {
      if (value == i) {
        // log(data[i].toString());
        if (data[i]['isSelected'] != true) {
          selectedPersonType2.value.add(data[i]);
          data[i]['isSelected'] = true;

          update();
        } else {
          data[i]['isSelected'] = false;
          selectedPersonType2.value.remove(data[i]);
          selectedPerson2.value = '';

          update();
        }
      }
      // log(selectedPersonType.value.toString());
    }
    update();
  }
}
