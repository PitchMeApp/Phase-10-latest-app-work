import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pitch_me_app/View/Profile/Pitches/controller.dart';
import 'package:pitch_me_app/devApi%20Service/get_api.dart';
import 'package:pitch_me_app/screens/businessIdeas/home%20biography/home_page_biography.dart';
import 'package:pitch_me_app/utils/extras/extras.dart';
import 'package:pitch_me_app/utils/sizeConfig/sizeConfig.dart';
import 'package:pitch_me_app/utils/strings/images.dart';
import 'package:pitch_me_app/utils/widgets/Alert%20Box/show_image_popup.dart';
import 'package:pitch_me_app/utils/widgets/Arrow%20Button/back_arrow.dart';
import 'package:pitch_me_app/utils/widgets/Navigation/custom_navigation.dart';
import 'package:pitch_me_app/utils/widgets/extras/backgroundWidget.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../utils/colors/colors.dart';
import '../../utils/styles/styles.dart';

class PostDetailPage extends StatefulWidget {
  final data;
  dynamic arrowCheck;
  String userID;
  VoidCallback? onPressad;
  PostDetailPage(
      {super.key,
      this.data,
      this.arrowCheck,
      this.onPressad,
      required this.userID});

  @override
  State<PostDetailPage> createState() => _PostDetailPageState();
}

class _PostDetailPageState extends State<PostDetailPage> {
  dynamic data;
  List typeList = [];
  List serviceList = [];
  List serviceDetailList = [];
  List whocanwatchList = [];
  String fundingPhase = '';

  String userType = '';
  final PitcheController pitcheController = Get.put(PitcheController());
  dynamic userDetail;
  @override
  void initState() {
    data = widget.data;
    // log(data.toJson().toString());
    getUserDetailApi();
    var type = data.type.toString().replaceAll('[', '').replaceAll(']', '');

    if (type.contains(' ')) {
      typeList = type.split(', ');
      log('dd = ' + typeList.toString());
    } else {
      typeList = type.split(',');
      log('ddd = ' + typeList.toString());
    }

    if (typeList.isNotEmpty) {
      if (typeList.length > 1) {
        typeList.sort((a, b) => a.length.compareTo(b.length));
        // typeList.removeAt(0);
      }
    }

    var service = data.services.replaceAll('[', '').replaceAll(']', '');
    if (service.isNotEmpty) {
      serviceList = service.split(', ');
    }
    var serviceDetail =
        data.servicesDetail.replaceAll('[', '').replaceAll(']', '');
    if (serviceDetail.isNotEmpty) {
      serviceDetailList = serviceDetail.split(', ');
    }
    fundingPhase = data.fundingPhase;
    //.replaceAll('[', '').replaceAll(']', '');

    // if (fundingPhase.isNotEmpty) {
    //   fundingPhaseList = fundingPhase.split(', ');
    // }
    var whoCanWatch = data.whocanwatch.replaceAll('[', '').replaceAll(']', '');
    if (whoCanWatch.isNotEmpty) {
      whocanwatchList = whoCanWatch.split(', ');
    }
    super.initState();
  }

  void getUserDetailApi() async {
    try {
      await GetApiService().getUserDetailApi(widget.userID).then((value) {
        //  log(value.toString());
        if (value != null) {
          setState(() {
            userDetail = value['result'];
            getUserType(value['result']['log_type']);
          });
        }
      });
    } catch (e) {
      userType = 'No user type';
    }
  }

  Future getUserType(type) async {
    if (type == 1) {
      userType = 'Business Idea';
    } else if (type == 2) {
      userType = 'Business Owner';
    } else if (type == 3) {
      userType = 'Investor';
    } else if (type == 4) {
      userType = 'Service Provider';
    } else {
      userType = 'Admin';
    }
  }

  @override
  Widget build(BuildContext context) {
    // log(data.toJson().toString());
    return Scaffold(
      body: BackGroundWidget(
        backgroundImage: Assets.backgroundImage,
        fit: BoxFit.cover,
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  spaceHeight(SizeConfig.getSize40(context: context)),
                  Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        widget.arrowCheck != null
                            ? Align(
                                alignment: Alignment.bottomCenter,
                                child: GestureDetector(
                                  onTap: widget.onPressad,
                                  child: Padding(
                                      padding: EdgeInsets.only(top: 10),
                                      child: RotatedBox(
                                        quarterTurns: 1,
                                        child: Icon(
                                          Icons.arrow_back_ios,
                                          color: DynamicColor.gredient1,
                                          size: 30,
                                        ),
                                      )),
                                ),
                              )
                            : Container(),
                        // Align(
                        //   alignment: Alignment.topLeft,
                        //   child: Padding(
                        //     padding: const EdgeInsets.only(bottom: 10, left: 10),
                        //     child: IconButton(
                        //         onPressed: () {
                        //           Navigator.of(context).pop();
                        //         },
                        //         icon: Icon(Icons.arrow_back)),
                        //   ),
                        // ),
                        appStatistics(context: context),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            widget.arrowCheck == null
                ? BackArrow(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    alignment: Alignment.centerLeft,
                  )
                : Container(),
          ],
        ),
      ),
    );
  }

  Widget appStatistics({required BuildContext context}) {
    return Center(
        child: Column(
      children: [
        customWidget("What Industry", data.industry, onPressad: () async {
          //PageNavigateScreen().push(context, SelectIndustryPage());
        }),
        // customWidget("assets/images/ic_place_24px-mdpi.png", data.location,
        //     onPressad: () {
        //   // PageNavigateScreen().push(context, LocationPage());
        // }),
        typeList.length > 0
            ? customWidget(
                "Who is Needed",
                typeList[0] == 'Facilitator'
                    ? 'Service Provider'
                    : typeList[0].replaceAll(',', ''), onPressad: () {
                //PageNavigateScreen().push(context, WhatNeedPage());
              })
            : Container(),
        data.valueamount.isNotEmpty
            ? customWidget("How much", 'USD ${data.valueamount}',
                onPressad: () {
                // PageNavigateScreen().push(context, FundsPage());
              })
            : Container(),
        fundingPhase.isEmpty || fundingPhase == '[]'
            ? Container()
            : customWidget("Funding Phase", fundingPhase, onPressad: () {}),

        typeList.length > 1 && typeList[1].isNotEmpty
            ? customWidget("Who is Needed",
                typeList[1] == 'Facilitator' ? 'Service Provider' : typeList[1],
                onPressad: () {
                // PageNavigateScreen().push(context, WhatNeedPage());
              })
            : Container(),
        serviceList.isNotEmpty
            ? ListView.builder(
                shrinkWrap: true,
                primary: false,
                padding: EdgeInsets.zero,
                itemCount: serviceList.length,
                itemBuilder: (context, index) {
                  return customWidget("What is Needed", serviceList[index],
                      onPressad: () {
                    //PageNavigateScreen().push(context, NeedPage());
                  });
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
                      onPressad: () {
                    //PageNavigateScreen().push(context, NeedPage());
                  });
                })
            : Container(),
        offerDetailWidget("Initial Offer", data.description,
            onPressad: () async {
          // bytes = await controller.capture();
          // setState(() {});
        }),
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
        customWidget("User Type", userType, onPressad: () {
          //PageNavigateScreen().push(context, OfferPage());
        }),
        customWidget("Profile", 'Biography', onPressad: () {
          PageNavigateScreen().normalpushReplesh(
              context,
              HomeBiographyPage(
                type: 'Biography',
                userID: userDetail['_id'],
                notifyID: '',
              ));
        }),
        spaceHeight(SizeConfig.getSize20(context: context)),
        _imagesGridView(),
        spaceHeight(SizeConfig.getSize50(context: context)),
      ],
    ));
  }

  Widget _imagesGridView() {
    return Align(
      alignment: Alignment.center,
      child: Wrap(
        runSpacing: 10,
        spacing: 10,
        children: [
          data.img1.isNotEmpty
              ? imageWidget(data.img1)
              : Container(
                  height: 0,
                  width: 0,
                ),
          data.img2.isNotEmpty
              ? imageWidget(data.img2)
              : Container(
                  height: 0,
                  width: 0,
                ),
          data.img3.isNotEmpty
              ? imageWidget(data.img3)
              : Container(
                  height: 0,
                  width: 0,
                ),
          // data.img4.isNotEmpty
          //     ? imageWidget(data.img4)
          //     : Container(
          //         height: 0,
          //         width: 0,
          //       ),
          data.file.isNotEmpty
              ? pdfWidget(data.file)
              : Container(
                  height: 0,
                  width: 0,
                ),
        ],
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
        // height: 140,
        // width: 160,
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

  Widget customWidget(title, name, {required VoidCallback onPressad}) {
    final sizeH = MediaQuery.of(context).size.height;

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
                  height: sizeH * 0.068,
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
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  )),
            ),
          ],
        ),
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
}
