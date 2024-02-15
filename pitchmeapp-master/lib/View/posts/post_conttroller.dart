import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pitch_me_app/View/posts/model.dart';
import 'package:pitch_me_app/devApi%20Service/get_api.dart';

import '../../utils/extras/extras.dart';

class PostController extends GetxController {
  RxBool isLoading = false.obs;
  late SalesPitchListModel salesPitchListModel;

  Future<SalesPitchListModel> getSalesListApi() async {
    isLoading.value = true;
    try {
      await GetApiService().getSalesPiitchListApi().then((value) {
        salesPitchListModel = value;
        isLoading.value = false;
      });
    } catch (e) {
      salesPitchListModel.result!.docs = [];
      isLoading.value = false;
    }
    return salesPitchListModel;
  }

  void deleteApiCall(id, context) async {
    isLoading.value = true;

    try {
      await GetApiService().deleteSalesPittchApi(id).then((value) {
        if (value != null) {
          myToast(context, msg: 'Salespitch has been deleted successfully');

          Navigator.of(context).pop();
        }
      });

      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
    }
  }
}
