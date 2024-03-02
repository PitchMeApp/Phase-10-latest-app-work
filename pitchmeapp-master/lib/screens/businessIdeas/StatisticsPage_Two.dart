import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:isolate';
import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pitch_me_app/View/posts/model.dart';
import 'package:pitch_me_app/screens/businessIdeas/home%20biography/home_page_biography.dart';
import 'package:pitch_me_app/utils/colors/colors.dart';
import 'package:pitch_me_app/utils/extras/extras.dart';
import 'package:pitch_me_app/utils/sizeConfig/sizeConfig.dart';
import 'package:pitch_me_app/utils/strings/images.dart';
import 'package:pitch_me_app/utils/widgets/Alert%20Box/show_image_popup.dart';
import 'package:pitch_me_app/utils/widgets/extras/backgroundWidget.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../Phase 6/Guest UI/Guest limitation pages/pro_user_limitation.dart';
import '../../devApi Service/get_api.dart';
import '../../utils/styles/styles.dart';
import '../../utils/widgets/Navigation/custom_navigation.dart';
import '../../utils/widgets/extras/directVideoViewer.dart';

class StatisticsPage_Two extends StatefulWidget {
  final PageController pagecont;
  final SalesDoc salesDoc;

  int newIndex;

  SalesPitchListModel postModel;
  StatisticsPage_Two({
    Key? key,
    required this.pagecont,
    required this.salesDoc,
    required this.newIndex,
    required this.postModel,
  }) : super(key: key);

  @override
  State<StatisticsPage_Two> createState() => _StatisticsPage_TwoState();
}

class _StatisticsPage_TwoState extends State<StatisticsPage_Two> {
  ReceivePort port = ReceivePort();

  List typeList = [];
  List serviceList = [];
  List serviceDetailList = [];
  List whocanwatchList = [];

  late SalesDoc salesDoc;

  String userType = '';
  String adminUser = '';
  String userID = '';
  String checkGuestType = '';
  String businesstype = '';
  String fundingPhase = '';

  dynamic proUser;

  bool isCheckProUser = false;

  @override
  void initState() {
    salesDoc = widget.salesDoc;
    checkGuest();
    var type = salesDoc.type.replaceAll('[', '').replaceAll(']', '');

    if (type.contains(' ')) {
      typeList = type.split(', ');
    } else {
      typeList = type.split(',');
    }
    if (typeList.isNotEmpty) {
      if (typeList.length > 1) {
        typeList.sort((a, b) => a.length.compareTo(b.length));
        //typeList.removeAt(0);
      }
    }

    var service = salesDoc.services.replaceAll('[', '').replaceAll(']', '');
    if (service.isNotEmpty) {
      serviceList = service.split(', ');
    }
    var serviceDetail =
        salesDoc.servicesDetail.replaceAll('[', '').replaceAll(']', '');
    if (serviceDetail.isNotEmpty) {
      serviceDetailList = serviceDetail.split(', ');
    }
    var whoCanWatch =
        salesDoc.whocanwatch.replaceAll('[', '').replaceAll(']', '');
    if (whoCanWatch.isNotEmpty) {
      whocanwatchList = whoCanWatch.split(', ');
    }
    if (salesDoc.fundingPhase != null) {
      fundingPhase = salesDoc.fundingPhase;
    }

    //.replaceAll('[', '').replaceAll(']', '');

    // if (fundingPhase.isNotEmpty) {
    //   fundingPhaseList = fundingPhase.split(', ');
    // }
    checkUserType();
    super.initState();
  }

  void checkUserType() {
    if (salesDoc.user.logType == 1) {
      userType = 'Business Idea';
    } else if (salesDoc.user.logType == 2) {
      userType = 'Business Owner';
    } else if (salesDoc.user.logType == 3) {
      userType = 'Investor';
    } else if (salesDoc.user.logType == 4) {
      userType = 'Service Provider';
    } else {
      userType = 'Admin';
    }
  }

  void checkGuest() async {
    SharedPreferences preferencesData = await SharedPreferences.getInstance();
    setState(() {
      checkGuestType = preferencesData.getString('guest').toString();
      userID = preferencesData.getString('user_id').toString();
      if (checkGuestType != 'null') {
        businesstype = preferencesData.getString('log_type').toString();
        adminUser = preferencesData.getString('bot').toString();
        proUser = jsonDecode(preferencesData.getString('pro_user').toString());
        checkUser();
      }

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
    log('test = ' + salesDoc.toJson().toString());
    return Scaffold(
      body: BackGroundWidget(
        backgroundImage: Assets.backgroundImage,
        fit: BoxFit.fill,
        child: Stack(
          children: [
            Column(
              children: [
                spaceHeight(SizeConfig.getSize50(context: context)),
                Flexible(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            // bottom: Platform.isAndroid
                            //     ? SizeConfig.getSize60(context: context)
                            //     : SizeConfig.getSize60(context: context) +
                            // SizeConfig.getSize15(context: context),
                            left: SizeConfig.getFontSize25(context: context),
                            right: SizeConfig.getFontSize25(context: context)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  gradient: DynamicColor.gradientColorChange,
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(10),
                                      bottomLeft: Radius.circular(10))),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: InkWell(
                                  onTap: () async {
                                    if (isCheckProUser) {
                                      try {
                                        Share.share(
                                          'http://salespitchapp.com/share.php?id=${widget.postModel.result!.docs[widget.newIndex].id}',
                                        );
                                      } catch (e) {
                                        log(e.toString());
                                        //Navigator.of(context).pop();
                                      }
                                    } else {
                                      videoViewerControllerList[widget.newIndex]
                                          .pause();
                                      PageNavigateScreen()
                                          .push(
                                              context,
                                              ProUserLimitationPage(
                                                pageIndex: 1,
                                              ))
                                          .then((value) {
                                        videoViewerControllerList[
                                                widget.newIndex]
                                            .play();
                                      });
                                    }
                                  },
                                  child: Image.asset(
                                    'assets/imagess/share.png',
                                    height: 30,
                                    width: 30,
                                    color: DynamicColor.white,
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                widget.pagecont.previousPage(
                                    duration: Duration(milliseconds: 200),
                                    curve: Curves.linear);
                              },
                              child: Padding(
                                  padding: EdgeInsets.only(bottom: 10),
                                  child: /* SvgPicture.asset(Assets.tiktokPreviousIco),*/
                                      RotatedBox(
                                    quarterTurns: 6,
                                    child: Image.asset(
                                      "assets/Phase 2 icons/ic_keyboard_arrow_down_24px.png",
                                      height: SizeConfig.getSize35(
                                          context: context),
                                      width: SizeConfig.getSize35(
                                          context: context),
                                    ),
                                  )),
                            ),
                            widget.postModel.result!.docs.length >
                                    widget.newIndex
                                ? userID ==
                                            widget
                                                .postModel
                                                .result!
                                                .docs[widget.newIndex]
                                                .user
                                                .id ||
                                        businesstype == '5'
                                    ? Container(
                                        decoration: BoxDecoration(
                                            gradient: DynamicColor
                                                .gradientColorChange,
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(10),
                                                bottomRight:
                                                    Radius.circular(10))),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: InkWell(
                                            onTap: () async {
                                              openDilog();
                                              await GetApiService()
                                                  .shareVideoApi(widget
                                                      .postModel
                                                      .result!
                                                      .docs[widget.newIndex]
                                                      .vid1)
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
                      ),
                      Expanded(child: appStatistics(context: context)),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget appStatistics({required BuildContext context}) {
    return SingleChildScrollView(
      child: Center(
          child: Column(
        children: [
          customWidget('What Industry', salesDoc.industry, onPressad: () {}),
          // customWidget(
          //     'assets/images/ic_place_24px-mdpi.png', salesDoc.location,
          //     onPressad: () {}),
          typeList.length > 0
              ? customWidget(
                  'Who is Needed',
                  typeList[0] == 'Facilitator'
                      ? 'Service Provider'
                      : typeList[0].replaceAll(',', ''),
                  onPressad: () {})
              : Container(),
          salesDoc.valueamount.isNotEmpty
              ? customWidget('How much', 'USD ${salesDoc.valueamount}',
                  onPressad: () {})
              : Container(),
          fundingPhase.isEmpty || fundingPhase == '[]'
              ? Container()
              : customWidget("Funding Phase", fundingPhase, onPressad: () {}),

          typeList.length > 1 && typeList[1].isNotEmpty
              ? customWidget(
                  'Who is Needed',
                  typeList[1] == 'Facilitator'
                      ? 'Service Provider'
                      : typeList[1],
                  onPressad: () {})
              : Container(),
          serviceList.isNotEmpty
              ? ListView.builder(
                  shrinkWrap: true,
                  primary: false,
                  padding: EdgeInsets.zero,
                  itemCount: serviceList.length,
                  itemBuilder: (context, index) {
                    return customWidget("What is Needed", serviceList[index],
                        onPressad: () {});
                  })
              : Container(),
          serviceDetailList.isNotEmpty
              ? ListView.builder(
                  shrinkWrap: true,
                  primary: false,
                  padding: EdgeInsets.zero,
                  itemCount: serviceDetailList.length,
                  itemBuilder: (context, index) {
                    return customWidget(
                        "What is Needed", serviceDetailList[index],
                        onPressad: () {});
                  })
              : Container(),
          offerDetailWidget('Initial Offer', widget.salesDoc.description,
              onPressad: () {}),
          whocanwatchList.isNotEmpty
              ? ListView.builder(
                  shrinkWrap: true,
                  primary: false,
                  padding: EdgeInsets.zero,
                  itemCount: whocanwatchList.length,
                  itemBuilder: (context, index) {
                    return customWidget("Who can see", whocanwatchList[index],
                        onPressad: () {
                      //PageNavigateScreen().push(context, NeedPage());
                    });
                  })
              : Container(),
          customWidget('User Type', userType, onPressad: () {}),
          customWidget('Profile', 'Biography', onPressad: () {
            PageNavigateScreen().push(
                context,
                HomeBiographyPage(
                  type: 'Biography',
                  userID: salesDoc.userid,
                  notifyID: '',
                ));
          }),
          SizedBox(height: 10),
          Align(
            alignment: Alignment.center,
            child: Wrap(
              runSpacing: 10,
              spacing: 10,
              children: [
                salesDoc.img1.isNotEmpty
                    ? imageWidget(salesDoc.img1)
                    : Container(
                        height: 0,
                        width: 0,
                      ),
                salesDoc.img2.isNotEmpty
                    ? imageWidget(salesDoc.img2)
                    : Container(
                        height: 0,
                        width: 0,
                      ),
                salesDoc.img3.isNotEmpty
                    ? imageWidget(salesDoc.img3)
                    : Container(
                        height: 0,
                        width: 0,
                      ),
                salesDoc.file.isNotEmpty
                    ? pdfWidget(salesDoc.file)
                    : Container(
                        height: 0,
                        width: 0,
                      ),
              ],
            ),
          ),
          spaceHeight(SizeConfig.getSize100(context: context)),
        ],
      )),
    );
  }

  Widget customWidget(title, name, {required VoidCallback onPressad}) {
    final sizeH = MediaQuery.of(context).size.height;

    return InkWell(
      onTap: onPressad,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(2.0),
            child: Text(title, style: black14w5),
          ),
          Padding(
            padding: EdgeInsets.only(
              left: SizeConfig.getFontSize25(context: context),
              right: SizeConfig.getFontSize25(context: context),
            ),
            child: Card(
              elevation: 10,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              child: Container(
                  height: sizeH * 0.068,
                  alignment: Alignment.center,
                  padding: EdgeInsets.only(
                    left: 5,
                    right: 5,
                  ),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      gradient: DynamicColor.gradientColorChange),
                  child: Text(
                    name,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w500),
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  )),
            ),
          ),
        ],
      ),
    );
  }

  Widget offerDetailWidget(title, name, {required VoidCallback onPressad}) {
    final sizeH = MediaQuery.of(context).size.height;

    int wordscount = RegExp.escape(name).length;

    return Padding(
      padding: EdgeInsets.only(
        left: SizeConfig.getFontSize20(context: context),
        right: SizeConfig.getFontSize20(context: context),
      ),
      child: InkWell(
        onTap: onPressad,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(2.0),
              child: Text(title, style: black14w5),
            ),
            Card(
              elevation: 10,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              child: Container(
                  height: wordscount > 70 ? null : sizeH * 0.068,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      gradient: DynamicColor.gradientColorChange),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 5, top: 5),
                    child: Text(
                      name,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w500),
                      textAlign: TextAlign.center,
                    ),
                  )),
            ),
          ],
        ),
      ),
    );
  }

  Widget imageWidget(url) {
    return InkWell(
      onTap: () {
        showDialog(
            context: context,
            builder: (context) => ShowFullImagePopup(image_url: url));
      },
      child: Container(
        height: SizeConfig.getSizeHeightBy(context: context, by: 0.16),
        width: SizeConfig.getSizeWidthBy(context: context, by: 0.43),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            image:
                DecorationImage(image: NetworkImage(url), fit: BoxFit.cover)),
      ),
    );
  }

  Widget pdfWidget(url) {
    return InkWell(
      onTap: () {
        launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
      },
      child: Container(
        height: SizeConfig.getSizeHeightBy(context: context, by: 0.16),
        width: SizeConfig.getSizeWidthBy(context: context, by: 0.43),
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: const [Color(0xff5388C0), Color(0xff67C8B5)]),
            borderRadius: BorderRadius.circular(10),
            image: DecorationImage(
                fit: BoxFit.cover, image: AssetImage('assets/images/pdf.png'))),
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
    try {
      var status = await Platform.isAndroid
          ? Permission.storage.request()
          : Permission.photos.request();

      //if (status.isGranted) {

      var appDocDir = Platform.isAndroid
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
        final result = await ImageGallerySaver.saveFile(savePath);

        // ignore: use_build_context_synchronously
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
    IsolateNameServer.removePortNameMapping('downloader_send_port');
    super.dispose();
  }
}
