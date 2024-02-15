import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FundNacessaryController extends GetxController {
  final scrollController = FixedExtentScrollController(initialItem: 3);

  dynamic industryList;
  RxList checkItem = RxList([].obs);
  RxList getValueList = RxList([].obs);

  RxInt chengeIndexColor = 3.obs;
  RxInt selectedRang = 0.obs;

  RxString selectedValue = ''.obs;
  List data = [
    {'value': '<50K', 'divide_by': '1', 'isSelected': false},
    {'value': '50K-100K', 'divide_by': '2', 'isSelected': false},
    {'value': '100K-500K', 'divide_by': '3', 'isSelected': false},
    {'value': '500K-1Mil', 'divide_by': '4', 'isSelected': false},
    {'value': '1Mil-10Mil', 'divide_by': '5', 'isSelected': false},
    {'value': '>10Mil', 'divide_by': '6', 'isSelected': false},
  ];

  onselectAmount(value, index) {
    //industryList.value.clear();

    for (var element in data) {
      if (value == element) {
        if (element['isSelected'] != true) {
          checkItem.value.add(element);

          element['isSelected'] = true;
          checkValue(value['value'], value['isSelected']);
        } else {
          element['isSelected'] = false;

          checkItem.value.remove(element);
          checkValue(value['value'], value['isSelected']);

          update();
        }

        update();
      }
    }
  }

  checkValue(index, isSelected) {
    switch (index) {
      case '<50K':
        // firstNumber = 5000;
        // secondNumber = 50000;
        // for (var i = firstNumber; i <= secondNumber; i++) {
        //   if (i % int.parse(divideBy) == 0) {
        //     industryList.add(i);
        //   }
        // }
        industryList = {
          {
            'range': "5.000",
            'value': 5000,
          },
          {
            'range': "10.000",
            'value': 10000,
          },
          {
            'range': "15.000",
            'value': 15000,
          },
          {
            'range': "20.000",
            'value': 20000,
          },
          {
            'range': "25.000",
            'value': 25000,
          },
          {
            'range': "30.000",
            'value': 30000,
          },
          {
            'range': "35.000",
            'value': 35000,
          },
          {
            'range': "40.000",
            'value': 40000,
          },
          {
            'range': "45.000",
            'value': 45000,
          },
        };

        if (isSelected == true) {
          for (var element in industryList) {
            getValueList.add(element);
          }

          update();
        } else {
          for (var element in industryList) {
            for (var i = 0; i < getValueList.length; i++) {
              if (getValueList[i]['range'] == element['range']) {
                getValueList.removeAt(i);
              }
            }
          }

          update();
        }

        break;
      case '50K-100K':
        industryList = {
          {
            'range': "50.000",
            'value': 50000,
          },
          {
            'range': "55.000",
            'value': 55000,
          },
          {
            'range': "60.000",
            'value': 60000,
          },
          {
            'range': "65.000",
            'value': 65000,
          },
          {
            'range': "70.000",
            'value': 70000,
          },
          {
            'range': "75.000",
            'value': 75000,
          },
          {
            'range': "80.000",
            'value': 80000,
          },
          {
            'range': "85.000",
            'value': 85000,
          },
          {
            'range': "90.000",
            'value': 90000,
          },
          {
            'range': "95.000",
            'value': 95000,
          },
          {
            'range': "100.000",
            'value': 100000,
          },
        };

        if (isSelected == true) {
          for (var element in industryList) {
            getValueList.add(element);
          }

          update();
        } else {
          for (var element in industryList) {
            for (var i = 0; i < getValueList.length; i++) {
              if (getValueList[i]['range'] == element['range']) {
                getValueList.removeAt(i);
              }
            }
          }

          update();
        }
        break;
      case '100K-500K':
        industryList = {
          {
            'range': "200.000",
            'value': 200000,
          },
          {
            'range': "300.000",
            'value': 300000,
          },
          {
            'range': "400.000",
            'value': 400000,
          },
          {
            'range': "500.000",
            'value': 500000,
          },
        };

        if (isSelected == true) {
          for (var element in industryList) {
            getValueList.add(element);
          }

          update();
        } else {
          for (var element in industryList) {
            for (var i = 0; i < getValueList.length; i++) {
              if (getValueList[i]['range'] == element['range']) {
                getValueList.removeAt(i);
              }
            }
          }

          update();
        }
        break;
      case '500K-1Mil':
        industryList = {
          {
            'range': "600.000",
            'value': 600000,
          },
          {
            'range': "700.000",
            'value': 700000,
          },
          {
            'range': "800.000",
            'value': 800000,
          },
          {
            'range': "900.000",
            'value': 900000,
          },
          {
            'range': "1Mil",
            'value': 1000000,
          },
        };

        if (isSelected == true) {
          for (var element in industryList) {
            getValueList.add(element);
          }

          update();
        } else {
          for (var element in industryList) {
            for (var i = 0; i < getValueList.length; i++) {
              if (getValueList[i]['range'] == element['range']) {
                getValueList.removeAt(i);
              }
            }
          }

          update();
        }
        break;
      case '1Mil-10Mil':
        industryList = {
          {
            'range': "2Mil",
            'value': 2000000,
          },
          {
            'range': "3Mil",
            'value': 3000000,
          },
          {
            'range': "4Mil",
            'value': 4000000,
          },
          {
            'range': "5Mil",
            'value': 5000000,
          },
          {
            'range': "6Mil",
            'value': 6000000,
          },
          {
            'range': "7Mil",
            'value': 7000000,
          },
          {
            'range': "8Mil",
            'value': 8000000,
          },
          {
            'range': "9Mil",
            'value': 9000000,
          },
          {
            'range': "10Mil",
            'value': 10000000,
          },
        };

        if (isSelected == true) {
          for (var element in industryList) {
            getValueList.add(element);
          }

          update();
        } else {
          for (var element in industryList) {
            for (var i = 0; i < getValueList.length; i++) {
              if (getValueList[i]['range'] == element['range']) {
                getValueList.removeAt(i);
              }
            }
          }

          update();
        }
        break;
      case '>10Mil':
        industryList = {
          {
            'range': "20Mil",
            'value': 20000000,
          },
          {
            'range': "30Mil",
            'value': 30000000,
          },
          {
            'range': "40Mil",
            'value': 40000000,
          },
          {
            'range': "50Mil",
            'value': 50000000,
          },
          {
            'range': "60Mil",
            'value': 60000000,
          },
          {
            'range': "70Mil",
            'value': 70000000,
          },
          {
            'range': "80Mil",
            'value': 80000000,
          },
          {
            'range': "90Mil",
            'value': 90000000,
          },
          {
            'range': "100Mil",
            'value': 100000000,
          },
        };

        if (isSelected == true) {
          for (var element in industryList) {
            getValueList.add(element);
          }

          update();
        } else {
          for (var element in industryList) {
            for (var i = 0; i < getValueList.length; i++) {
              if (getValueList[i]['range'] == element['range']) {
                getValueList.removeAt(i);
              }
            }
          }

          update();
        }

        break;
      default:
    }
    getValueList.sort((a, b) {
      return a['value'].compareTo(b['value']);
    });
    update();
  }
}
