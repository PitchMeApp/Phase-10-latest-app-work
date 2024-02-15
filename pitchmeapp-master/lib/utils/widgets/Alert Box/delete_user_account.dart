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

import '../../../devApi Service/get_api.dart';
import '../../extras/extras.dart';

class DeleteUserAccountPopUp extends StatefulWidget {
  const DeleteUserAccountPopUp({
    Key? key,
  }) : super(key: key);

  @override
  _DeleteUserAccountPopUpState createState() => _DeleteUserAccountPopUpState();
}

class _DeleteUserAccountPopUpState extends State<DeleteUserAccountPopUp> {
  bool isLoading = false;

  void deleteApiCall() async {
    setState(() {
      isLoading = true;
    });

    try {
      await GetApiService().deleteUserAccountApi().then((value) {
        if (value != null) {
          myToast(context, msg: 'Your account has been deleted successfully');

          deleteUser();
        }
      });

      setState(() {
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
    }
  }

  deleteUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.clear();
    //pref.erase();
    videoViewerControllerList.clear();
    Get.delete<BiographyController>(force: true);
    navigatePage();
  }

  navigatePage() {
    Timer(Duration(milliseconds: 700), () {
      Get.offAll(() => LoginScreen(), binding: LoginBinding());
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      title: Center(
        child: Text(
          TextStrings.textKey['delete_account']!,
          style: const TextStyle(
              color: DynamicColor.gredient1, fontWeight: FontWeight.bold),
        ),
      ),
      content: Text(
        TextStrings.textKey['delete_account_sub']!,
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
                          deleteApiCall();
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
