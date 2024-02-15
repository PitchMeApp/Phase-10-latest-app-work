import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pitch_me_app/View/Sales%20Pitch%20filter/Controller/filter_controller.dart';
import 'package:pitch_me_app/utils/colors/colors.dart';
import 'package:pitch_me_app/utils/strings/strings.dart';
import 'package:pitch_me_app/utils/styles/styles.dart';
import 'package:pitch_me_app/utils/widgets/Navigation/custom_navigation.dart';
import 'package:pitch_me_app/utils/widgets/extras/directVideoViewer.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ClearFilterPopUp extends StatefulWidget {
  const ClearFilterPopUp({
    Key? key,
  }) : super(key: key);

  @override
  _ClearFilterPopUpState createState() => _ClearFilterPopUpState();
}

class _ClearFilterPopUpState extends State<ClearFilterPopUp> {
  bool isLoading = false;

  clearFilter() async {
    setState(() {
      isLoading = true;
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Timer(const Duration(seconds: 1), () {
      prefs.remove('industry');
      prefs.remove('location');
      prefs.remove('location_tap');
      prefs.remove('needs');

      Get.delete<SalesPitchFilterController>(force: true);
      navigatePage();
      setState(() {
        isLoading = false;
      });
    });
  }

  navigatePage() {
    videoViewerControllerList.clear();
    PageNavigateScreen().back(context);
    // PageNavigateScreen().pushRemovUntil(context, Floatbar(1));
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      title: Center(
        child: Text(
          TextStrings.textKey['clear_filter']!,
          style: const TextStyle(
              color: DynamicColor.gredient1, fontWeight: FontWeight.bold),
        ),
      ),
      content: Text(
        TextStrings.textKey['clear_filter_sub']!,
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
                          clearFilter();
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
