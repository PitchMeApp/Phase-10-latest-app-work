import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:pitch_me_app/View/posts/model.dart';
import 'package:pitch_me_app/core/urls.dart';
import 'package:pitch_me_app/models/post/postModel.dart';
import 'package:pitch_me_app/models/statisticsModel/statisticsModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../View/Sales Pitch filter/Controller/filter_controller.dart';

class BusinessIdeasApi extends GetConnect {
  SalesPitchFilterController salesPitchFilterController =
      Get.put(SalesPitchFilterController());
  Future<PostModel?> getPost(filter) async {
    String category = filter
        .toString()
        .replaceAll('[', '')
        .replaceAll(']', '')
        .replaceAll(' ', '');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      var res;

      var userID = prefs.getString('user_id').toString();
      if (userID.isNotEmpty && userID != 'null') {
        res = await get('$GET_POST_DATA_URL?user=$userID&category=$category');
      } else {
        res = await get(GET_POST_DATA_URL);
      }

      //  log("Res is at getPost = " + res.body.toString());

      if (res.statusCode == 200) {
        return PostModel.fromJson(res.body);
      }
    } catch (e) {
      log('error = ' + e.toString());
      return null;
    }

    return null;
  }

  Future<SalesPitchListModel?> getPost2() async {
    //&user=6446703bc5ede4e5e1838933
    var res;
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var userID = prefs.getString('user_id').toString();
    var bussinessType = prefs.getString('log_type').toString();
    var industry = jsonDecode(prefs.getString('industry').toString());
    var location = prefs.getString('location').toString();
    var needs = jsonDecode(prefs.getString('needs').toString());
    String customIndustry = '';
    String selectedLocation = '';
    String investorSp = '';
    String rangValue = '';
    String fundingPhase = '';
    String service = '';
    String serviceSearched = '';
    if (industry != null) {
      customIndustry = industry
          .toString()
          .replaceAll('[', '')
          .replaceAll(']', '')
          .replaceAll(', ', ',');
    }
    if (location != 'null' && location.isNotEmpty) {
      selectedLocation = location;
    }
    if (needs != null) {
      //log('need = ' + needs.toString());
      investorSp = needs['investor_sp']
          .toString()
          .replaceAll('[', '')
          .replaceAll(']', '')
          .replaceAll(', ', ',');
      if (needs['fund_rang'] != []) {
        rangValue = needs['fund_rang']
            .toString()
            .replaceAll('[', '')
            .replaceAll(']', '')
            .replaceAll(', ', ',');
      }
      if (needs['service_provider_type'] != []) {
        service = needs['service_provider_type']
            .toString()
            .replaceAll('[', '')
            .replaceAll(']', '')
            .replaceAll(', ', ',');
      }
      if (needs['service_provider_searched'] != []) {
        serviceSearched = needs['service_provider_searched']
            .toString()
            .replaceAll('[', '')
            .replaceAll(']', '')
            .replaceAll(', ', ',');
      }
      //  log(needs.toString());
      if (needs['fund_phase'] != []) {
        fundingPhase = needs['fund_phase']
            .toString()
            .replaceAll('[', '')
            .replaceAll(']', '')
            .replaceAll(', ', ',');
      }
    }

    // log(fundingPhase.toString());

    log('${BASE_URL}salespitch?type=2&user=$userID&usertype=$bussinessType&industry=$customIndustry&location=$selectedLocation&types=$investorSp&valueamount=$rangValue&fundingPhase=$fundingPhase&services=$service&servicesDetail=$serviceSearched');
    if (userID.isNotEmpty && userID != 'null') {
      res = await get(
          '${BASE_URL}salespitch?type=2&user=$userID&usertype=$bussinessType&industry=$customIndustry&location=$selectedLocation&types=$investorSp&valueamount=$rangValue&fundingPhase=$fundingPhase&services=$service&servicesDetail=$serviceSearched');
    } else {
      res = await get('${BASE_URL}salespitch?type=2');
    }
    // log('${BASE_URL}salespitch?type=2&user=$userID&usertype=$bussinessType');
    // log("Res is at getPost = " + res.body.toString());
    if (res.statusCode == 200) {
      return SalesPitchListModel.fromJson(res.body);
    }
    return null;
  }

  Future<StatisticsModel?> getStatistics() async {
    var res = await get(GET_STASTICS_URL);
    //log("Res is at getStatistics ${res.body}");
    if (res.statusCode == 200 || res.statusCode == 201) {
      return StatisticsModel.fromJson(res.body);
    }
    return null;
  }
}
