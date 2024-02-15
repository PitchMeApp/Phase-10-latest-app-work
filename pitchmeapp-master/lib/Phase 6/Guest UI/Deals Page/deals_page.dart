import 'package:flutter/material.dart';
import 'package:pitch_me_app/Phase%206/Guest%20UI/Guest%20limitation%20pages/login_limitation.dart';
import 'package:pitch_me_app/Phase%206/Guest%20UI/Profile/manu.dart';
import 'package:pitch_me_app/View/Deals%20Page/deals_page.dart';
import 'package:pitch_me_app/utils/colors/colors.dart';
import 'package:pitch_me_app/utils/strings/strings.dart';
import 'package:pitch_me_app/utils/widgets/Navigation/custom_navigation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../View/Custom header view/appbar_with_white_bg.dart';
import '../../../View/Custom header view/new_bottom_bar.dart';
import '../../../View/Deals Page/deal_tutorial.dart';
import '../../../View/Demo Video/title_tutorial.dart';
import '../../../utils/sizeConfig/sizeConfig.dart';
import '../../../utils/strings/images.dart';
import '../../../utils/widgets/containers/containers.dart';
import '../../../utils/widgets/extras/backgroundWidget.dart';

class GuestDealsPage extends StatefulWidget {
  const GuestDealsPage({super.key});

  @override
  State<GuestDealsPage> createState() => _GuestDealsPageState();
}

class _GuestDealsPageState extends State<GuestDealsPage> {
  int isSelect = 0;
  bool isCheckTutorial = false;
  bool playTutorial = false;
  bool isLoading = false;

  @override
  void initState() {
    checkAuth();

    super.initState();
  }

  void checkAuth() async {
    setState(() {
      isLoading = true;
    });
    SharedPreferences preferencesData = await SharedPreferences.getInstance();
    setState(() {
      if (preferencesData.getBool('dealstutorial') != null) {
        playTutorial = preferencesData.getBool('dealstutorial')!;
        isCheckTutorial = preferencesData.getBool('dealstutorial')!;
      }
    });
    setState(() {
      isLoading = false;
    });
  }

  void checkDontShow(bool check) async {
    SharedPreferences preferencesData = await SharedPreferences.getInstance();
    setState(() {
      preferencesData.setBool('dealstutorial', check).toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? CircularProgressIndicator(
              color: DynamicColor.gredient1,
            )
          : playTutorial == false
              ? TitleTutorialPage(
                  title: 'Deals',
                  pageIndex: 3,
                  isCheck: isCheckTutorial,
                  onPlay: () {
                    PageNavigateScreen()
                        .push(context, DealTutorialPage())
                        .then((value) {
                      setState(() {
                        playTutorial = true;
                      });
                    });
                  },
                  onNext: () {
                    setState(() {
                      playTutorial = true;
                    });
                  },
                  onCheck: (value) {
                    setState(() {
                      isCheckTutorial = value!;
                      checkDontShow(isCheckTutorial);
                    });
                  },
                )
              : BackGroundWidget(
                  backgroundImage: Assets.backgroundImage,
                  bannerRequired: false,
                  fit: BoxFit.fill,
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
                              height:
                                  MediaQuery.of(context).size.height * 0.235,
                            ),
                          ),
                          whiteBorderContainer(
                              child: Image.asset(Assets.handshakeImage),
                              color: Colors.transparent,
                              height: SizeConfig.getSizeHeightBy(
                                  context: context, by: 0.12),
                              width: SizeConfig.getSizeHeightBy(
                                  context: context, by: 0.12),
                              cornerRadius: 25),
                        ],
                      ),
                      Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // CustomAppbar(title: TextStrings.textKey['deals']!),
                            CustomListBox(
                                title: TextStrings.textKey['chat']!,
                                singleSelectColor: isSelect,
                                isSingleSelect: 1,
                                onPressad: () {
                                  setState(() {
                                    isSelect = 1;
                                  });
                                  PageNavigateScreen()
                                      .push(context, LoginLimitationPage());
                                }),
                            CustomListBox(
                                title: TextStrings.textKey['contract']!,
                                singleSelectColor: isSelect,
                                isSingleSelect: 2,
                                onPressad: () {
                                  setState(() {
                                    isSelect = 2;
                                  });
                                  PageNavigateScreen()
                                      .push(context, LoginLimitationPage());
                                }),
                            CustomListBox(
                                title: TextStrings.textKey['investment']!,
                                singleSelectColor: isSelect,
                                isSingleSelect: 3,
                                onPressad: () {
                                  setState(() {
                                    isSelect = 3;
                                  });
                                  PageNavigateScreen()
                                      .push(context, LoginLimitationPage());
                                }),
                            CustomListBox(
                                title: TextStrings.textKey['share']!,
                                singleSelectColor: isSelect,
                                isSingleSelect: 4,
                                onPressad: () {
                                  setState(() {
                                    isSelect = 4;
                                  });
                                  PageNavigateScreen()
                                      .push(context, LoginLimitationPage());
                                }),
                            CustomListBox(
                                title: TextStrings.textKey['update']!,
                                singleSelectColor: isSelect,
                                isSingleSelect: 5,
                                onPressad: () {
                                  setState(() {
                                    isSelect = 5;
                                  });
                                  PageNavigateScreen()
                                      .push(context, LoginLimitationPage());
                                }),
                          ],
                        ),
                      ),
                      CustomAppbarWithWhiteBg(
                        title: TextStrings.textKey['deals']!,
                        onPressad: () {
                          PageNavigateScreen().push(
                              context,
                              GuestManuPage(
                                title: TextStrings.textKey['deals']!,
                                pageIndex: 3,
                              ));
                        },
                      ),
                      NewCustomBottomBar(
                        index: 3,
                        isBack: true,
                      ),
                    ],
                  ),
                ),
    );
  }
}
