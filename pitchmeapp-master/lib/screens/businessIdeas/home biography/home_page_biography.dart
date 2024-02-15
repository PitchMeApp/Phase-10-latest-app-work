import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pitch_me_app/View/Custom%20header%20view/new_bottom_bar.dart';
import 'package:pitch_me_app/View/Feedback/controller.dart';
import 'package:pitch_me_app/View/Manu/manu.dart';
import 'package:pitch_me_app/devApi%20Service/post_api.dart';
import 'package:pitch_me_app/main.dart';
import 'package:pitch_me_app/screens/businessIdeas/BottomNavigation.dart';
import 'package:pitch_me_app/screens/businessIdeas/home%20biography/Chat/chat.dart';
import 'package:pitch_me_app/screens/businessIdeas/home%20biography/confirmation_chat.dart';
import 'package:pitch_me_app/screens/businessIdeas/home%20biography/controller.dart';
import 'package:pitch_me_app/utils/colors/colors.dart';
import 'package:pitch_me_app/utils/sizeConfig/sizeConfig.dart';
import 'package:pitch_me_app/utils/strings/strings.dart';
import 'package:pitch_me_app/utils/styles/styles.dart';
import 'package:pitch_me_app/utils/widgets/Navigation/custom_navigation.dart';
import 'package:pitch_me_app/utils/widgets/containers/containers.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../Phase 6/Guest UI/Guest limitation pages/pro_user_limitation.dart';
import '../../../View/Custom header view/appbar_with_white_bg.dart';
import '../../../utils/extras/extras.dart';

class HomeBiographyPage extends StatefulWidget {
  String type;
  String userID;
  String notifyID;
  HomeBiographyPage(
      {super.key,
      required this.type,
      required this.userID,
      required this.notifyID});

  @override
  State<HomeBiographyPage> createState() => _HomeBiographyPageState();
}

class _HomeBiographyPageState extends State<HomeBiographyPage> {
  HomeBiographyController controller = Get.put(HomeBiographyController());
  FeebackController feebackController = Get.put(FeebackController());
  List getChat = [];
  dynamic chatData;

  String usertype = '';
  String adminUser = '';
  dynamic proUser;

  String businnesType = '';

  bool isCheckProUser = false;

  @override
  void initState() {
    if (widget.notifyID.isNotEmpty) {
      feebackController.readAllNotiApi(widget.notifyID);
    }
    checkAuth();
    controller.getBioApi(widget.userID);
    getChatApi(widget.userID);

    super.initState();
  }

  void checkAuth() async {
    SharedPreferences preferencesData = await SharedPreferences.getInstance();
    setState(() {
      usertype = preferencesData.getString('log_type').toString();
      adminUser = preferencesData.getString('bot').toString();
      proUser = jsonDecode(preferencesData.getString('pro_user').toString());
    });
    checkUser();
  }

  void checkUser() {
    if (adminUser == 'null' && usertype != '5') {
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

  Future getChatApi(reseverID) async {
    try {
      await PostApiServer().getChatDetailApi(reseverID).then((value) {
        getChat = value['result'];
        if (getChat.isNotEmpty) {
          createChat();
        }
        // isLoading.value = false;
        //log(getChat.toString());
      });
    } catch (e) {
      getChat = [];
      //isLoading.value = false;
    }
  }

  void createChat() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var senderID = prefs.get('user_id').toString();

    var onCreate = {'sendorid': senderID, 'recieverid': widget.userID};
    socket.emit('createchat', onCreate);
    socket.on('receive_user', (data) {
      chatData = data;
      //log('chat create = ' + chatData.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            child: Image.asset(
              'assets/images/17580.png',
              height: MediaQuery.of(context).size.height,
              fit: BoxFit.cover,
            ),
          ),
          SingleChildScrollView(
            child: Stack(
              children: [
                ClipPath(
                  clipper: CurveClipper(),
                  child: Container(
                    decoration: BoxDecoration(
                        gradient: DynamicColor.gradientColorChange),
                    height: MediaQuery.of(context).size.height * 0.255,
                  ),
                ),
                Obx(() {
                  return controller.isLoading.value
                      ? Center(
                          child: CircularProgressIndicator(
                          color: DynamicColor.gredient1,
                        ))
                      : Stack(
                          alignment: Alignment.topCenter,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                top: SizeConfig.getSize60(context: context) +
                                    SizeConfig.getSize20(context: context),
                              ),
                              child: msgText(),
                            ),
                            Column(
                              children: [
                                SizedBox(
                                  height: SizeConfig.getSize60(
                                          context: context) +
                                      SizeConfig.getSize60(context: context),
                                ),

                                biodata(),

                                //    SizedBox(height: 15),
                                userDataFields(),
                                SizedBox(
                                  height:
                                      SizeConfig.getSize100(context: context),
                                )
                              ],
                            ),
                            Column(
                              children: [
                                CustomAppbarWithWhiteBg(
                                  title: 'BIOGRAPHY',
                                  colorTween: 'BIOGRAPHY',
                                  backCheckBio: 'back',
                                  checkNew:
                                      widget.type == 'back' ? null : 'next',
                                  backOnTap: () {
                                    if (widget.type == 'watch') {
                                      PageNavigateScreen().normalpushReplesh(
                                          context, Floatbar(1));
                                    } else {
                                      Navigator.of(context).pop();
                                    }
                                  },
                                  nextOnTap: () {
                                    if (isCheckProUser) {
                                      if (controller.bioDoc != null) {
                                        if (getChat.isNotEmpty) {
                                          PageNavigateScreen()
                                              .normalpushReplesh(
                                                  context,
                                                  ChatPage(
                                                    id: chatData['messages']
                                                        ['_id'],
                                                    recieverid:
                                                        controller.bioDoc ==
                                                                null
                                                            ? ''
                                                            : controller
                                                                .bioDoc!.userid,
                                                    name: controller.bioDoc ==
                                                            null
                                                        ? null
                                                        : controller.bioDoc!
                                                            .user.username,
                                                    img: controller.bioDoc ==
                                                            null
                                                        ? null
                                                        : controller
                                                            .bioDoc!.picture,
                                                    userID: controller.bioDoc ==
                                                            null
                                                        ? ''
                                                        : controller
                                                            .bioDoc!.userid,
                                                  ));
                                        } else {
                                          PageNavigateScreen()
                                              .normalpushReplesh(
                                                  context,
                                                  ConfirmationChat(
                                                    id: controller.bioDoc ==
                                                            null
                                                        ? null
                                                        : controller
                                                            .bioDoc!.userid,
                                                    recieverid:
                                                        controller.bioDoc ==
                                                                null
                                                            ? null
                                                            : controller
                                                                .bioDoc!.userid,
                                                    name: controller.bioDoc ==
                                                            null
                                                        ? null
                                                        : controller.bioDoc!
                                                            .user.username,
                                                    img: controller.bioDoc ==
                                                            null
                                                        ? null
                                                        : controller
                                                            .bioDoc!.picture,
                                                  ));
                                        }
                                      } else {
                                        myToast(context,
                                            msg:
                                                'Profile not verified for chat');
                                      }
                                    } else {
                                      PageNavigateScreen().push(context,
                                          ProUserLimitationPage(pageIndex: 3));
                                    }
                                  },
                                  onPressad: () {
                                    PageNavigateScreen().push(
                                        context,
                                        ManuPage(
                                          title: 'BIOGRAPHY',
                                          pageIndex: 3,
                                          isManu: 'Manu',
                                        ));
                                  },
                                ),
                              ],
                            ),
                          ],
                        );
                }),
              ],
            ),
          ),
          NewCustomBottomBar(
            index: 3,
            isBack: true,
          ),
        ],
      ),
    );
  }

  Widget msgText() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.only(
              left: SizeConfig.getSize58(context: context),
              right: SizeConfig.getSize58(context: context)),
          child: AutoSizeText(
            TextStrings.textKey['bio_text']!,
            style: white13TextStyle,
            textAlign: TextAlign.center,
            maxLines: 3,
          ),
        )
      ],
    );
  }

  Widget biodata() {
    return Padding(
      padding: EdgeInsets.only(
          left: SizeConfig.getFontSize25(context: context),
          right: SizeConfig.getFontSize25(context: context)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              HomeCircleBox(
                title: 'ID',
                title2: '',
                checkApprove: controller.idImageStatus,
                isHttp: (controller.bioDoc != null) ? controller.bioDoc : null,
                textStyle: gredient116bold,
              ),
              SizedBox(
                height: 10,
              ),
              HomeCircleBox(
                title: 'Face',
                title2: 'Check',
                checkApprove: controller.fackCheckImageStatus,
                isHttp: (controller.bioDoc != null) ? controller.bioDoc : null,
                textStyle: gradient110,
              )
            ],
          ),
          profilePitcher(),
          Column(
            children: [
              HomeCircleBox(
                title: 'Skill',
                title2: 'Certificate',
                checkApprove: controller.skillImageStatus,
                isHttp: (controller.bioDoc != null) ? controller.bioDoc : null,
                textStyle: gradient110,
              ),
              SizedBox(
                height: 10,
              ),
              HomeCircleBox(
                title: 'Proof',
                title2: 'Funds',
                checkApprove: controller.proofImageStatus,
                isHttp: (controller.bioDoc != null) ? controller.bioDoc : null,
                textStyle: gradient110,
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget profilePitcher() {
    return Container(
      height: SizeConfig.getSize100(context: context),
      width: SizeConfig.getSize100(context: context),
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: DynamicColor.white, borderRadius: BorderRadius.circular(100)),
      child: controller.bioDoc != null &&
              controller.bioDoc!.picture.contains('https')
          ? Stack(
              alignment: Alignment.bottomRight,
              children: [
                CircleAvatar(
                  radius: 68,
                  backgroundColor: DynamicColor.white,
                  backgroundImage: NetworkImage(controller.bioDoc!.picture),
                ),
                Container(
                  height: SizeConfig.getSize30(context: context),
                  width: SizeConfig.getSize30(context: context),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: DynamicColor.green,
                      borderRadius: BorderRadius.circular(50)),
                  child: Icon(
                    Icons.check,
                    color: DynamicColor.white,
                  ),
                )
              ],
            )
          : Padding(
              padding: const EdgeInsets.all(7),
              child: Stack(
                alignment: Alignment.bottomRight,
                children: [
                  Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        gradient: DynamicColor.gradientColorChange,
                        borderRadius: BorderRadius.circular(100)),
                    child: Text(
                      'Profile Picture',
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                          color: DynamicColor.white),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Container(
                    height: SizeConfig.getSize30(context: context),
                    width: SizeConfig.getSize30(context: context),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: DynamicColor.redColor,
                        borderRadius: BorderRadius.circular(50)),
                    child: Icon(
                      Icons.close,
                      color: DynamicColor.white,
                    ),
                  )
                ],
              ),
            ),
    );
  }

  Widget userDataFields() {
    return Column(
      children: [
        Obx(() {
          return Text(
            // controller.userName.value == 'Akash'
            //     ? 'Name: Admin'
            //     :
            'Name: ${controller.userName.value}',
            style: TextStyle(
              color: DynamicColor.black,
              fontSize: 20,
              fontWeight: FontWeight.normal,
            ),
          );
        }),
        CustomBioFields(
          image: 'assets/images/people.png',
          isHttp: controller.logType.value.isNotEmpty
              ? controller.logType.value
              : null,
          title: controller.logType.value.isNotEmpty
              ? controller.logType.value
              : 'USER TYPE',
          onTap: () {
            // PageNavigateScreen().push(context, UnderDevLimitationPage());
          },
        ),
        CustomBioFields(
          image: 'assets/images/ic_place_24px.png',
          title: controller.location.value.isNotEmpty
              ? controller.location.value
              : 'LOCATION',
          isHttp: controller.location.value.isNotEmpty
              ? controller.location.value
              : null,
          onTap: () {
            // PageNavigateScreen().push(context, UnderDevLimitationPage());
          },
        ),
        CustomBioFields(
          image: 'assets/images/maintenance.png',
          title: controller.skill.value.isNotEmpty
              ? controller.skill.value
              : 'SKILL',
          isHttp:
              controller.skill.value.isNotEmpty ? controller.skill.value : null,
          onTap: () {
            // PageNavigateScreen().push(context, UnderDevLimitationPage());
          },
        ),
        CustomBioFields(
          image: 'assets/images/education-cap-svgrepo-com.png',
          title: controller.education.value.isNotEmpty
              ? controller.education.value
              : 'EDUCATION',
          isHttp: controller.education.value.isNotEmpty
              ? controller.education.value
              : null,
          onTap: () {
            // PageNavigateScreen().push(context, UnderDevLimitationPage());
          },
        ),
        CustomBioFields(
          image: 'assets/images/business-svgrepo-com.png',
          title: controller.experience.value.isNotEmpty
              ? controller.experience.value
              : 'EXPERIENCE',
          isHttp: controller.experience.value.isNotEmpty
              ? controller.experience.value
              : null,
          onTap: () {
            // PageNavigateScreen().push(context, UnderDevLimitationPage());
          },
        ),
        CustomBioFields(
          image: 'assets/images/ic_monetization_on_24px.png',
          title: controller.wealth.value.isNotEmpty
              ? controller.wealth.value
              : 'WEALTH',
          isHttp: controller.wealth.value.isNotEmpty
              ? controller.wealth.value
              : null,
          onTap: () {
            // PageNavigateScreen().push(context, UnderDevLimitationPage());
          },
        ),
        CustomBioFields(
          image: 'assets/images/ic_cancel_24px.png',
          title: controller.add.value.isNotEmpty ? controller.add.value : 'ADD',
          isHttp: controller.add.value.isNotEmpty ? controller.add.value : null,
          onTap: () {
            // PageNavigateScreen().push(context, UnderDevLimitationPage());
          },
        ),
        Text(
          'ID, Face Check, Funds and Certificate will not be visible to Users',
          style: TextStyle(fontSize: 10),
        )
      ],
    );
  }

  @override
  void dispose() {
    controller.fackCheckImageStatus = 0;
    controller.idImageStatus = 0;
    controller.proofImageStatus = 0;
    controller.skillImageStatus = 0;
    controller.userName.value = '';
    super.dispose();
  }
}
