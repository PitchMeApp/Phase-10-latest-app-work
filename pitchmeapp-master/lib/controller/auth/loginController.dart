import 'dart:convert';
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:pitch_me_app/controller/selectionController.dart';
import 'package:pitch_me_app/core/apis/authApis.dart';
import 'package:pitch_me_app/core/signin/appleSiugnIn.dart';
import 'package:pitch_me_app/core/signin/facebookSignin.dart';
import 'package:pitch_me_app/core/signin/signInWithGoogle.dart';
import 'package:pitch_me_app/models/auth/userLoginModel.dart';
import 'package:pitch_me_app/screens/businessIdeas/BottomNavigation.dart';
import 'package:pitch_me_app/screens/selectionScreen.dart';
import 'package:pitch_me_app/utils/extras/extras.dart';
import 'package:pitch_me_app/utils/widgets/extras/loading.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends GetxController {
  //TODO: Implement LoginController
  final count = 0.obs;
  var emailFocus = false.obs, agree = false.obs;
  TextEditingController txtEmail = TextEditingController(),
      txtPassword = TextEditingController();
  FocusNode emailFocusNode = FocusNode(), pwdFocusNode = FocusNode();
  AuthApis authApis = AuthApis();

  bool validate(context) {
    if (txtEmail.text.isEmpty) {
      myToast(context, msg: 'Email is required');
      return false;
    }
    if (GetUtils.isEmail(txtEmail.text) == false) {
      myToast(context, msg: 'Please enter correct email');
      return false;
    }
    if (txtPassword.text.isEmpty) {
      myToast(context, msg: 'Password is required');
      return false;
    }
    if (txtPassword.text.length < 6) {
      myToast(context, msg: 'Password should be 6 characters long');
      return false;
    }
    return true;
  }

  submit(context) async {
    print("object");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (validate(context)) {
      Get.dialog(Loading());
      try {
        UserLoginModel? result = await authApis.login(context,
            email: txtEmail.text, passwrod: txtPassword.text);
        print("id ${result!.toJson()}");
        Get.back();
        if (result != null) {
          print("idAbc ${result.token}");
          prefs.setString("user_id", result.user!.sId.toString());
          prefs.setString("user_name", result.user!.username.toString());
          prefs.setString("email", result.user!.email.toString());
          prefs.setString("tok", result.token.toString());
          var log =
              prefs.setString("log_type", result.user!.loginType.toString());
          prefs.setString("guest", 'Guest');
          prefs.setString('count_swipe', '0');
          prefs.setBool('hometutorial', result.user!.hometutorial);
          prefs.setBool('salespitchtutorial', result.user!.salespitchtutorial);
          prefs.setBool(
              'addsalespitchtutoria', result.user!.addsalespitchtutoria);
          prefs.setBool('dealtutorial', result.user!.dealtutorial);
          prefs.setBool('profiletutorial', result.user!.profiletutorial);

          if (result.user!.bot != null && result.user!.bot != 0) {
            prefs.setString("bot", '1');
          }
          if (result.user!.loginType == 5) {
            prefs.setString('admin_user', jsonEncode(result));
          }
          //  await authApis.setUserType(type: 5);
          // AuthApis.setData(userLoginModel: result);
          if (result.user!.loginType == null || result.user!.loginType == 0) {
            Get.offAll(() => SelectionScreen(), binding: SelectionBinding());
          } else {
            Get.offAll(() => Floatbar(0));
          }
        }
      } catch (e) {
        Get.back();
      }
    }
  }

  Future<void> socialLogin(context, int which) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      Get.dialog(Loading());
      UserCredential? userCredential = which == 1
          ? await signInWithApple()
          : which == 2
              ? await signInWithGoogle()
              : await signInWithFacebook();
      log("User creds are ${userCredential.toString()}");
      Get.back();
      if (userCredential != null && userCredential.user != null) {
//        myToast(context,msg: 'Social signin success');
        Get.dialog(Loading());
        UserLoginModel? result = await authApis.socialLogin(context,
            email: userCredential.user!.email!,
            name: userCredential.user!.displayName == null
                ? '${userCredential.user!.email!}'
                : userCredential.user!.displayName!,
            uid: userCredential.user!.uid,
            type: which == 1
                ? 4
                : which == 2
                    ? 2
                    : 3);
        Get.back();
        if (result != null) {
          prefs.setString("user_id", result.user!.sId.toString());
          prefs.setString("user_name", result.user!.username.toString());
          prefs.setString("tok", result.token.toString());
          var log =
              prefs.setString("log_type", result.user!.loginType.toString());
          prefs.setString("guest", 'Guest');
          prefs.setString('count_swipe', '0');
          prefs.setBool('hometutorial', result.user!.hometutorial);
          prefs.setBool('salespitchtutorial', result.user!.salespitchtutorial);
          prefs.setBool(
              'addsalespitchtutoria', result.user!.addsalespitchtutoria);
          prefs.setBool('dealtutorial', result.user!.dealtutorial);
          prefs.setBool('profiletutorial', result.user!.profiletutorial);
          // AuthApis.setData(userLoginModel: result);
          if (result.user!.loginType == null || result.user!.loginType == 0) {
            Get.offAll(() => SelectionScreen(), binding: SelectionBinding());
          } else {
            Get.offAll(() => Floatbar(0));
          }
        }
      } else {
        Get.back();
      }
    } catch (e) {
      Get.back();
      myToast(context, msg: e.toString());
    }
  }
}

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginController>(
      () => LoginController(),
    );
  }
}
