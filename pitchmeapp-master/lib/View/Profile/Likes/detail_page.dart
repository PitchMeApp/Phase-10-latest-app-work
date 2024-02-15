import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'dart:isolate';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pitch_me_app/utils/colors/colors.dart';
import 'package:pitch_me_app/utils/extras/extras.dart';
import 'package:pitch_me_app/utils/styles/styles.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_viewer/video_viewer.dart';

import '../../../devApi Service/get_api.dart';
import '../../../utils/sizeConfig/sizeConfig.dart';
import '../../../utils/widgets/containers/containers.dart';

class ShowFullVideoPage extends StatefulWidget {
  String url;
  String? pitchID;
  String? userID;
  dynamic arrowCheck;
  dynamic status;
  VoidCallback? onPressad;
  ShowFullVideoPage(
      {super.key,
      required this.url,
      this.pitchID,
      this.arrowCheck,
      this.onPressad,
      this.status,
      this.userID});

  @override
  State<ShowFullVideoPage> createState() => _ShowFullVideoPageState();
}

class _ShowFullVideoPageState extends State<ShowFullVideoPage> {
  VideoViewerController videoViewerController = VideoViewerController();
  String userID = '';
  String businesstype = '';

  ReceivePort port = ReceivePort();
  @override
  void initState() {
    super.initState();

    checkGuest();
  }

  void checkGuest() async {
    SharedPreferences preferencesData = await SharedPreferences.getInstance();
    setState(() {
      businesstype = preferencesData.getString('log_type').toString();
      userID = preferencesData.getString('user_id').toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  video: widget.url.contains('https://api.salespitchapp.com')
                      ? VideoPlayerController.network(Uri.encodeFull(widget.url
                          .replaceAll('https://api.salespitchapp.com',
                              'http://191.101.229.245:9070')))
                      : VideoPlayerController.network(widget.url),
                )
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              top: SizeConfig.getSize30(context: context) +
                  MediaQuery.of(context).size.height * 0.021,
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
                  topRight: Radius.circular(10),
                  bottomLeft: Radius.circular(10)),
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
          ),
          widget.arrowCheck != null
              ? Padding(
                  padding: EdgeInsets.only(
                      bottom: 10,
                      left: SizeConfig.getFontSize25(context: context),
                      right: SizeConfig.getFontSize25(context: context)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      widget.status == 2
                          ? Container(
                              decoration: BoxDecoration(
                                  gradient: DynamicColor.gradientColorChange,
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(10),
                                      bottomLeft: Radius.circular(10))),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: InkWell(
                                  onTap: () async {
                                    Share.share(
                                      'http://salespitchapp.com/share.php?id=${widget.pitchID}',
                                    );
                                  },
                                  child: Image.asset(
                                    'assets/imagess/share.png',
                                    height: 30,
                                    width: 30,
                                    color: DynamicColor.white,
                                  ),
                                ),
                              ),
                            )
                          : SizedBox(
                              height: 50,
                              width: 50,
                            ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text('Pitch details', style: gredient116bold),
                            GestureDetector(
                              onTap: widget.onPressad,
                              child: Padding(
                                  padding: EdgeInsets.only(bottom: 5, right: 7),
                                  child: RotatedBox(
                                    quarterTurns: 4,
                                    child: Image.asset(
                                      "assets/Phase 2 icons/ic_keyboard_arrow_down_24px.png",
                                      height: 30,
                                      width: 30,
                                    ),
                                  )),
                            ),
                          ],
                        ),
                      ),
                      userID == widget.userID! || businesstype == '5'
                          ? widget.status == 2
                              ? Container(
                                  decoration: BoxDecoration(
                                      gradient:
                                          DynamicColor.gradientColorChange,
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(10),
                                          bottomRight: Radius.circular(10))),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: InkWell(
                                      onTap: () async {
                                        openDilog();
                                        // Timer(const Duration(seconds: 4), () {
                                        //   Fluttertoast.showToast(
                                        //   msg: 'Downloading in progress...',
                                        //   gravity: ToastGravity.TOP,
                                        // );
                                        // Fluttertoast.showToast(
                                        //     msg:
                                        //         'We will notify you once downloaded.',
                                        //     gravity: ToastGravity.TOP,
                                        //     toastLength: Toast.LENGTH_LONG);
                                        //   Navigator.of(context).pop();
                                        // });
                                        await GetApiService()
                                            .shareVideoApi(widget.url)
                                            .then((value) {
                                          downloadFile(value['message']);
                                        });
                                        Navigator.of(context).pop();
                                      },
                                      child: Image.asset(
                                        'assets/imagess/download.png',
                                        height: 30,
                                        width: 30,
                                        color: DynamicColor.white,
                                      ),
                                    ),
                                  ),
                                )
                              : SizedBox(
                                  height: 50,
                                  width: 50,
                                )
                          : SizedBox(
                              height: 50,
                              width: 50,
                            ),
                    ],
                  ),
                )
              : Container()
        ],
      ),
    );
  }

  void openDilog() {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) => showLoading());
  }

  Widget showLoading() {
    return Center(
        child: SizedBox(
            height: 250,
            child: AlertDialog(
                backgroundColor: DynamicColor.lightGrey,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                alignment: Alignment.center,
                content: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(color: DynamicColor.gredient2),
                    SizedBox(height: 20),
                    Text(
                      'We are increasing quality and adding Watermark. That takes longer than regular downloads. Thank you for your patience',
                      style: gredient115Bold,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ))));
  }

  Future downloadFile(videoUrl) async {
    // String getExtensionFromUrl(String url) =>
    //     url.split('?').first.split('.').last;

    // var ext = getExtensionFromUrl(videoUrl);
    //log(videoUrl);
    try {
      var status = await Platform.isAndroid
          ? Permission.storage.request()
          : Permission.photos.request();

      //if (status.isGranted) {
      final appDocDir = Platform.isAndroid
          ? await getExternalStorageDirectory() //FOR ANDROID
          : await getTemporaryDirectory();

      if (appDocDir != null) {
        var d = DateTime.now().toString();
        String savePath = appDocDir.path + '/Sales-pitch-' + d + ".mp4";
        String fileUrl = videoUrl;
        await Dio().download(fileUrl, savePath,
            onReceiveProgress: (count, total) {
          //print((count / total * 100).toStringAsFixed(0) + "%");
        });
        //log(savePath);
        final result = await ImageGallerySaver.saveFile(savePath);
        myToast(context, msg: 'Download Successfully');
      }
      setState(() {});
      // } else {
      //   Permission.storage.request();
      // }
    } catch (e) {
      myToast(context, msg: e.toString());
      log(e.toString());
    }
  }

  @override
  void dispose() {
    videoViewerController.pause();
    super.dispose();
  }
}
