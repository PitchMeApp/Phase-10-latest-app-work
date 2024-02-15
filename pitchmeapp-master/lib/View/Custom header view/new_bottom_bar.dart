import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pitch_me_app/Phase%206/Guest%20UI/BottomNavigation.dart';
import 'package:pitch_me_app/View/Leave%20Page/leave_page.dart';
import 'package:pitch_me_app/screens/businessIdeas/BottomNavigation.dart';
import 'package:pitch_me_app/utils/colors/colors.dart';
import 'package:pitch_me_app/utils/widgets/Navigation/custom_navigation.dart';

class NewCustomBottomBar extends StatefulWidget {
  int index;
  var isBack;
  var isManuIcon;
  NewCustomBottomBar(
      {super.key, required this.index, this.isBack, this.isManuIcon});

  @override
  State<NewCustomBottomBar> createState() => _NewCustomBottomBarState();
}

class _NewCustomBottomBarState extends State<NewCustomBottomBar> {
  int selectIndex = 2;
  int pageindex = 0;

  @override
  void initState() {
    selectIndex = widget.index;

    super.initState();
  }

  List iconlist = [
    "assets/Phase 2 icons/ic_home_24px (1).png",
    "assets/Phase 2 icons/ic_play_circle_notfilled_24px.png",
    "assets/Phase 2 icons/ic_add_24px.png",
    //"assets/Phase 2 icons/ic_add_24px (1).png",
    //"assets/Phase 2 icons/equalizer_light.png",
    "assets/Phase 2 icons/ic_person_24px.png",
  ];

  List filleIcons = [
    "assets/Phase 2 icons/ic_home_24px.png",
    "assets/Phase 2 icons/ic_play_circle_filled_24px.png",
    "assets/Phase 2 icons/ic_add_24px (1).png",
    //"assets/Phase 2 icons/equalizer_dark.png",
    "assets/Phase 2 icons/ic_person_24px (1).png",
  ];

  @override
  Widget build(BuildContext context) {
    final sizeH = MediaQuery.of(context).size.height;
    final sizeW = MediaQuery.of(context).size.width;
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        decoration: BoxDecoration(gradient: DynamicColor.gradientColorOnBegin),
        child: BottomNavigationBar(
            backgroundColor: Colors.transparent,
            type: BottomNavigationBarType.fixed,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            elevation: 0,
            iconSize: 0.0,
            selectedFontSize: 0.0,
            unselectedFontSize: 0.0,
            currentIndex: selectIndex,
            onTap: (index) {
              log(index.toString());
              if (widget.index != index) {
                setState(() {
                  // pageindex = index;
                  // selectIndex = index;
                  if (widget.isBack == 'Guest') {
                    Get.offAll(() => GuestFloatbar(index));
                  } else {
                    if (widget.isBack != null) {
                      Get.offAll(() => Floatbar(index));
                    } else {
                      if (index != 2) {
                        PageNavigateScreen().push(
                            context,
                            LeavePage(
                              index: index,
                            ));
                      }
                    }
                  }
                });
              }
            },
            items: [
              BottomNavigationBarItem(
                icon: Image.asset(
                  iconlist[0],
                  height: sizeH * 0.04,
                  width: sizeW * 0.07,
                ),
                activeIcon: Image.asset(
                  filleIcons[0],
                  height: sizeH * 0.04,
                  width: sizeW * 0.07,
                ),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Image.asset(
                  iconlist[1],
                  height: sizeH * 0.04,
                  width: sizeW * 0.07,
                ),
                activeIcon: Image.asset(
                  filleIcons[1],
                  height: sizeH * 0.04,
                  width: sizeW * 0.07,
                ),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Image.asset(
                  iconlist[2],
                  height: sizeH * 0.04,
                  width: sizeW * 0.07,
                ),
                activeIcon: Image.asset(
                  filleIcons[2],
                  height: sizeH * 0.04,
                  width: sizeW * 0.07,
                ),
                label: '',
              ),
              // BottomNavigationBarItem(
              //   icon: Image.asset(
              //     iconlist[3],
              //     height: sizeH * 0.04,
              //     width: sizeW * 0.07,
              //   ),
              //   activeIcon: Image.asset(
              //     filleIcons[3],
              //     height: sizeH * 0.04,
              //     width: sizeW * 0.07,
              //   ),
              //   label: '',
              // ),
              BottomNavigationBarItem(
                icon: Image.asset(
                  iconlist[3],
                  height: sizeH * 0.04,
                  width: sizeW * 0.07,
                ),
                activeIcon: Image.asset(
                  filleIcons[3],
                  height: sizeH * 0.04,
                  width: sizeW * 0.07,
                ),
                label: '',
              ),
            ]),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
