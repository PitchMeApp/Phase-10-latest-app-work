import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pitch_me_app/Phase%206/Guest%20UI/Guest%20limitation%20pages/login_limitation.dart';
import 'package:pitch_me_app/Phase%206/Guest%20UI/Profile/manu.dart';
import 'package:pitch_me_app/View/Custom%20header%20view/appbar.dart';
import 'package:pitch_me_app/View/Custom%20header%20view/new_bottom_bar.dart';
import 'package:pitch_me_app/View/Demo%20Video/title_tutorial.dart';
import 'package:pitch_me_app/utils/colors/colors.dart';
import 'package:pitch_me_app/utils/extras/extras.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_viewer/video_viewer.dart';

import '../../../utils/sizeConfig/sizeConfig.dart';
import '../../../utils/widgets/containers/containers.dart';

class GuestAddSaleshTotorialVideoPage extends StatefulWidget {
  const GuestAddSaleshTotorialVideoPage({super.key});

  @override
  State<GuestAddSaleshTotorialVideoPage> createState() =>
      _GuestAddSaleshTotorialVideoPageState();
}

class _GuestAddSaleshTotorialVideoPageState
    extends State<GuestAddSaleshTotorialVideoPage> {
  VideoViewerController videoViewerController = VideoViewerController();

  bool isCheckTutorial = false;
  bool playTutorial = false;
  bool isLoading = false;

  @override
  void initState() {
    checkGuest();

    super.initState();
  }

  void checkGuest() async {
    setState(() {
      isLoading = true;
    });
    SharedPreferences preferencesData = await SharedPreferences.getInstance();
    setState(() {
      if (preferencesData.getBool('addsalestutorial') != null) {
        playTutorial = preferencesData.getBool('addsalestutorial')!;
        isCheckTutorial = preferencesData.getBool('addsalestutorial')!;
      }
    });
    setState(() {
      isLoading = false;
    });
  }

  void checkDontShow(bool check) async {
    SharedPreferences preferencesData = await SharedPreferences.getInstance();
    setState(() {
      preferencesData.setBool('addsalestutorial', check).toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerTop,
      body: playTutorial == false
          ? TitleTutorialPage(
              title: 'Add Sales Pitch',
              pageIndex: 2,
              isCheck: isCheckTutorial,
              onPlay: () {
                setState(() {
                  playTutorial = true;
                });
              },
              onNext: () {
                videoViewerController.pause();

                Get.to(() => LoginLimitationPage())!.then((value) {
                  setState(() {
                    checkGuest();
                  });
                });
              },
              onCheck: (value) {
                setState(() {
                  isCheckTutorial = value!;
                  checkDontShow(isCheckTutorial);
                });
              })
          : Stack(
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
                            'https://d2vaqd2kfxjiiz.cloudfront.net/pitchme/addtutorial.mp4'),
                      )
                    },
                  ),
                ),
                CustomAppbar(
                  title: 'Add Sales Pitch',
                  notifyIconForTutorial: true,
                  onPressad: () {
                    videoViewerController.pause();

                    Get.to(() => GuestManuPage(
                          title: 'Add Sales Pitch',
                          pageIndex: 2,
                        ));
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
                            videoViewerController.pause();

                            Get.to(() => LoginLimitationPage());
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                NewCustomBottomBar(
                  index: 2,
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
