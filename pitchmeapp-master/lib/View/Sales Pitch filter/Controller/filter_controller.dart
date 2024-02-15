import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../devApi Service/get_api.dart';
import '../../../models/industry_model.dart';

class SalesPitchFilterController extends GetxController {
  Map finalSelectedData = {
    'industry': null,
    'location': null,
    'needs': null,
  };

  @override
  void onInit() {
    getIndustryApiCall();
    super.onInit();
  }

//Industry

  RxList selectedIndustrys = RxList([]);
  TextEditingController industryTextController = TextEditingController();
  RxBool hideList = false.obs;

  late IndustryModel industryList;

  Future<IndustryModel> getIndustryApiCall() async {
    try {
      await GetApiService().getIndusrtyApi().then((value) {
        industryList = value;
      });
    } catch (e) {
      industryList.result.docs = [];
    }
    return industryList;
  }

  //location
  TextEditingController searchController = TextEditingController();
  RxString selectedLocation = ''.obs;
  RxString customText = ''.obs;
  RxString placeAddress = ''.obs;
  RxInt checkColor = 0.obs;
  RxInt openSearchBox = 0.obs;
  RxDouble currentLatitude = 0.0.obs;
  RxDouble currentLongitude = 0.0.obs;
  RxDouble placeLatitude = 0.0.obs;
  RxDouble placeLongitude = 0.0.obs;

  // Need

  // a) Investor

  // final WhoNeedController investorAndServicePrviderController =
  //     Get.put(WhoNeedController());
  // final FundNacessaryController investorFundRangeController =
  //     Get.put(FundNacessaryController());

  int needCheckColor = 0;
  int needCheckColor2 = 0;

  List investorAndSpList = [
    {'value': 'Investor', 'isSelected': false},
    {'value': 'Service Provider', 'isSelected': false},
  ];
  List rangAndPhaseList = [
    {'value': 'Funds Range', 'isSelected': false},
    {'value': 'Funding Phase', 'isSelected': false},
  ];
  List fundingFaseList = [
    {'value': 'Pre-Seed', 'isSelected': false},
    {'value': 'Seed', 'isSelected': false},
    {'value': 'Series A', 'isSelected': false},
    {'value': 'Series B', 'isSelected': false},
    {'value': 'Series C', 'isSelected': false},
    {'value': 'Series D', 'isSelected': false},
  ];
  List rangListdata = [
    {'value': '<50K', 'divide_by': '1', 'isSelected': false},
    {'value': '50K-100K', 'divide_by': '2', 'isSelected': false},
    {'value': '100K-500K', 'divide_by': '3', 'isSelected': false},
    {'value': '500K-1Mil', 'divide_by': '4', 'isSelected': false},
    {'value': '1Mil-10Mil', 'divide_by': '5', 'isSelected': false},
    {'value': '>10Mil', 'divide_by': '6', 'isSelected': false},
  ];

  RxList investorAndSpItem = RxList([].obs);
  RxList isSelecetRangList = RxList([].obs);
  RxList isSelectedFundingPhaseItem = RxList([].obs);
  RxList isSelectedNeeds = RxList([].obs);

  onselectinvestorAndSpItem(value) {
    for (var element in investorAndSpList) {
      if (value == element) {
        if (element['isSelected'] != true) {
          investorAndSpItem.value.add(element['value']);
          if (value['value'] == 'Investor') {
            needCheckColor = 1;
          } else if (value['value'] == 'Service Provider') {
            needCheckColor2 = 2;
          } else {
            needCheckColor = 1;
          }
          element['isSelected'] = true;
          update();
        } else {
          element['isSelected'] = false;
          investorAndSpItem.value.remove(element['value']);
          if (element['value'] == 'Investor') {
            needCheckColor = 0;
            // checkType.value = '';
            // _fundNacessaryController.selectedValue.value = '';
            // _fundNacessaryController.getValueList.value = [];
            // _fundNacessaryController.data[0]['isSelected'] = false;
            // _fundNacessaryController.data[1]['isSelected'] = false;
            // _fundNacessaryController.data[2]['isSelected'] = false;
            // _fundNacessaryController.data[3]['isSelected'] = false;
            // _fundNacessaryController.data[4]['isSelected'] = false;
            // _fundNacessaryController.data[5]['isSelected'] = false;
            update();
          } else if (value['value'] == 'Service Provider') {
            // checkColor2 = 0;
            // checkType.value = '';
            // _needPageController.searchingSelectedItems.value = [];
            // _needPageController.searchingItems.value = [];
            // _needPageController.selectedNeedType.value = [];
            // _needPageController.data[0]['isSelected'] = false;
            // _needPageController.data[1]['isSelected'] = false;
            // _needPageController.data[2]['isSelected'] = false;

            update();
          } else {
            needCheckColor2 = 0;
          }
          update();
        }

        update();
      }
    }
  }

  onselectRangAndFundsItem(value) {
    for (var element in rangAndPhaseList) {
      if (value == element) {
        if (element['isSelected'] != true) {
          isSelectedNeeds.value.add(element['value']);
          element['isSelected'] = true;
          update();
        } else {
          element['isSelected'] = false;
          isSelectedNeeds.value.remove(element['value']);
          update();
        }

        update();
      }
    }
  }

  onselectRangAmount(value) {
    for (var element in rangListdata) {
      if (value == element) {
        if (element['isSelected'] != true) {
          isSelecetRangList.value.add(element);

          element['isSelected'] = true;
        } else {
          element['isSelected'] = false;

          isSelecetRangList.value.remove(element);

          update();
        }

        update();
      }
    }
  }

  onselectNeedsFundingPhase(value) {
    for (var element in fundingFaseList) {
      if (value == element) {
        if (element['isSelected'] != true) {
          isSelectedFundingPhaseItem.value.add(element['value']);

          element['isSelected'] = true;
        } else {
          element['isSelected'] = false;
          isSelectedFundingPhaseItem.value.remove(element['value']);

          update();
        }

        update();
      }
    }
  }

// b) Service Provider

  TextEditingController spTextController = TextEditingController();
  RxList searchingItemsSP = RxList([]);
  RxList searchingSelectedItemsSP = RxList([]);
  RxList selectedNeedTypeSP = RxList([].obs);

  RxString spCustomText = ''.obs;

  List spListdata = [
    {'value': 'Skill', 'isSelected': false},
    {'value': 'Service', 'isSelected': false},
    {'value': 'Connection', 'isSelected': false},
  ];
  List spListdata2 = [
    {'value': 'Take Over', 'isSelected': false},
    {'value': 'Buy Out', 'isSelected': false},
  ];

  spOnselectValue(value) {
    for (var i = 0; i < spListdata.length; i++) {
      if (value == i) {
        // log(spListdata[i].toString());
        if (spListdata[i]['isSelected'] != true) {
          selectedNeedTypeSP.value.add(spListdata[i]);
          spListdata[i]['isSelected'] = true;
          spListdata2[0]['isSelected'] = false;
          spListdata2[1]['isSelected'] = false;
          selectedNeedTypeSP.value.remove(spListdata2[0]);
          selectedNeedTypeSP.value.remove(spListdata2[1]);
          getServiceApiCall(
              spListdata[i]['value'], spListdata[i]['isSelected']);
          update();
        } else {
          spListdata[i]['isSelected'] = false;
          selectedNeedTypeSP.value.remove(spListdata[i]);
          getServiceApiCall(
              spListdata[i]['value'], spListdata[i]['isSelected']);
          update();
        }
      }
    }
    log(selectedNeedTypeSP.value.toString());
    update();
  }

  spOnselectValue2(value, secondIndex) {
    for (var i = 0; i < spListdata2.length; i++) {
      if (value == i) {
        // log(spListdata[i].toString());
        if (spListdata2[i]['isSelected'] != true) {
          selectedNeedTypeSP.value.add(spListdata2[i]);

          spListdata2[i]['isSelected'] = true;
          spListdata2[secondIndex]['isSelected'] = false;
          selectedNeedTypeSP.value.remove(spListdata2[secondIndex]);
          selectedNeedTypeSP.value.remove(spListdata[0]);
          selectedNeedTypeSP.value.remove(spListdata[1]);
          selectedNeedTypeSP.value.remove(spListdata[2]);

          spListdata[0]['isSelected'] = false;
          spListdata[1]['isSelected'] = false;
          spListdata[2]['isSelected'] = false;
          update();
        } else {
          spListdata2[i]['isSelected'] = false;
          selectedNeedTypeSP.value.remove(spListdata2[i]);

          update();
        }
      }
    }
    // log(selectedNeedTypeSP.value.toString());
    update();
  }

  Future<List> getServiceApiCall(type, isChecked) async {
    try {
      await GetApiService().getServiceApi().then((value) {
        var data = value.result.docs;
        for (var i = 0; i < data.length; i++) {
          if (isChecked == true) {
            if (type == data[i].type) {
              // log('add = ' + data[i].toJson().toString());
              searchingItemsSP.add(data[i].name);
              update();
            }
          } else {
            if (type == data[i].type) {
              searchingItemsSP.remove(data[i].name);
              //log('remove = ' + data[i].type.toString());
              update();
            }
          }
        }

        //log(searchingItems.toString());
      });
    } catch (e) {
      //log('check = ' + e.toString());
      searchingItemsSP.value = [];
    }
    return searchingItemsSP;
  }
}
