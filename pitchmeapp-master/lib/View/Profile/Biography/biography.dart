import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pitch_me_app/View/Custom%20header%20view/appbar_with_white_bg.dart';
import 'package:pitch_me_app/View/Manu/manu.dart';
import 'package:pitch_me_app/View/Profile/Biography/controller/controller.dart';
import 'package:pitch_me_app/View/Profile/Biography/face_camera.dart';
import 'package:pitch_me_app/View/Profile/Biography/nda.dart';
import 'package:pitch_me_app/utils/colors/colors.dart';
import 'package:pitch_me_app/utils/sizeConfig/sizeConfig.dart';
import 'package:pitch_me_app/utils/strings/strings.dart';
import 'package:pitch_me_app/utils/styles/styles.dart';
import 'package:pitch_me_app/utils/widgets/Navigation/custom_navigation.dart';
import 'package:pitch_me_app/utils/widgets/containers/containers.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Custom header view/new_bottom_bar.dart';
import '../../Feedback/controller.dart';

class BiographyPage extends StatefulWidget {
  String type;
  String notifyID;
  BiographyPage({super.key, required this.type, required this.notifyID});

  @override
  State<BiographyPage> createState() => _BiographyPageState();
}

class _BiographyPageState extends State<BiographyPage> {
  final BiographyController controller = Get.put(BiographyController());
  FeebackController feebackController = Get.put(FeebackController());
  String userName = '';
  String userType = '';

  bool isKeyboardOpen = false;
  @override
  void initState() {
    userData();
    controller.getBioApi();
    if (widget.notifyID.isNotEmpty) {
      feebackController.readAllNotiApi(widget.notifyID);
    }
    super.initState();
  }

  void userData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userName = prefs.get('user_name').toString();
      var usertype = prefs.get('log_type').toString();
      if (usertype == "1") {
        userType = 'Business Idea';
      } else if (usertype == "2") {
        userType = 'Business Owner';
      } else if (usertype == "3") {
        userType = 'Investor';
      } else if (usertype == "4") {
        userType = 'Service Provider';
      } else {
        userType = 'Admin';
        // userName = 'Admin';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
            physics: ScrollPhysics(),
            //  isKeyboardOpen
            //     ? ScrollPhysics()
            //     : NeverScrollableScrollPhysics(),
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
                      ? Padding(
                          padding: EdgeInsets.only(
                            top: SizeConfig.getSizeHeightBy(
                                context: context, by: 0.45),
                          ),
                          child: Center(
                              child: CircularProgressIndicator(
                            color: DynamicColor.gredient1,
                          )),
                        )
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
                                // SizedBox(height: 15),
                                userDataFields(),
                                isKeyboardOpen == false
                                    ? SizedBox(
                                        height: SizeConfig.getSize100(
                                            context: context),
                                      )
                                    : Container(),
                                isKeyboardOpen
                                    ? SizedBox(
                                        height: SizeConfig.getSize100(
                                                context: context) +
                                            SizeConfig.getSize100(
                                                context: context) +
                                            SizeConfig.getSize40(
                                                context: context),
                                      )
                                    : Container(),
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomAppbarWithWhiteBg(
                                  title: 'BIOGRAPHY',
                                  colorTween: 'BIOGRAPHY',
                                  checkNext: 'back',
                                  checkNew: 'next',
                                  nextOnTap: () {
                                    PageNavigateScreen()
                                        .push(context, NDAPage());
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
        // Text(
        //   TextStrings.textKey['bio_text']!,
        //   style: white13TextStyle,
        //   textAlign: TextAlign.center,
        //   maxLines: 3,
        // ),
        // Text(TextStrings.textKey['bio_text2']!,
        //     style: white13TextStyle, textAlign: TextAlign.center),
      ],
    );
  }

  Widget biodata() {
    return Padding(
      padding: EdgeInsets.only(
          left: SizeConfig.getSize20(context: context),
          right: SizeConfig.getSize20(context: context)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              CircleBox(
                title: 'ID',
                title2: '',
                textStyle: gredient116bold,
                checkApprove: controller.idImageStatus,
                isHttp: (controller.bioDoc != null) ? controller.bioDoc : null,
                imageType: controller.idImagePath.path,
                onPressad: () {
                  controller.selectImage('Id').then((value) {
                    setState(() {});
                  });
                },
              ),
              SizedBox(
                height: 10,
              ),
              CircleBox(
                title: 'Face',
                title2: 'Check',
                textStyle: gradient110,
                checkApprove: controller.fackCheckImageStatus,
                isHttp: (controller.bioDoc != null) ? controller.bioDoc : null,
                imageType: controller.fackCheckImagePath.path,
                onPressad: () {
                  PageNavigateScreen()
                      .push(context, FaceCameraPage())
                      .then((value) {
                    setState(() {});
                  });
                },
              )
            ],
          ),
          profilePitcher(),
          Column(
            children: [
              CircleBox(
                title: 'Skill',
                title2: 'Certificate',
                textStyle: gradient110,
                checkApprove: controller.skillImageStatus,
                isHttp: (controller.bioDoc != null) ? controller.bioDoc : null,
                imageType: controller.skillImagePath.path,
                onPressad: () {
                  controller.selectImage('Skill').then((value) {
                    setState(() {});
                  });
                },
              ),
              SizedBox(
                height: 10,
              ),
              CircleBox(
                title: 'Proof',
                title2: 'Funds',
                textStyle: gradient110,
                checkApprove: controller.proofImageStatus,
                isHttp: (controller.bioDoc != null) ? controller.bioDoc : null,
                imageType: controller.proofImagePath.path,
                onPressad: () {
                  controller.getDocumnetFile(context).then((value) {
                    setState(() {});
                  });
                },
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget profilePitcher() {
    return SizedBox(
      child: InkWell(
        onTap: () {
          controller.selectImage('Profile').then((value) {
            setState(() {});
          });
        },
        child: Container(
          height: SizeConfig.getSize100(context: context),
          width: SizeConfig.getSize100(context: context),
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: DynamicColor.white,
              borderRadius: BorderRadius.circular(100)),
          child: controller.bioDoc != null &&
                  controller.profileImagePath.path.contains('https')
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
              : controller.profileImagePath.path.isEmpty
                  ? Padding(
                      padding: const EdgeInsets.all(7),
                      child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: Color(0xffE6E6E6),
                            borderRadius: BorderRadius.circular(100)),
                        child: Text(
                          'Profile Picture',
                          style: TextStyle(
                            color: DynamicColor.gredient1,
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    )
                  : CircleAvatar(
                      radius: 68,
                      backgroundColor: DynamicColor.white,
                      backgroundImage: FileImage(controller.profileImagePath),
                    ),
        ),
      ),
    );
  }

  Widget userDataFields() {
    return Column(
      children: [
        Text(
          userName == 'Akash' ? 'Name: Admin' : 'Name: ' + userName,
          style: TextStyle(
            color: DynamicColor.black,
            fontSize: 20,
            fontWeight: FontWeight.normal,
          ),
        ),
        CustomBioFields(
          image: 'assets/images/people.png',
          isHttp: userType.isNotEmpty ? userType : null,
          title: userType.isNotEmpty ? userType : 'USER TYPE',
          onTap: () {
            //PageNavigateScreen().push(context, UnderDevLimitationPage());
          },
        ),
        BioTextFields(
          image: 'assets/images/ic_place_24px.png',
          title: 'LOCATION',
          initialValue: controller.location,
          onTap: () {
            setState(() {
              isKeyboardOpen = true;
            });
          },
          onEditingComplete: () {
            FocusScope.of(context).requestFocus(FocusNode());
            setState(() {
              isKeyboardOpen = false;
            });
          },
          onChanged: (value) {
            setState(() {
              controller.location = value;
            });
          },
        ),
        BioTextFields(
          image: 'assets/images/maintenance.png',
          title: 'SKILL',
          initialValue: controller.skill,
          onTap: () {
            setState(() {
              isKeyboardOpen = true;
            });
          },
          onEditingComplete: () {
            FocusScope.of(context).requestFocus(FocusNode());
            setState(() {
              isKeyboardOpen = false;
            });
          },
          onChanged: (value) {
            setState(() {
              controller.skill = value;
            });
          },
        ),
        BioTextFields(
          image: 'assets/images/education-cap-svgrepo-com.png',
          title: 'EDUCATION',
          initialValue: controller.education,
          onTap: () {
            setState(() {
              isKeyboardOpen = true;
            });
          },
          onEditingComplete: () {
            FocusScope.of(context).requestFocus(FocusNode());
            setState(() {
              isKeyboardOpen = false;
            });
          },
          onChanged: (value) {
            setState(() {
              controller.education = value;
            });
          },
        ),
        BioTextFields(
          image: 'assets/images/business-svgrepo-com.png',
          title: 'EXPERIENCE',
          initialValue: controller.experience,
          onTap: () {
            setState(() {
              isKeyboardOpen = true;
            });
          },
          onEditingComplete: () {
            FocusScope.of(context).requestFocus(FocusNode());
            setState(() {
              isKeyboardOpen = false;
            });
          },
          onChanged: (value) {
            setState(() {
              controller.experience = value;
            });
          },
        ),
        BioTextFields(
          image: 'assets/images/ic_monetization_on_24px.png',
          title: 'WEALTH',
          initialValue: controller.wealth,
          onTap: () {
            setState(() {
              isKeyboardOpen = true;
            });
          },
          onEditingComplete: () {
            FocusScope.of(context).requestFocus(FocusNode());
            setState(() {
              isKeyboardOpen = false;
            });
          },
          onChanged: (value) {
            setState(() {
              controller.wealth = value;
            });
          },
        ),
        BioTextFields(
          image: 'assets/images/ic_cancel_24px.png',
          title: 'ADD',
          initialValue: controller.add,
          onTap: () {
            setState(() {
              isKeyboardOpen = true;
            });
          },
          onEditingComplete: () {
            FocusScope.of(context).requestFocus(FocusNode());
            setState(() {
              isKeyboardOpen = false;
            });
          },
          onChanged: (value) {
            setState(() {
              controller.add = value;
            });
          },
        ),
        Text(
          'ID, Face Check, Funds and Certificate will not be visible to Users',
          style: TextStyle(fontSize: 10),
        )
      ],
    );
  }
}
