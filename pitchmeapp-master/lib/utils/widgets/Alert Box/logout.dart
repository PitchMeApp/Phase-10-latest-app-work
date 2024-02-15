import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pitch_me_app/View/Profile/Biography/controller/controller.dart';
import 'package:pitch_me_app/controller/auth/loginController.dart';
import 'package:pitch_me_app/screens/auth/loginScreen.dart';
import 'package:pitch_me_app/utils/colors/colors.dart';
import 'package:pitch_me_app/utils/strings/strings.dart';
import 'package:pitch_me_app/utils/styles/styles.dart';
import 'package:pitch_me_app/utils/widgets/extras/directVideoViewer.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LogoutPopUp extends StatefulWidget {
  const LogoutPopUp({
    Key? key,
  }) : super(key: key);

  @override
  _LogoutPopUpState createState() => _LogoutPopUpState();
}

class _LogoutPopUpState extends State<LogoutPopUp> {
  bool isLoading = false;

  logoutUser() async {
    setState(() {
      isLoading = true;
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Timer(const Duration(seconds: 1), () {
      prefs.clear();
      //pref.erase();
      videoViewerControllerList.clear();
      Get.delete<BiographyController>(force: true);
      navigatePage();
      setState(() {
        isLoading = false;
      });
    });
  }

  navigatePage() {
    Get.offAll(() => LoginScreen(), binding: LoginBinding());
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      title: Center(
        child: Text(
          TextStrings.textKey['log_out']!,
          style: const TextStyle(
              color: DynamicColor.gredient1, fontWeight: FontWeight.bold),
        ),
      ),
      content: Text(
        TextStrings.textKey['log_out_sub']!,
        textAlign: TextAlign.center,
      ),
      actions: [
        isLoading == false
            ? Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          TextStrings.textKey['no']!,
                          style: gredient115,
                        )),
                    TextButton(
                        onPressed: () {
                          logoutUser();
                        },
                        child: Text(
                          TextStrings.textKey['yes']!,
                          style: red15,
                        ))
                  ],
                ),
              )
            : const Center(
                child: CircularProgressIndicator(
                  color: DynamicColor.gredient1,
                ),
              )
      ],
    );
  }
}
