import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pitch_me_app/Phase%206/Guest%20UI/Profile/manu.dart';
import 'package:pitch_me_app/View/Custom%20header%20view/appbar_with_white_bg.dart';
import 'package:pitch_me_app/View/Custom%20header%20view/new_bottom_bar.dart';
import 'package:pitch_me_app/View/Manu/Tutorials/controller.dart';
import 'package:pitch_me_app/View/Manu/manu.dart';
import 'package:pitch_me_app/View/Profile/Likes/detail_page.dart';
import 'package:pitch_me_app/utils/colors/colors.dart';
import 'package:pitch_me_app/utils/sizeConfig/sizeConfig.dart';
import 'package:pitch_me_app/utils/styles/styles.dart';
import 'package:pitch_me_app/utils/widgets/Navigation/custom_navigation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_viewer/video_viewer.dart';

import '../../../utils/extras/extras.dart';
import '../../../utils/strings/images.dart';
import '../../../utils/widgets/containers/containers.dart';
import '../../../utils/widgets/extras/backgroundWidget.dart';
import '../../Feedback/controller.dart';

class TutorialsPage extends StatefulWidget {
  int pageIndex;
  TutorialsPage({
    super.key,
    required this.pageIndex,
  });

  @override
  State<TutorialsPage> createState() => _TutorialsPageState();
}

class _TutorialsPageState extends State<TutorialsPage> {
  // late VideoPlayerController _videoPlayerController;

  TutorialController controller = Get.put(TutorialController());
  FeebackController feebackController = Get.put(FeebackController());
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
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackGroundWidget(
        backgroundImage: Assets.backgroundImage,
        bannerRequired: false,
        fit: BoxFit.fill,
        child: Stack(
          // alignment: Alignment.center,
          children: [
            Column(
              children: [
                Expanded(
                  child: Column(
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
                    ],
                  ),
                ),
                tutorialsListWidget(),
              ],
            ),
            CustomAppbarWithWhiteBg(
              title: 'Tutorials',
              checkNext: 'back',
              onPressad: () {
                if (checkGuestType == 'null' && checkGuestType.isNotEmpty) {
                  PageNavigateScreen().push(
                      context,
                      GuestManuPage(
                        title: 'Tutorials',
                        pageIndex: widget.pageIndex,
                      ));
                } else {
                  PageNavigateScreen().push(
                      context,
                      ManuPage(
                        title: 'Tutorials',
                        pageIndex: widget.pageIndex,
                        isManu: 'Manu',
                      ));
                }
              },
            ),
            NewCustomBottomBar(
              index: widget.pageIndex,
              isBack: checkGuestType == 'null' ? 'Guest' : true,
            ),
          ],
        ),
      ),
    );
  }

  Widget tutorialsListWidget() {
    return Expanded(
      flex: 3,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(
                  left: SizeConfig.getSize25(context: context),
                  right: SizeConfig.getSize25(context: context)),
              child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: MediaQuery.of(context).size.width /
                        (MediaQuery.of(context).size.height * 0.80),
                  ),
                  shrinkWrap: true,
                  primary: false,
                  //reverse: true,
                  padding: EdgeInsets.zero,
                  itemCount: controller.tutorialList.value.length,
                  itemBuilder: (context, index) {
                    dynamic data = controller.tutorialList.value[index];

                    return Column(
                      children: [
                        SizedBox(
                          height: SizeConfig.getSizeHeightBy(
                              context: context, by: 0.19),
                          child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                            child: Container(
                                decoration: BoxDecoration(
                                    border:
                                        Border.all(color: DynamicColor.black),
                                    borderRadius: BorderRadius.circular(15),
                                    gradient: DynamicColor.gradientColorChange),
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(15),
                                      child: SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        child: VideoViewer(
                                          // controller: _videoPlayerController,
                                          autoPlay: false,
                                          enableHorizontalSwapingGesture: false,
                                          enableVerticalSwapingGesture: false,
                                          volumeManager:
                                              VideoViewerVolumeManager.device,
                                          onFullscreenFixLandscape: false,
                                          forwardAmount: 5,
                                          defaultAspectRatio: 9 / 16,
                                          rewindAmount: -5,
                                          looping: true,
                                          enableChat: true,
                                          enableShowReplayIconAtVideoEnd: false,
                                          source: {
                                            "Source": VideoSource(
                                              video:
                                                  VideoPlayerController.network(
                                                      data['url']),
                                            )
                                          },
                                        ),
                                      ),
                                    ),
                                    InkWell(
                                        onTap: () {
                                          Get.to(() => ShowFullVideoPage(
                                              url: data['url']));
                                        },
                                        child: CircleAvatar(
                                          radius: 15,
                                          backgroundColor: Colors.transparent,
                                          backgroundImage: AssetImage(
                                              'assets/imagess/ic_play_circle_filled_24px.png'),
                                        ))
                                  ],
                                )),
                          ),
                        ),
                        Text(
                          data['name'],
                          style: textColor15,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    );
                  }),
            ),
            spaceHeight(SizeConfig.getSizeHeightBy(context: context, by: 0.1))
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
