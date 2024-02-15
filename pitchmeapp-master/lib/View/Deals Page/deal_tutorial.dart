import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pitch_me_app/Phase%206/Guest%20UI/Profile/manu.dart';
import 'package:pitch_me_app/View/Custom%20header%20view/appbar.dart';
import 'package:pitch_me_app/View/Custom%20header%20view/new_bottom_bar.dart';
import 'package:pitch_me_app/View/Manu/manu.dart';
import 'package:pitch_me_app/View/navigation_controller.dart';
import 'package:pitch_me_app/utils/colors/colors.dart';
import 'package:pitch_me_app/utils/extras/extras.dart';
import 'package:pitch_me_app/utils/widgets/Navigation/custom_navigation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_viewer/video_viewer.dart';

import '../../utils/sizeConfig/sizeConfig.dart';
import '../../utils/strings/strings.dart';
import '../../utils/styles/styles.dart';
import '../../utils/widgets/containers/containers.dart';

class DealTutorialPage extends StatefulWidget {
  const DealTutorialPage({super.key});

  @override
  State<DealTutorialPage> createState() => _DealTutorialPageState();
}

class _DealTutorialPageState extends State<DealTutorialPage> {
  final NavigationController _navigationController =
      Get.put(NavigationController());
  VideoViewerController videoViewerController = VideoViewerController();

  bool isCheck = false;

  String checkGuestType = '';

  @override
  void initState() {
    checkGuest();

    super.initState();
  }

  void checkGuest() async {
    SharedPreferences preferencesData = await SharedPreferences.getInstance();
    setState(() {
      checkGuestType = preferencesData.getString('guest').toString();

      if (preferencesData.getBool('dealstutorial') != null) {
        isCheck = preferencesData.getBool('dealstutorial')!;
      }
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
      floatingActionButtonLocation: FloatingActionButtonLocation.centerTop,
      body: Stack(
        children: [
          Container(
            width: width(context),
            height: height(context),
            color: Color.fromARGB(255, 254, 254, 254),
            child: VideoViewer(
              controller: videoViewerController,
              autoPlay: true,
              enableHorizontalSwapingGesture: false,
              enableVerticalSwapingGesture: false,
              volumeManager: VideoViewerVolumeManager.device,
              onFullscreenFixLandscape: false,
              forwardAmount: 5,
              defaultAspectRatio: 9 / 16,
              rewindAmount: -5,
              looping: true,
              enableShowReplayIconAtVideoEnd: false,
              style: VideoViewerStyle(
                  playAndPauseStyle: PlayAndPauseWidgetStyle(
                    background: Colors.transparent,
                    circleRadius: 80.0,
                    play: Center(
                      child: Icon(
                        Icons.play_arrow,
                        size: 80,
                        color: DynamicColor.white,
                      ),
                    ),
                    pause: Center(
                      child: Icon(
                        Icons.pause,
                        size: 80,
                        color: DynamicColor.white,
                      ),
                    ),
                  ),
                  thumbnail: Image.network(''),
                  loading: CircularProgressIndicator(
                    color: DynamicColor.gredient1,
                  )),
              source: {
                "Source": VideoSource(
                  video: VideoPlayerController.network(
                      'https://ciu.ody.mybluehostin.me/ringbell/addwatchsales.mp4'),
                )
              },
            ),
          ),
          CustomAppbar(
            title: TextStrings.textKey['deals']!,
            onPressad: () {
              videoViewerController.pause();
              if (checkGuestType.isNotEmpty && checkGuestType != 'null') {
                PageNavigateScreen()
                    .push(
                        context,
                        ManuPage(
                          title: TextStrings.textKey['deals']!,
                          pageIndex: 3,
                          isManu: 'Manu',
                        ))
                    .then((value) {
                  setState(() {
                    videoViewerController.play();
                  });
                });
              } else {
                Get.to(() => GuestManuPage(
                      title: TextStrings.textKey['deals']!,
                      pageIndex: 3,
                    ));
              }
            },
            onPressadForNotify: () {},
          ),
          Padding(
            padding: EdgeInsets.only(
                top: SizeConfig.getSize30(context: context) +
                    SizeConfig.getSize55(context: context) +
                    SizeConfig.getSize5(context: context),
                left: SizeConfig.getFontSize25(context: context),
                right: SizeConfig.getFontSize25(context: context)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // Align(
                //   alignment: Alignment.topRight,
                //   child: AppBarIconContainer(
                //     height: SizeConfig.getSize38(context: context),
                //     width: SizeConfig.getSize38(context: context),
                //     color: DynamicColor.redColor,
                //     borderRadius: BorderRadius.only(
                //         topRight: Radius.circular(10),
                //         bottomLeft: Radius.circular(10)),
                //     child: Icon(
                //       Icons.close,
                //       color: DynamicColor.white,
                //       size: 30,
                //     ),
                //     onTap: () {},
                //   ),
                // ),
                Align(
                  alignment: Alignment.topRight,
                  child: AppBarIconContainer(
                    height: SizeConfig.getSize38(context: context),
                    width: SizeConfig.getSize38(context: context),
                    color: DynamicColor.green,
                    child: Icon(
                      Icons.check,
                      color: DynamicColor.white,
                      size: 30,
                    ),
                    onTap: () {
                      if (checkGuestType.isNotEmpty &&
                          checkGuestType != 'null') {
                        Get.back();
                        setState(() {
                          videoViewerController.pause();
                        });
                        // Get.offAll(() => Floatbar(3))!.then((value) {
                        //   setState(() {
                        //     videoViewerController.pause();
                        //   });
                        // });
                      } else {
                        Get.back();
                        setState(() {
                          videoViewerController.pause();
                        });
                        // Get.offAll(() => GuestFloatbar(3))!.then((value) {
                        //   setState(() {
                        //     videoViewerController.pause();
                        //   });
                        // });
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.only(
                  bottom:
                      SizeConfig.getSizeHeightBy(context: context, by: 0.12),
                  left: SizeConfig.getSize30(context: context)),
              child: Row(
                children: [
                  Transform.scale(
                      scale: 2.5,
                      child: Checkbox(
                          activeColor: DynamicColor.white,
                          checkColor: DynamicColor.green,
                          side:
                              BorderSide(color: DynamicColor.white, width: 1.5),
                          value: isCheck,
                          onChanged: (value) {
                            setState(() {
                              isCheck = value!;
                              checkDontShow(isCheck);
                            });
                          })),
                  SizedBox(width: 10),
                  Text(
                    "Don’t show tutorial again",
                    style: white16bold,
                  ),
                ],
              ),
            ),
          ),
          NewCustomBottomBar(
            index: 3,
            isBack: true,
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    //  log('video');
    videoViewerController.pause();
    videoViewerController.dispose();

    super.dispose();
  }
}
