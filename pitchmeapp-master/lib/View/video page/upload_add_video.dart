import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pitch_me_app/View/video%20page/Controller/controller.dart';
import 'package:pitch_me_app/View/video%20page/video_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_viewer/video_viewer.dart';

import '../../Phase 6/Guest UI/Guest limitation pages/pro_user_limitation.dart';
import '../../utils/colors/colors.dart';
import '../../utils/sizeConfig/sizeConfig.dart';
import '../../utils/strings/images.dart';
import '../../utils/strings/strings.dart';
import '../../utils/styles/styles.dart';
import '../../utils/widgets/Navigation/custom_navigation.dart';
import '../../utils/widgets/extras/backgroundWidget.dart';
import '../Custom header view/custom_header_view.dart';
import '../Custom header view/new_bottom_bar.dart';

class UploadAndAddImage extends StatefulWidget {
  const UploadAndAddImage({super.key});

  @override
  State<UploadAndAddImage> createState() => _UploadAndAddImageState();
}

class _UploadAndAddImageState extends State<UploadAndAddImage> {
  GlobalKey<FormState> abcKey = GlobalKey<FormState>();
  VideoFirstPageController controller = Get.put(VideoFirstPageController());
  VideoViewerController videoPlayerController = VideoViewerController();

  String videoType = 'Self';
  String adminUser = '';
  String businesstype = '';
  dynamic proUser;

  bool isCheckProUser = false;

  @override
  void initState() {
    super.initState();
    checkGuest();
  }

  void checkGuest() async {
    SharedPreferences preferencesData = await SharedPreferences.getInstance();
    setState(() {
      businesstype = preferencesData.getString('log_type').toString();
      adminUser = preferencesData.getString('bot').toString();
      proUser = jsonDecode(preferencesData.getString('pro_user').toString());
    });
    checkUser();
  }

  void checkUser() {
    if (adminUser == 'null' && businesstype != '5') {
      if (proUser != null) {
        setState(() {
          isCheckProUser = true;
        });
      }
    } else {
      setState(() {
        isCheckProUser = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BackGroundWidget(
      backgroundImage: Assets.backgroundImage,
      fit: BoxFit.fill,
      child: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: SizeConfig.getSize100(context: context) +
                      SizeConfig.getSize55(context: context),
                ),
                const SizedBox(height: 30),
                Container(
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(color: DynamicColor.black))),
                  child: Text(
                    TextStrings.textKey['self_record']!,
                    style: textColor22,
                  ),
                ),
                const SizedBox(height: 30),
                uploadImage(),
                const SizedBox(height: 10),
                uploadFile(),
                const SizedBox(height: 5),
                Text(
                  'Note: Maximum 15MB file size allowed',
                  style: TextStyle(color: DynamicColor.textColor, fontSize: 15),
                ),
                const SizedBox(height: 1),
                video(),
                SizedBox(
                    height:
                        SizeConfig.getSizeHeightBy(context: context, by: 0.15))
              ],
            ),
          ),
          CustomHeaderView(
            progressPersent: 0.9,
            checkNext: controller.videoUrl.value.isNotEmpty ? 'check' : null,
            nextOnTap: () {
              // if (videoType == 'upload') {
              //   PageNavigateScreen().push(
              //       context,
              //       ShowUploadVideoPage(
              //         filePath: controller.videoUrl.value,
              //       ));
              // } else {
              PageNavigateScreen().push(
                  context,
                  VideoPageMain(
                    key: abcKey,
                    type: videoType,
                  ));
              // }
            },
          ),
          NewCustomBottomBar(
            index: 2,
          ),
        ],
      ),
    ));
  }

  Widget uploadImage() {
    return Padding(
      padding: EdgeInsets.only(
        left: SizeConfig.getSize50(context: context),
        right: SizeConfig.getSize50(context: context),
      ),
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Container(
          height: MediaQuery.of(context).size.height * 0.2,
          alignment: Alignment.center,
          child: InkWell(
            onTap: () {
              setState(() {
                controller.videoUrl.value = '';
                videoType = 'self';
              });
              PageNavigateScreen().push(
                  context,
                  VideoPageMain(
                    key: abcKey,
                    type: videoType,
                  ));
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 50,
                  width: 50,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      gradient: DynamicColor.gradientColorChange,
                      borderRadius: BorderRadius.circular(50)),
                  child: Icon(
                    Icons.add,
                    color: DynamicColor.white,
                    size: 30,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  'Self Record Pitch',
                  style: TextStyle(color: DynamicColor.textColor),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget uploadFile() {
    return Padding(
      padding: EdgeInsets.only(
        left: SizeConfig.getSize50(context: context),
        right: SizeConfig.getSize50(context: context),
      ),
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Container(
          height: MediaQuery.of(context).size.height * 0.2,
          alignment: Alignment.center,
          child: InkWell(
            onTap: () {
              setState(() {
                controller.videoUrl.value = '';
                videoType = 'upload';
              });
              if (isCheckProUser) {
                controller.selectVideos(context).then((value) {
                  // PageNavigateScreen().push(
                  //     context,
                  //     ShowUploadVideoPage(
                  //       filePath: controller.videoUrl.value,
                  //     ));
                  setState(() {});
                });
              } else {
                PageNavigateScreen().push(
                    context,
                    ProUserLimitationPage(
                      pageIndex: 2,
                    ));
              }
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                    height: 50,
                    width: 50,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        gradient: DynamicColor.gradientColorChange,
                        borderRadius: BorderRadius.circular(50)),
                    child: Image.asset(
                      'assets/imagess/Path 103.png',
                      height: 25,
                      width: 25,
                    )),
                SizedBox(height: 5),
                Text(
                  'Upload',
                  style: TextStyle(color: DynamicColor.textColor),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget video() {
    return controller.videoUrl.value.isEmpty
        ? Container()
        : GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: MediaQuery.of(context).size.width /
                  (MediaQuery.of(context).size.height * 0.65),
            ),
            physics: NeverScrollableScrollPhysics(),
            padding:
                EdgeInsets.only(left: SizeConfig.getSize50(context: context)),
            itemCount: 1,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: VideoViewer(
                          //controller: videoPlayerController,
                          autoPlay: false,
                          enableHorizontalSwapingGesture: false,
                          enableVerticalSwapingGesture: false,
                          volumeManager: VideoViewerVolumeManager.device,
                          onFullscreenFixLandscape: false,
                          forwardAmount: 5,
                          defaultAspectRatio: 9 / 16,
                          rewindAmount: -5,
                          looping: true,
                          enableChat: true,
                          enableShowReplayIconAtVideoEnd: false,
                          source: {
                            "Source": VideoSource(
                              video: VideoPlayerController.file(
                                  File(controller.videoUrl.value)),
                            )
                          },
                        ),
                      ),
                      InkWell(onTap: () {
                        setState(() {
                          controller.videoUrl.value = '';
                        });
                        controller.selectVideos(context).then((value) {
                          setState(() {});
                        });
                      }),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Align(
                          alignment: Alignment.topRight,
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                controller.videoUrl.value = '';
                              });
                            },
                            child: Container(
                              height: 20,
                              width: 20,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(2),
                                  gradient: DynamicColor.gradientColorChange),
                              child: Icon(
                                Icons.close,
                                color: DynamicColor.white,
                                size: 15,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            });
  }
}
