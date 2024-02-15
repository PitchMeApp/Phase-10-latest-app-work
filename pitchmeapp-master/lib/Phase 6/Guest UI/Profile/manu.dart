import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pitch_me_app/View/Deals%20Page/deals_page.dart';
import 'package:pitch_me_app/View/Manu/FAQ/faq.dart';
import 'package:pitch_me_app/View/Manu/Tutorials/tutorials.dart';
import 'package:pitch_me_app/controller/auth/loginController.dart';
import 'package:pitch_me_app/controller/auth/signupController.dart';
import 'package:pitch_me_app/screens/auth/loginScreen.dart';
import 'package:pitch_me_app/utils/colors/colors.dart';
import 'package:pitch_me_app/utils/sizeConfig/sizeConfig.dart';
import 'package:pitch_me_app/utils/strings/strings.dart';
import 'package:pitch_me_app/utils/widgets/Navigation/custom_navigation.dart';
import 'package:pitch_me_app/utils/widgets/containers/containers.dart';

import '../../../View/Custom header view/appbar_with_white_bg.dart';
import '../../../screens/auth/signUpScreen.dart';
import '../../../utils/strings/images.dart';
import '../../../utils/widgets/extras/backgroundWidget.dart';
import '../Guest limitation pages/login_limitation.dart';

class GuestManuPage extends StatefulWidget {
  String title;
  int pageIndex;
  GuestManuPage({super.key, required this.title, required this.pageIndex});

  @override
  State<GuestManuPage> createState() => _GuestManuPageState();
}

class _GuestManuPageState extends State<GuestManuPage> {
  int isSelect = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DynamicColor.white,
      body: BackGroundWidget(
        backgroundImage: Assets.backgroundImage,
        fit: BoxFit.cover,
        child: Stack(
          children: [
            Stack(
              alignment: Alignment.bottomCenter,
              children: [
                ClipPath(
                  clipper: CurveClipper(),
                  child: Container(
                    decoration: BoxDecoration(
                        gradient: DynamicColor.gradientColorChange),
                    height: MediaQuery.of(context).size.height * 0.235,
                  ),
                ),
                whiteBorderContainer(
                    child: Image.asset(Assets.handshakeImage),
                    color: Colors.transparent,
                    height:
                        SizeConfig.getSizeHeightBy(context: context, by: 0.12),
                    width:
                        SizeConfig.getSizeHeightBy(context: context, by: 0.12),
                    cornerRadius: 25),
              ],
            ),
            _buildBodyView(),
            Container(),
            CustomAppbarWithWhiteBg(
              title: widget.title,
              checkNext: widget.title.isEmpty ? null : 'back',
              isManuColor: 'check',
              onPressad: () {},
            ),
            // widget.pageIndex == 0
            //     ? Container()
            //     : NewCustomBottomBar(
            //         index: widget.pageIndex,
            //         isBack: 'Guest',
            //         isManuIcon: 'icon',
            //       ),
          ],
        ),
      ),
    );
  }

  Widget _buildBodyView() {
    return Padding(
      padding: EdgeInsets.only(
        top: SizeConfig.getSize80(context: context),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomListBox(
              title: TextStrings.textKey['log_in']!,
              singleSelectColor: isSelect,
              isSingleSelect: 1,
              onPressad: () {
                setState(() {
                  isSelect = 1;
                });
                Get.offAll(() => LoginScreen(), binding: LoginBinding());
              }),
          CustomListBox(
              title: TextStrings.textKey['sign_up']!,
              singleSelectColor: isSelect,
              isSingleSelect: 2,
              onPressad: () {
                setState(() {
                  isSelect = 2;
                });
                Get.to(() => SignUpScreen(), binding: SignUpBinding());
              }),
          CustomListBox(
              title: TextStrings.textKey['become_pro']!,
              singleSelectColor: isSelect,
              isSingleSelect: 8,
              onPressad: () {
                setState(() {
                  isSelect = 8;
                });
                PageNavigateScreen().push(context, LoginLimitationPage());
              }),
          CustomListBox(
              title: TextStrings.textKey['tutorial']!,
              singleSelectColor: isSelect,
              isSingleSelect: 3,
              onPressad: () {
                setState(() {
                  isSelect = 3;
                });
                PageNavigateScreen().push(
                    context,
                    TutorialsPage(
                      pageIndex: widget.pageIndex,
                    ));
              }),
          CustomListBox(
              title: TextStrings.textKey['faq']!,
              singleSelectColor: isSelect,
              isSingleSelect: 4,
              onPressad: () {
                setState(() {
                  isSelect = 4;
                });
                PageNavigateScreen().push(
                    context,
                    FQAPage(
                      pageIndex: widget.pageIndex,
                      isCheckPro: 0,
                    ));
              }),
          // CustomListBox(
          //     title: TextStrings.textKey['advrise']!,
          //     singleSelectColor: isSelect,
          //     isSingleSelect: 5,
          //     onPressad: () {
          //       setState(() {
          //         isSelect = 5;
          //       });
          //       PageNavigateScreen().push(context, LoginLimitationPage());
          //     }),
          // CustomListBox(
          //     title: TextStrings.textKey['buy_pitch']!,
          //     singleSelectColor: isSelect,
          //     isSingleSelect: 6,
          //     onPressad: () {
          //       setState(() {
          //         isSelect = 6;
          //       });
          //       PageNavigateScreen().push(context, LoginLimitationPage());
          //     }),
          CustomListBox(
              title: TextStrings.textKey['chat']!,
              singleSelectColor: isSelect,
              isSingleSelect: 7,
              onPressad: () {
                setState(() {
                  isSelect = 7;
                });
                PageNavigateScreen().push(context, LoginLimitationPage());
              }),
        ],
      ),
    );
  }
}
