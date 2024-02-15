import 'package:flutter/material.dart';
import 'package:pitch_me_app/utils/colors/colors.dart';
import 'package:pitch_me_app/utils/extras/extras.dart';
import 'package:pitch_me_app/utils/sizeConfig/sizeConfig.dart';
import 'package:video_viewer/video_viewer.dart';

import '../../../../utils/widgets/containers/containers.dart';

class ShowFullVideo extends StatefulWidget {
  String videoUrl;
  ShowFullVideo({super.key, required this.videoUrl});

  @override
  State<ShowFullVideo> createState() => _ShowFullVideoState();
}

class _ShowFullVideoState extends State<ShowFullVideo> {
  VideoViewerController videoViewerController = VideoViewerController();
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: DynamicColor.black,
      contentPadding: EdgeInsets.zero,
      insetPadding: EdgeInsets.only(left: 10, right: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      content: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Stack(
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
                enableChat: true,
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
                    thumbnail: Image.asset(''),
                    loading: CircularProgressIndicator(
                      color: DynamicColor.gredient1,
                    )),
                source: {
                  "Source": VideoSource(
                    video: VideoPlayerController.network(widget.videoUrl),
                  )
                },
              ),
            ),
            backIcon(),
          ],
        ),
      ),
    );
  }

  Widget backIcon() {
    return Padding(
      padding: EdgeInsets.only(
        top: SizeConfig.getSize30(context: context),
        left: SizeConfig.getFontSize25(context: context),
      ),
      child: AppBarIconContainer(
        onTap: () {
          Navigator.of(context).pop();
        },
        height: SizeConfig.getSize38(context: context),
        width: SizeConfig.getSize38(context: context),
        // color: DynamicColor.gredient1,
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(10), bottomLeft: Radius.circular(10)),
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: RotatedBox(
            quarterTurns: 1,
            child: Image.asset(
                "assets/Phase 2 icons/ic_keyboard_arrow_down_24px.png",
                height: 30,
                width: 30,
                color: DynamicColor.white),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    videoViewerController.pause();
    videoViewerController.dispose();
  }
}
