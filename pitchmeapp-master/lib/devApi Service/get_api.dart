// dev

import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:pitch_me_app/View/Profile/Biography/model/model.dart';
import 'package:pitch_me_app/View/Profile/Likes/model.dart';
import 'package:pitch_me_app/View/Profile/Pitches/model.dart';
import 'package:pitch_me_app/View/posts/model.dart';
import 'package:pitch_me_app/core/urls.dart';
import 'package:pitch_me_app/models/industry_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../View/Notification/notification_Model.dart';
import '../View/Profile/Biography/controller/controller.dart';
import '../View/Profile/Users/Model/model.dart';
import '../controller/auth/loginController.dart';
import '../screens/auth/loginScreen.dart';
import '../utils/widgets/extras/directVideoViewer.dart';

class GetApiService {
  Future<IndustryModel> getIndusrtyApi() async {
    String url = '${BASE_URL}industry';
    final response = await http.get(Uri.parse(url), headers: {
      'Content-Type': 'application/json',
    });

    IndustryModel data = industryModelFromJson(response.body.toString());

    return data;
  }

  Future<IndustryModel> getServiceApi() async {
    String url = '${BASE_URL}services';

    final response = await http.get(Uri.parse(url), headers: {
      'Content-Type': 'application/json',
    });

    IndustryModel data = industryModelFromJson(response.body.toString());

    return data;
  }

  Future<SalesPitchListModel> getSalesPiitchListApi() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String url = '${BASE_URL}salespitch?userid=${prefs.get('user_id')}';
    final response = await http.get(Uri.parse(url), headers: {
      'Content-Type': 'application/json',
    });
    // log(jsonDecode(response.body).toString());
    SalesPitchListModel data = salesPitchListModelFromJson(response.body);

    return data;
  }

  Future<SavedListModel> getsavedVideoApi() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String url = '${BASE_URL}feedback/getsaved';

    final response = await http.post(Uri.parse(url),
        body: jsonEncode({
          "senderid": prefs.get('user_id').toString(),
        }),
        headers: {
          'Content-Type': 'application/json',
        });
    // log(url.toString());
    // log(prefs.get('user_id').toString());
    // log(response.body.toString());
    SavedListModel data = savedListModelFromJson(response.body);

    return data;
  }

  Future<SavedListModel> getsavedOwnerPitchesApi() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String url = '${BASE_URL}feedback/getownerpitches';

    final response = await http.post(Uri.parse(url),
        body: jsonEncode({
          "senderid": prefs.get('user_id').toString(),
        }),
        headers: {
          'Content-Type': 'application/json',
        });

    SavedListModel data = savedListModelFromJson(response.body);

    return data;
  }

  Future<SavedLikeListModel> getsavedLikeVideoApi() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String url = '${BASE_URL}feedback/getsavedpost';

    final response = await http.post(Uri.parse(url),
        body: jsonEncode(
            {"senderid": prefs.get('user_id').toString(), "types": 1}),
        headers: {
          'Content-Type': 'application/json',
        });

    SavedLikeListModel data = savedLikeListModelFromJson(response.body);

    return data;
  }

  Future<BiogaphyModel> getUserBioGraphyApi(userId) async {
    String url = '${BASE_URL}biography?userid=$userId';
    final response = await http.get(Uri.parse(url), headers: {
      'Content-Type': 'application/json',
    });
    // log(url);
    // log(jsonDecode(response.body).toString());
    BiogaphyModel data = biogaphyModelFromJson(response.body);

    return data;
  }

  Future getUserDetailApi(id) async {
    //SharedPreferences prefs = await SharedPreferences.getInstance();
    String url = '${BASE_URL}feedback/user/$id';
    // log(url);
    final response = await http.get(Uri.parse(url), headers: {
      'Content-Type': 'application/json',
    });

    //SavedListModel data = savedListModelFromJson(response.body);
    dynamic data = jsonDecode(response.body);
    // log('userdata = ' + data.toString());
    return data;
  }

  Future<AllUsersListModel> getAllUsersList() async {
    String url = '${BASE_URL}user/getAllBotUser';

    final response = await http.get(Uri.parse(url), headers: {
      'Content-Type': 'application/json',
    });

    AllUsersListModel data = allUsersListFromJson(response.body);
    //AllUsersListModel.fromJson(json);
    // log(data.result.toJson().toString());
    return data;
  }

  Future shareVideoApi(videoUrl) async {
    String url = '${BASE_URL}user/getvideos?id=$videoUrl';

    final response = await http.get(Uri.parse(url), headers: {
      'Content-Type': 'application/json',
    });

    dynamic data = jsonDecode(response.body);

    return data;
  }

  Future checkProOrbasicUserApi() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String url = '${BASE_URL}user/getUsersMembershipData';

    final response = await http.get(Uri.parse(url), headers: {
      'Content-Type': 'application/json',
      'Authorization': "Bearer ${prefs.getString('tok')}"
    });

    dynamic data = jsonDecode(response.body);
    log('fff = ' + data.toString());
    if (data['result'] != [] && data['result'] != null) {
      if (data['result'][0]['membership_plan'] != null &&
          data['result'][0]['payment_id'] != null &&
          data['result'][0]['subscription_id'] != null &&
          (data['result'][0]['payment_status'] != null &&
              data['result'][0]['payment_status'] == 'paid')) {
        var d = {
          "membership_plan": data['result'][0]['membership_plan'],
          "payment_id": data['result'][0]['payment_id'],
          "subscription_id": data['result'][0]['subscription_id'],
          "payment_status": data['result'][0]['payment_status']
        };
        prefs.setString('pro_user', jsonEncode(d.toString()));
        // log('fjfjf = ' + d.toString());
      }
    }
    if (data['message'] == 'Auth fail') {
      prefs.clear();
      //pref.erase();
      videoViewerControllerList.clear();
      Get.delete<BiographyController>(force: true);
      Timer(const Duration(milliseconds: 600), () {
        Get.offAll(() => LoginScreen(), binding: LoginBinding());
      });
    }

    return data;
  }

  Future countApi() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userId = prefs.get('user_id').toString();

    String url = '${BASE_URL}user/countdata/$userId';
    // log(url);
    final response = await http.get(Uri.parse(url), headers: {
      'Content-Type': 'application/json',
    });

    dynamic data = jsonDecode(response.body);
    // log(data.toString());
    return data;
  }

  Future<notification?> getAllNotificationList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String url =
        '${BASE_URL}notification/getlimited?id=${prefs.get('user_id')}';
    // log(url);
    final response = await http.get(Uri.parse(url), headers: {
      'Content-Type': 'application/json',
    });

    notification data = notification.fromJson(json.decode(response.body));

    return data;
  }

  Future getStatusApi(publickKey, clientSecret) async {
    String url =
        'https://uae.paymob.com/v1/intention/element/$publickKey/$clientSecret';
    log('paymobe = ' + url);
    final response = await http.get(
      Uri.parse(url),
    );

    dynamic data = jsonDecode(response.body);

    return data;
  }

  Future updateMembershipApi() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String url =
        '${BASE_URL}user/updatemembership/${prefs.get('user_id')}?status=paid';

    final response = await http.get(
      Uri.parse(url),
    );

    dynamic data = jsonDecode(response.body);

    return data;
  }

  Future checkProUserApi() async {
    //  SharedPreferences prefs = await SharedPreferences.getInstance();
    String url = '${BASE_URL}user/probutton';

    final response = await http.get(
      Uri.parse(url),
    );

    dynamic data = jsonDecode(response.body);

    return data;
  }

  // Future getSavedTutorialApi() async {
  //   //  SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String url = '${BASE_URL}user/probutton';

  //   final response = await http.get(
  //     Uri.parse(url),
  //   );

  //   dynamic data = jsonDecode(response.body);

  //   return data;
  // }
  // DELETE

  Future deleteSalesPittchApi(id) async {
    String url = '${BASE_URL}salespitch/$id';
    final response = await http.delete(Uri.parse(url), headers: {
      'Content-Type': 'application/json',
    });

    dynamic data = jsonDecode(response.body);

    return data;
  }

  Future deleteLikeVideoApi(id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String url = '${BASE_URL}feedback/post/$id/${prefs.get('user_id')}';
    // log(url);
    final response = await http.delete(Uri.parse(url), headers: {
      'Content-Type': 'application/json',
    });
    //log(response.body);
    dynamic data = jsonDecode(response.body);

    return data;
  }

  Future deleteSavedVideoApi(id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String url = '${BASE_URL}feedback/pitch/$id/${prefs.get('user_id')}';
    final response = await http.delete(Uri.parse(url), headers: {
      'Content-Type': 'application/json',
    });

    dynamic data = jsonDecode(response.body);

    return data;
  }

  Future deleteUserAccountApi() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String url = '${BASE_URL}user/deleteall/${prefs.get('user_id')}';

    final response = await http.get(Uri.parse(url), headers: {
      'Content-Type': 'application/json',
    });

    dynamic data = jsonDecode(response.body);

    return data;
  }

  // put
  Future readNotificationApi(id) async {
    String url = '${BASE_URL}notification/read/$id';

    final response = await http.put(Uri.parse(url), headers: {
      'Content-Type': 'application/json',
    });

    dynamic data = jsonDecode(response.body);

    return data;
  }

  Future readAllNotificationApi() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String url = '${BASE_URL}notification/readall/${prefs.get('user_id')}';

    final response = await http.put(Uri.parse(url), headers: {
      'Content-Type': 'application/json',
    });

    dynamic data = jsonDecode(response.body);

    return data;
  }
}
