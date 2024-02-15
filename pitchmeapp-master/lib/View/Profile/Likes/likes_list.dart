import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pitch_me_app/View/Custom%20header%20view/appbar_with_white_bg.dart';
import 'package:pitch_me_app/View/Custom%20header%20view/new_bottom_bar.dart';
import 'package:pitch_me_app/View/Manu/manu.dart';
import 'package:pitch_me_app/View/Profile/Likes/controller.dart';
import 'package:pitch_me_app/View/Profile/Likes/detail_page.dart';
import 'package:pitch_me_app/View/Profile/Likes/model.dart';
import 'package:pitch_me_app/utils/colors/colors.dart';
import 'package:pitch_me_app/utils/sizeConfig/sizeConfig.dart';
import 'package:pitch_me_app/utils/widgets/Navigation/custom_navigation.dart';
import 'package:video_viewer/video_viewer.dart';

import '../../../utils/extras/extras.dart';
import '../../../utils/strings/images.dart';
import '../../../utils/widgets/Alert Box/delete_sales_post.dart';
import '../../../utils/widgets/containers/containers.dart';
import '../../../utils/widgets/extras/backgroundWidget.dart';

class LikesListPage extends StatefulWidget {
  const LikesListPage({super.key});

  @override
  State<LikesListPage> createState() => _LikesListPageState();
}

class _LikesListPageState extends State<LikesListPage> {
  VideoViewerController _videoPlayerController = VideoViewerController();

  LikesController controller = Get.put(LikesController());

  // Future _initVideoPlayer(url) async {
  //   //videoViewerControllerList = [];
  //   try {
  //     _videoPlayerController = VideoPlayerController.network(url);
  //     await _videoPlayerController.initialize();
  //     await _videoPlayerController.setLooping(true);
  //     await _videoPlayerController.pause();
  //   } catch (e) {
  //     log('message = ' + e.toString());
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackGroundWidget(
        backgroundImage: Assets.backgroundImage,
        bannerRequired: false,
        fit: BoxFit.fill,
        child: Stack(
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
                _postListWidget(),
              ],
            ),
            CustomAppbarWithWhiteBg(
              title: 'Likes',
              checkNext: 'back',
              onPressad: () {
                PageNavigateScreen().push(
                    context,
                    ManuPage(
                      title: 'Likes',
                      pageIndex: 3,
                      isManu: 'Manu',
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

  Widget _postListWidget() {
    return Expanded(
      flex: 3,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(
                  left: SizeConfig.getSize25(context: context),
                  right: SizeConfig.getSize25(context: context)),
              child: FutureBuilder<SavedLikeListModel>(
                  future: controller.getSavedLikeListApi(),
                  builder: (context, snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.waiting:
                        return Padding(
                          padding: EdgeInsets.only(
                              top: SizeConfig.getSize100(context: context) +
                                  SizeConfig.getSize50(context: context)),
                          child: const Center(
                              child: CircularProgressIndicator(
                            color: DynamicColor.gredient1,
                          )),
                        );
                      default:
                        if (snapshot.hasError) {
                          // log(snapshot.error.toString());
                          return Padding(
                            padding: EdgeInsets.only(
                                top: SizeConfig.getSize100(context: context) +
                                    SizeConfig.getSize50(context: context)),
                            child:
                                const Center(child: Text('No likes available')),
                          );
                        } else if (snapshot.data!.result.isEmpty) {
                          return Padding(
                            padding: EdgeInsets.only(
                                top: SizeConfig.getSize100(context: context) +
                                    SizeConfig.getSize50(context: context)),
                            child:
                                const Center(child: Text('No likes available')),
                          );
                        } else {
                          return GridView.builder(
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                childAspectRatio: MediaQuery.of(context)
                                        .size
                                        .width /
                                    (MediaQuery.of(context).size.height * 0.70),
                              ),
                              shrinkWrap: true,
                              primary: false,
                              itemCount: snapshot.data!.result.length,
                              padding: EdgeInsets.zero,
                              itemBuilder: (context, index) {
                                LikeResult data = snapshot.data!.result[index];
                                String url = Uri.encodeFull(
                                    'http://191.101.229.245:9070/' + data.file);

                                return Card(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15)),
                                  child: Container(
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: DynamicColor.black),
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          gradient:
                                              DynamicColor.gradientColorChange),
                                      child: Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            child: SizedBox(
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              child: data.file.isNotEmpty
                                                  ? VideoViewer(
                                                      // controller: _videoPlayerController,
                                                      autoPlay: false,
                                                      enableHorizontalSwapingGesture:
                                                          false,
                                                      enableVerticalSwapingGesture:
                                                          false,
                                                      volumeManager:
                                                          VideoViewerVolumeManager
                                                              .device,
                                                      onFullscreenFixLandscape:
                                                          false,
                                                      forwardAmount: 5,
                                                      defaultAspectRatio:
                                                          9 / 16,
                                                      rewindAmount: -5,
                                                      looping: true,
                                                      enableChat: true,
                                                      enableShowReplayIconAtVideoEnd:
                                                          false,
                                                      source: {
                                                        "Source": VideoSource(
                                                          video:
                                                              VideoPlayerController
                                                                  .network(url),
                                                        )
                                                      },
                                                    )
                                                  : Image.asset(
                                                      'assets/images/not_video.jpg',
                                                      height:
                                                          MediaQuery.of(context)
                                                              .size
                                                              .height,
                                                      // width: 100,
                                                      fit: BoxFit.cover,
                                                    ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Align(
                                              alignment: Alignment.topRight,
                                              child: InkWell(
                                                onTap: () {
                                                  showDialog(
                                                      context: context,
                                                      builder: (context) =>
                                                          DeleteSalesPostPopUp(
                                                            id: data.id,
                                                            type: 'Likes',
                                                          )).then((value) {
                                                    setState(() {});
                                                  });
                                                },
                                                child: Image.asset(
                                                  'assets/imagess/Group 200.png',
                                                  height: 20,
                                                  width: 20,
                                                ),
                                              ),
                                            ),
                                          ),
                                          InkWell(
                                              onTap: () {
                                                PageNavigateScreen().push(
                                                    context,
                                                    ShowFullVideoPage(
                                                      url: url,
                                                      pitchID: data.id,
                                                    ));
                                              },
                                              child: CircleAvatar(
                                                radius: 15,
                                                backgroundColor:
                                                    Colors.transparent,
                                                backgroundImage: AssetImage(
                                                    'assets/imagess/ic_play_circle_filled_24px.png'),
                                              ))
                                        ],
                                      )
                                      //VideoPlayer(_videoPlayerController),
                                      //)

                                      ),
                                );
                                // Padding(
                                //   padding: const EdgeInsets.all(8.0),
                                //   child: GestureDetector(
                                //     onTap: () {
                                //       // Get.to(() => PostDetailPage(
                                //       //       data: data,
                                //       //     ));
                                //     },
                                //     child: Stack(
                                //       alignment: Alignment.topRight,
                                //       children: [
                                //         _leadImgeAndTitle(data, index),
                                //         _removeButton(index, data.id)
                                //       ],
                                //     ),
                                //   ),
                                // );
                              });
                        }
                    }
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
    _videoPlayerController.pause();
    super.dispose();
  }
}
