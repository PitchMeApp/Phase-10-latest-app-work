import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pitch_me_app/Phase%206/Guest%20UI/Add%20Sales%20Pitch/add_sales_pitch.dart';
import 'package:pitch_me_app/Phase%206/Guest%20UI/Profile/profile.dart';
import 'package:pitch_me_app/Phase%206/Watch%20Sales%20Pitch/watch_sales_pitch.dart';
import 'package:pitch_me_app/controller/businessIdeas/homepagecontroller.dart';
import 'package:pitch_me_app/screens/businessIdeas/mainHome.dart';
import 'package:pitch_me_app/utils/colors/colors.dart';

class GuestFloatbar extends StatefulWidget {
  // const GuestFloatbar({super.key, var index = 3});
  var selectData;
  GuestFloatbar(this.selectData);

  @override
  State<GuestFloatbar> createState() => _GuestFloatbarState();
}

var abc;
var loginCondition;
var businesstype;

class _GuestFloatbarState extends State<GuestFloatbar> {
  int selectIndex = 0;
  int pageindex = 0;

  bool isSelectedScreen = true;

  final HomePageController controller = Get.put(HomePageController());

  @override
  void initState() {
    if (widget.selectData != null) {
      controller.PageIndexData.value = widget.selectData;
    }
    super.initState();
  }

  List iconlist = [
    "assets/Phase 2 icons/ic_home_24px (1).png",
    "assets/Phase 2 icons/ic_play_circle_notfilled_24px.png",
    "assets/Phase 2 icons/ic_add_24px.png",
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

  List<Widget> pages = [
    MainHomeScreen(),
    WatchSalesPitch(),
    GuestAddSaleshTotorialVideoPage(),
    //GuestDealsPage(),
    GuestProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    final sizeH = MediaQuery.of(context).size.height;
    final sizeW = MediaQuery.of(context).size.width;
    return Scaffold(
      extendBody: true,
      body: Obx(() => pages[controller.PageIndexData.value]),
      bottomNavigationBar: Obx(() {
        return controller.hideNaveBar.value.isNotEmpty
            ? Container()
            : Container(
                decoration:
                    BoxDecoration(gradient: DynamicColor.gradientColorOnBegin),
                child: BottomNavigationBar(
                    backgroundColor: Colors.transparent,
                    type: BottomNavigationBarType.fixed,
                    showSelectedLabels: false,
                    showUnselectedLabels: false,
                    elevation: 0,
                    iconSize: 0.0,
                    selectedFontSize: 0.0,
                    unselectedFontSize: 0.0,
                    currentIndex: controller.PageIndexData.value,
                    onTap: (index) {
                      setState(() {
                        pageindex = index;
                        isSelectedScreen = false;
                        controller.PageIndexData.value = index;
                      });
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
              );
      }),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
