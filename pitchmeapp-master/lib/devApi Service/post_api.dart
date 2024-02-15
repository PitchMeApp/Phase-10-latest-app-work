import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:pitch_me_app/core/urls.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/extras/extras.dart';

class PostApiServer {
  Future savedLikeVideoApi(postID, swipeType) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String url = '${BASE_URL}feedback/addpost';
    try {
      final response = await http.post(Uri.parse(url),
          body: jsonEncode({
            "userid": prefs.get('user_id').toString(),
            "postid": postID.toString(),
            "types": swipeType,
          }),
          headers: {
            'Content-Type': 'application/json',
          });
      dynamic data = jsonDecode(response.body);
      // log(url);
      // log('check = ' + data.toString());
      return data;
    } catch (e) {}
  }

  Future updateUserApi() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String url = '${BASE_URL}user/updateUser';
    try {
      final response = await http.post(Uri.parse(url),
          body: jsonEncode({
            "userId": prefs.get('user_id').toString(),
            "username": 'Admin',
          }),
          headers: {
            'Content-Type': 'application/json',
          });
      dynamic data = jsonDecode(response.body);
      // log(url);
      log('check = ' + data.toString());
      return data;
    } catch (e) {}
  }

  Future savedVideoApi(
      BuildContext context, pitchID, receiverid, int flag) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String url = '${BASE_URL}feedback/addsaved';
    //64e88033599d3dd8b1e39f81
    try {
      final response = await http.post(Uri.parse(url),
          body: jsonEncode({
            "senderid": prefs.get('user_id').toString(),
            "receiverid": (receiverid == null)
                ? prefs.get('user_id').toString()
                : receiverid,
            "pitchid": pitchID.toString(),
            "flag": flag,
          }),
          headers: {
            'Content-Type': 'application/json',
          });
      dynamic data = jsonDecode(response.body);
      // log(jsonEncode({
      //   "senderid": prefs.get('user_id').toString(),
      //   "receiverid":
      //       (receiverid == null) ? prefs.get('user_id').toString() : receiverid,
      //   "pitchid": pitchID.toString(),
      //   "flag": flag.toString(),
      // }));
      // log('post data = ' + data.toString());
      if (flag == 0) {
        myToast(context, msg: 'Sent Successfully');
      } else {
        Get.back();
      }

      return data;
    } catch (e) {}
  }

  Future getChatDetailApi(receiverid) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String url = '${BASE_URL}feedback/getchats';

    final response = await http.post(Uri.parse(url),
        body: jsonEncode({
          "senderid": prefs.get('user_id').toString(),
          "recieverid": receiverid,
        }),
        headers: {
          'Content-Type': 'application/json',
        });

    dynamic data = jsonDecode(response.body);

    return data;
  }

  Future postIndustryApi(industry) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String url = '${BASE_URL}industry';

    final response = await http.post(Uri.parse(url),
        body: jsonEncode({
          "name": industry,
          "uploadedby": prefs.get('user_id').toString(),
        }),
        headers: {
          'Content-Type': 'application/json',
        });

    dynamic data = jsonDecode(response.body);

    return data;
  }

  Future postServiceApi(postdata) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String url = '${BASE_URL}services';
    var body = {
      "type": postdata['type'],
      "name": postdata['name'],
      "uploadedby": prefs.get('user_id').toString()
    };

    final response =
        await http.post(Uri.parse(url), body: jsonEncode(body), headers: {
      'Content-Type': 'application/json',
    });

    dynamic data = jsonDecode(response.body);

    return data;
  }

  Future generatepaymentApi() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String url = '${BASE_URL}user/generatepayment';

    final response = await http.post(Uri.parse(url),
        body: jsonEncode({
          "email": prefs.get('email') != null
              ? prefs.get('email').toString()
              : 'developerteam30@gmail.com',
          "log_type": prefs.get('log_type').toString(),
          "membership_plan": "2"
        }),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': "Bearer ${prefs.getString('tok')}"
        });

    dynamic data = jsonDecode(response.body);

    return data;
  }

  Future savedTutorialApi(body) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    dynamic id = prefs.get('user_id').toString();
    String url = '${BASE_URL}user/edit/tutorial/$id';
    try {
      final response =
          await http.put(Uri.parse(url), body: jsonEncode(body), headers: {
        'Content-Type': 'application/json',
      });
      dynamic data = jsonDecode(response.body);

      return data;
    } catch (e) {}
  }

  // Future addSavedIntroVideoApi() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String url = '${BASE_URL}feedback/addsavedintro';
  //   try {
  //     final response = await http.post(Uri.parse(url),
  //         body: jsonEncode({
  //           "senderid": prefs.get('user_id').toString(),
  //         }),
  //         headers: {
  //           'Content-Type': 'application/json',
  //         });
  //     dynamic data = jsonDecode(response.body);
  //     log('add saved = ' + data.toString());

  //     return data;
  //   } catch (e) {}
  // }
}
