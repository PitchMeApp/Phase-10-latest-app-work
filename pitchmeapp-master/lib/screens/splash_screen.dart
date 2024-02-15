import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pitch_me_app/Phase%206/Guest%20UI/BottomNavigation.dart';
import 'package:pitch_me_app/controller/auth/loginController.dart';
import 'package:pitch_me_app/controller/selectionController.dart';
import 'package:pitch_me_app/screens/auth/loginScreen.dart';
import 'package:pitch_me_app/screens/businessIdeas/BottomNavigation.dart';
import 'package:pitch_me_app/screens/selectionScreen.dart';
import 'package:pitch_me_app/utils/sizeConfig/sizeConfig.dart';
import 'package:pitch_me_app/utils/strings/images.dart';
import 'package:pitch_me_app/utils/widgets/containers/containers.dart';
import 'package:pitch_me_app/utils/widgets/extras/backgroundWidget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String userType = '';
  String countSwipe = '';
  String token = '';
  dynamic checkGuest;

  @override
  void initState() {
    chackAuth();
    super.initState();
  }

  void chackAuth() async {
    SharedPreferences preferencesData = await SharedPreferences.getInstance();
    checkGuest = preferencesData.getString('guest').toString();
    userType = preferencesData.getString('log_type').toString();
    token = preferencesData.getString('tok').toString();

    Future.delayed(
      const Duration(seconds: 2),
      () {
        if (checkGuest.isNotEmpty && checkGuest != 'null') {
          log('No guest check');
          if (token.isNotEmpty || token != 'null') {
            if (userType == '5') {
              preferencesData.remove('industry');
              preferencesData.remove('location');
              preferencesData.remove('location_tap');
              preferencesData.remove('needs');
              Get.offAll(() => Floatbar(0));
            } else {
              if (userType.isEmpty || userType == '0') {
                Get.offAll(() => SelectionScreen(),
                    binding: SelectionBinding());
              } else {
                Get.offAll(() => Floatbar(0));
              }
            }
          } else {
            Get.offAll(() => LoginScreen(), binding: LoginBinding());
          }
        } else {
          log('guest check');
          Get.offAll(() => GuestFloatbar(0));
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackGroundWidget(
        backgroundImage: Assets.backgroundImage,
        fit: BoxFit.cover,
        child: Padding(
          padding:
              EdgeInsets.only(left: SizeConfig.getSize15(context: context)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              appLogoImage(
                  isDark: false,
                  height: SizeConfig.getSize100(context: context) +
                      SizeConfig.getSize55(context: context)),
              Padding(
                padding: EdgeInsets.only(top: 20),
                child: Image.asset(
                  'assets/imagess/PITCH ME.png',
                  height: SizeConfig.getSize60(context: context) +
                      SizeConfig.getSize25(context: context),
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: EdgeInsets.only(
                      right: SizeConfig.getSize35(context: context) +
                          SizeConfig.getSize5(context: context)),
                  child: Image.asset(
                    'assets/imagess/MOTO (1).png',
                    height: SizeConfig.getSize40(context: context),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20),
                child: Image.asset(
                  'assets/imagess/MOTO.png',
                  height: SizeConfig.getSize100(context: context),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
