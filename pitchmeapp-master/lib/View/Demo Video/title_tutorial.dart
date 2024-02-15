import 'dart:io';

import 'package:flutter/material.dart';
import 'package:pitch_me_app/utils/sizeConfig/sizeConfig.dart';
import 'package:pitch_me_app/utils/strings/images.dart';
import 'package:pitch_me_app/utils/styles/styles.dart';
import 'package:pitch_me_app/utils/widgets/extras/backgroundWidget.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Phase 6/Guest UI/Profile/manu.dart';
import '../../utils/colors/colors.dart';
import '../../utils/widgets/Navigation/custom_navigation.dart';
import '../../utils/widgets/containers/containers.dart';
import '../Custom header view/appbar_with_white_bg.dart';
import '../Manu/manu.dart';

class TitleTutorialPage extends StatefulWidget {
  String title;
  int pageIndex;
  bool isCheck;
  VoidCallback onPlay;
  VoidCallback onNext;
  ValueChanged<bool?> onCheck;
  dynamic checkPage;
  TitleTutorialPage({
    super.key,
    required this.title,
    required this.pageIndex,
    required this.isCheck,
    required this.onPlay,
    required this.onNext,
    required this.onCheck,
    this.checkPage,
  });

  @override
  State<TitleTutorialPage> createState() => _TitleTutorialPageState();
}

class _TitleTutorialPageState extends State<TitleTutorialPage> {
  String checkGuestType = '';
  bool isCheck = false;

  @override
  void initState() {
    checkGuest();
    super.initState();
  }

  void checkGuest() async {
    SharedPreferences preferencesData = await SharedPreferences.getInstance();
    setState(() {
      checkGuestType = preferencesData.getString('guest').toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackGroundWidget(
        backgroundImage: Assets.backgroundImage2,
        fit: BoxFit.fill,
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Container(
                //   height: SizeConfig.getSizeHeightBy(context: context, by: 0),
                // ),
                Padding(
                  padding: EdgeInsets.only(
                    top: SizeConfig.getSizeHeightBy(context: context, by: 0.08),
                  ),
                  child: whiteBorderContainer(
                      child: Image.asset(Assets.handshakeImage),
                      color: Colors.transparent,
                      height: SizeConfig.getSizeHeightBy(
                          context: context, by: 0.20),
                      width: SizeConfig.getSizeHeightBy(
                          context: context, by: 0.20),
                      cornerRadius: 25),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Tutorial',
                      style: TextStyle(
                          color: DynamicColor.white,
                          fontWeight: FontWeight.bold),
                      textScaleFactor: 3,
                    ),
                    Text(
                      widget.title,
                      style: TextStyle(
                          color: DynamicColor.white,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                      textScaleFactor: 3,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: InkWell(
                        onTap: widget.onPlay,
                        child: Image.asset(
                          'assets/imagess/Play Button.png',
                          height: 55,
                          width: 55,
                        ),
                      ),
                    )
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: SizeConfig.getSizeHeightBy(
                          context: context, by: 0.12),
                      bottom: Platform.isAndroid
                          ? widget.checkPage != null
                              ? SizeConfig.getSizeHeightBy(
                                  context: context, by: 0.022)
                              : SizeConfig.getSizeHeightBy(
                                  context: context, by: 0.09)
                          : widget.checkPage != null
                              ? SizeConfig.getSizeHeightBy(
                                  context: context, by: 0.015)
                              : SizeConfig.getSizeHeightBy(
                                  context: context, by: 0.12),
                      left: SizeConfig.getSize30(context: context)),
                  child: Row(
                    children: [
                      Transform.scale(
                          scale: 2.5,
                          child: Checkbox(
                              activeColor: DynamicColor.white,
                              checkColor: DynamicColor.green,
                              side: BorderSide(
                                  color: DynamicColor.white, width: 1.5),
                              value: widget.isCheck,
                              onChanged: widget.onCheck)),
                      SizedBox(width: 10),
                      Text(
                        "Don’t show tutorial again",
                        style: white16bold,
                      ),
                    ],
                  ),
                )
              ],
            ),
            CustomAppbarWithWhiteBg(
              title: '',
              checkNew: 'next',
              nextOnTap: widget.onNext,
              onPressad: () {
                if (checkGuestType == 'null') {
                  PageNavigateScreen().push(
                      context,
                      GuestManuPage(
                        title: widget.title,
                        pageIndex: widget.pageIndex,
                      ));
                } else {
                  PageNavigateScreen().push(
                      context,
                      ManuPage(
                        title: widget.title,
                        pageIndex: widget.pageIndex,
                        isManu: 'Manu',
                      ));
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
