import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pitch_me_app/View/Fund%20Page/fund_neccessar_controller.dart';
import 'package:pitch_me_app/View/Need%20page/need_page_controller.dart';

class WhoNeedController extends GetxController {
  int checkColor = 0;
  int checkColor2 = 0;

  List data = [
    {'value': 'Investor', 'icon': Icons.local_atm, 'isSelected': false},
    {'value': 'Service Provider', 'icon': Icons.groups, 'isSelected': false},
  ];
  RxList isSelectedItem = RxList([].obs);
  RxString checkType = ''.obs;
  final FundNacessaryController _fundNacessaryController =
      Get.put(FundNacessaryController());
  final NeedPageController _needPageController = Get.put(NeedPageController());
  onselectItem(value) {
    for (var element in data) {
      if (value == element) {
        if (element['isSelected'] != true) {
          isSelectedItem.value.add(element['value']);
          if (value['value'] == 'Investor') {
            checkColor = 1;
            checkType.value = 'Investor';
          } else if (value['value'] == 'Service Provider') {
            checkColor2 = 2;
            checkType.value = 'Service Provider';
          } else {
            checkColor = 1;
            checkType.value = 'Investor';
          }
          element['isSelected'] = true;
          update();
        } else {
          element['isSelected'] = false;
          isSelectedItem.value.remove(element['value']);
          if (element['value'] == 'Investor') {
            checkColor = 0;
            checkType.value = '';
            _fundNacessaryController.selectedValue.value = '';
            _fundNacessaryController.getValueList.value = [];
            _fundNacessaryController.data[0]['isSelected'] = false;
            _fundNacessaryController.data[1]['isSelected'] = false;
            _fundNacessaryController.data[2]['isSelected'] = false;
            _fundNacessaryController.data[3]['isSelected'] = false;
            _fundNacessaryController.data[4]['isSelected'] = false;
            _fundNacessaryController.data[5]['isSelected'] = false;
            update();
          } else if (value['value'] == 'Service Provider') {
            checkColor2 = 0;
            checkType.value = '';
            _needPageController.searchingSelectedItems.value = [];
            _needPageController.searchingItems.value = [];
            _needPageController.selectedNeedType.value = [];
            _needPageController.data[0]['isSelected'] = false;
            _needPageController.data[1]['isSelected'] = false;
            _needPageController.data[2]['isSelected'] = false;

            update();
          } else {
            checkColor2 = 0;
          }
          update();
        }

        update();
      }
    }
  }
}
