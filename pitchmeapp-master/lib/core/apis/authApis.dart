import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:pitch_me_app/core/urls.dart';
import 'package:pitch_me_app/models/auth/registerDataModel.dart';
import 'package:pitch_me_app/models/auth/userLoginModel.dart';
import 'package:pitch_me_app/utils/extras/extras.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthApis extends GetConnect {
  AuthApis() {
    httpClient.baseUrl = BASE_URL;
  }

  // static setData({required UserLoginModel userLoginModel}) {
  //   pref.write(Keys.TOKEN, userLoginModel.token);
  //   // pref.write(Keys.USER_TYPE, userLoginModel.user!.loginType);
  // }

  Future<UserCredential?> signInWithGoogle() async {
    // Trigger the authentication flow
    try {
      await Firebase.initializeApp();
      await GoogleSignIn().signOut();
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;
      // Create a new credential
      if (googleAuth != null) {
        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );
        return await FirebaseAuth.instance.signInWithCredential(credential);
      } else {
        // longToastMessage("Error Occurred Try Again....");
        return null;
      }

      // Once signed in, return the UserCredential
    } catch (e) {
      // longToastMessage("Error Occurred Try Again....");
      return null;
    }
  }

  Future<UserCredential?> signInWithFacebook() async {
    try {
      // Trigger the sign-in flow
      final LoginResult loginResult = await FacebookAuth.instance.login();

      // Create a credential from the access token
      final OAuthCredential facebookAuthCredential =
          FacebookAuthProvider.credential(loginResult.accessToken!.token);

      // Once signed in, return the UserCredential
      return FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
    } catch (e) {
      // longToastMessage("Error Occurred Try Again....");
      return null;
    }
  }

  Future<UserLoginModel?> login(context,
      {required String email, required String passwrod}) async {
    try {
      var res = await post(LOGIN, {"email": email, "password": passwrod});
      print(
          "Parsed data to login is ${{"email": email, "password": passwrod}}");
      print("Response is at login ${res.body}");
      print("Status is at login ${res.statusCode}");
      if (res.statusCode == 200) {
        return UserLoginModel.fromJson(res.body);
      } else if (res.statusCode == 409) {
        myToast(context, msg: "Please verify email send to your Email Id");
        return null;
      } else if (res.statusCode == 401) {
        // UserLoginModel _userModel = UserLoginModel.fromJson(res.body);
        // myToast(context,msg: _userModel.message!);
        myToast(context, msg: 'User not found');
        return null;
      } else
        return null;
    } catch (e) {
      print("Error is at login ${e.toString()}");
      myToast(context, msg: e.toString());
      return null;
    }
  }

  Future<UserLoginModel?> socialLogin(context,
      {required String email,
      required String uid,
      required String name,
      required int type}) async {
    try {
      var res = await post(SOCIAL_LOGIN,
          {"email": email, "uid": uid, "name": name, "type": type});
      print("Parsed data to social login is ${{
        "email": email,
        "uid": uid,
        "name": name,
        "type": type
      }}");
      print("Response is at socialLogin ${res.body}");
      print("Status is at socialLogin ${res.statusCode}");
      if (res.statusCode == 200 || res.statusCode == 201)
        return UserLoginModel.fromJson(res.body);
      else if (res.statusCode == 409) {
        myToast(context, msg: "Please verify email send to your Email Id");
        return null;
      } else if (res.statusCode == 401) {
        // UserLoginModel _userModel = UserLoginModel.fromJson(res.body);
        // myToast(context,msg: _userModel.message!);
        myToast(context, msg: 'User not found');
        return null;
      } else
        return null;
    } catch (e) {
      print("Error is at login ${e.toString()}");
      myToast(context, msg: e.toString());
      return null;
    }
  }

  Future<UserLoginModel?> register(context,
      {required RegisterDataModel registerDataModel}) async {
    try {
      var res = await post(REGISTER, registerDataModel.toJson());
      print("Parsed data to register is ${registerDataModel.toJson()}");
      print("Response is at register ${res.body}");
      print("Status code is at register ${res.statusCode}");
      if (res.statusCode == 200 || res.statusCode == 201)
        return UserLoginModel.fromJson(res.body);
      else if (res.statusCode == 409) {
        myToast(context, msg: 'User already exist');
        return null;
      } else
        return null;
    } catch (e) {
      print("Error is at login ${e.toString()}");
      myToast(context, msg: e.toString());
      return null;
    }
  }

  Future<bool?> sendEmail(context,
      {required String email, required int type}) async {
    try {
      var res = await post(SEND_EMAIL, {"email": email, "type": type});
      print("Parsed data to sendEmail is ${{"email": email, "type": type}}");
      print("Response is at sendEmail ${res.body}");
      print("Status code is at sendEmail ${res.statusCode}");
      if (res.statusCode == 200)
        return true;
      else if (res.statusCode == 404) {
        myToast(context, msg: "User doesn't exist");
        return null;
      } else
        return null;
    } catch (e) {
      print("Error is at sendEmail ${e.toString()}");
      myToast(context, msg: e.toString());
      return null;
    }
  }

  Future<bool?> setUserType(context, {required int type}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      var res = await put(EDIT_USER_TYPE, {"log_type": type},
          headers: {'Authorization': "Bearer ${prefs.getString('tok')}"});
      print("Parsed data to setUserType is ${{"type": type}}");
      print("Response is at setUserType ${res.body}");
      print("Status code is at sendEmail ${res.statusCode}");
      if (res.statusCode == 200)
        return true;
      else
        return null;
    } catch (e) {
      print("Error is at sendEmail ${e.toString()}");
      myToast(context, msg: e.toString());
      return null;
    }
  }
}
