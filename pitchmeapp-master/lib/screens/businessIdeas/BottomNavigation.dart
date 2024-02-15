import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pitch_me_app/View/Profile/profile.dart';
import 'package:pitch_me_app/View/Select%20industry/select_industry.dart';
import 'package:pitch_me_app/controller/businessIdeas/homepagecontroller.dart';
import 'package:pitch_me_app/devApi%20Service/get_api.dart';
import 'package:pitch_me_app/screens/businessIdeas/VideoScreen.dart';
import 'package:pitch_me_app/screens/businessIdeas/mainHome.dart';
import 'package:pitch_me_app/utils/colors/colors.dart';

class Floatbar extends StatefulWidget {
  // const Floatbar({super.key, var index = 3});
  var selectData;
  Floatbar(this.selectData);

  @override
  State<Floatbar> createState() => _FloatbarState();
}

class _FloatbarState extends State<Floatbar> {
  int selectIndex = 0;
  int pageindex = 0;

  bool isSelectedScreen = true;

  final HomePageController controller = Get.put(HomePageController());

  @override
  void initState() {
    if (widget.selectData != null) {
      controller.PageIndexData.value = widget.selectData;
    }
    GetApiService().checkProOrbasicUserApi();
    super.initState();
  }

  List iconlist = [
    "assets/Phase 2 icons/ic_home_24px (1).png",
    "assets/Phase 2 icons/ic_play_circle_notfilled_24px.png",
    "assets/Phase 2 icons/ic_add_24px.png",
    // "assets/Phase 2 icons/equalizer_light.png",
    "assets/Phase 2 icons/ic_person_24px.png",
  ];

  List filleIcons = [
    "assets/Phase 2 icons/ic_home_24px.png",
    "assets/Phase 2 icons/ic_play_circle_filled_24px.png",
    "assets/Phase 2 icons/ic_add_24px (1).png",
    // "assets/Phase 2 icons/equalizer_dark.png",
    "assets/Phase 2 icons/ic_person_24px (1).png",
  ];
  List<Widget> pages = [
    MainHomeScreen(),
    mainHome_Two(),
    SelectIndustryPage(
      bottombarCheck: false,
      isCheck: 'Post',
    ),
    //DealsPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    final sizeH = MediaQuery.of(context).size.height;
    final sizeW = MediaQuery.of(context).size.width;

    return Scaffold(
      extendBody: true,
      body: pages.isEmpty
          ? Container()
          : Obx(() => pages[controller.PageIndexData.value]),
      bottomNavigationBar: Obx(() {
        return controller.hideNaveBar.value.isNotEmpty
            ? Container()
            : Container(
                // height: 70,

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
