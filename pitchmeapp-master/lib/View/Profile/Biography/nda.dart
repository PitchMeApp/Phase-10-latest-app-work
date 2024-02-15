import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pitch_me_app/View/Profile/Biography/confirmation_bio.dart';
import 'package:pitch_me_app/View/Profile/Biography/controller/controller.dart';
import 'package:pitch_me_app/utils/colors/colors.dart';
import 'package:pitch_me_app/utils/extras/extras.dart';
import 'package:pitch_me_app/utils/sizeConfig/sizeConfig.dart';
import 'package:pitch_me_app/utils/strings/images.dart';
import 'package:pitch_me_app/utils/styles/styles.dart';
import 'package:pitch_me_app/utils/widgets/extras/backgroundWidget.dart';
import 'package:pitch_me_app/utils/widgets/extras/banner.dart';
import 'package:sizer/sizer.dart';
import 'package:syncfusion_flutter_signaturepad/signaturepad.dart';

class NDAPage extends StatefulWidget {
  const NDAPage({super.key});

  @override
  State<NDAPage> createState() => _NDAPageState();
}

class _NDAPageState extends State<NDAPage> {
  PageController pageController = PageController();
  GlobalKey<SfSignaturePadState> _signaturePadKey = GlobalKey();
  BiographyController biographyController = Get.put(BiographyController());
  int isSelect = 0;
  @override
  Widget build(BuildContext context) {
    final sizeH = MediaQuery.of(context).size.height;
    TextStyle textStyle = TextStyle(
      fontSize: 15,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.6,
      color: DynamicColor.gredient2,
    );
    TextStyle blacStyle = TextStyle(
      fontSize: sizeH * 0.020,
      fontWeight: FontWeight.bold,
      letterSpacing: 0.6,
      color: DynamicColor.gredient1,
    );
    return Scaffold(
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: BannerWidget(onPressad: () {}),
      body: BackGroundWidget(
        backgroundImage: Assets.backgroundImage,
        fit: BoxFit.fill,
        child: Padding(
          padding: EdgeInsets.only(
              left: SizeConfig.getSize25(context: context),
              right: SizeConfig.getSize25(context: context)),
          child: Column(
            children: [
              Expanded(
                  flex: 1,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: RotatedBox(
                          quarterTurns: 1,
                          child: Image.asset(
                            "assets/Phase 2 icons/ic_keyboard_arrow_down_24px.png",
                            height: 25,
                            width: 25,
                          ),
                        ),
                      ),
                      Text(
                        'NON DISCLOSURE POLICY',
                        style: TextStyle(
                          color: DynamicColor.gredient1,
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(
                        height: SizeConfig.getSize38(context: context),
                        width: SizeConfig.getSize38(context: context),
                      )
                    ],
                  )),
              Expanded(
                  flex: 6,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                            "This is a non-disclosure policy for all users (the “Users”) of this application (the “Application”):",
                            style: textStyle),
                        SizedBox(height: 20),
                        Row(
                          children: [
                            Text('1  ', style: blacStyle),
                            Container(
                              decoration: BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                          color: DynamicColor.gredient1))),
                              child: Text('Confidential Information',
                                  style: blacStyle),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        Text(
                            '1.1  For the purposes of this Policy, the term “Confidential Information” shall mean any information or data relating to the sales and business pitches published or displayed on the Application.',
                            style: textStyle),

                        SizedBox(height: 20),
                        Text(
                            '1.2  Confidential Information may be in any form including but not limited to written, printed, or electronic form, and includes ideas, inventions, designs, business names, logos,  business and processes, research, proprietary processes, numbers, engineering, marketing, sales, operating, performance, discoveries, concepts, designs, data, plans, designs, photographs, drawings, processes, slogans, merchandising, specifications, product samples, formulae, compositions, technological information, know-how, reports, studies, pricings, trade secrets, finance, trade, and commercial information, computer models and programs, contracts, or any note, calculation, conclusions, summary, computer database, computer modeling or other matters derived or produced partly or wholly from Confidential Information.,',
                            style: textStyle),
                        SizedBox(height: 20),
                        Row(
                          children: [
                            Text('2  ', style: blacStyle),
                            Container(
                              decoration: BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                          color: DynamicColor.gredient1))),
                              child: Text('OWNERSHIP AND RIGHTS',
                                  style: blacStyle),
                            ),
                          ],
                        ),

                        SizedBox(height: 20),
                        Text(
                            'The person making the pitch, or the Application, as the case maybe, shall retain sole and proprietary ownership in the Confidential Information, which includes all intellectual property rights therein, such as patents, trademarks and copyrights. Nothing in this Policy shall be deemed to be construed as granting any right or authority whatsoever to the Users in connection with the Confidential Information, which includes but is not limited to licenses, assignment or any right to use or claim ownership of the Confidential Information.',
                            style: textStyle),
                        SizedBox(height: 20),
                        Row(
                          children: [
                            Text('3  ', style: blacStyle),
                            Container(
                              decoration: BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                          color: DynamicColor.gredient1))),
                              child: Text('OBLIGATIONS', style: blacStyle),
                            ),
                          ],
                        ),

                        SizedBox(height: 20),
                        Text(
                            '3.1  The Users hereby agree to (i) protect the confidentiality of the Confidential Information; (ii) not disclose or permit to be disclosed the Confidential Information, either in whole or in part, to any third party (iii) use the same degree of care in protecting and maintaining the Confidential Information as it would with its own confidential and proprietary information in order to prevent the unauthorized disclosure of the Confidential Information to any third party.',
                            style: textStyle),
                        SizedBox(height: 20),
                        Text(
                            '3.2  Each User further represents that he/she  shall not use, distribute, disseminate or replicate the Confidential Information either for its benefit or any other third party or in any other manner or for any other purpose whatsoever',
                            style: textStyle),
                        SizedBox(height: 20),
                        Row(
                          children: [
                            Text('4  ', style: blacStyle),
                            Container(
                              decoration: BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                          color: DynamicColor.gredient1))),
                              child: Text('BREACH AND REMEDIAL ACTION',
                                  style: blacStyle),
                            ),
                          ],
                        ),

                        SizedBox(height: 20),
                        Text(
                            'The Users hereto understands that any breach, or discovery of any such breach or threatened breach, of any of the terms of Agreement shall lead the person making the pitch or the Application, as the case maybe, to suffer irreparable loss. In such circumstance, the aggrieved person shall be entitled to appropriate injunctive relief, in addition to any such remedy which may be available to it under law or equity.',
                            style: textStyle),
                        SizedBox(height: 20),
                        Row(
                          children: [
                            Text('5  ', style: blacStyle),
                            Container(
                              decoration: BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                          color: DynamicColor.gredient1))),
                              child: Text('INDEMNIFICATION', style: blacStyle),
                            ),
                          ],
                        ),

                        SizedBox(height: 20),
                        Text(
                            'The Users shall indemnify and hold harmless the Application and its affiliates and respective directors, officers, employees, agents and representatives from and against any and all losses, damages, costs and expenses (including, without limitation, reasonable attorneys’ fees and expenses) and any and all actions, suits, proceedings, claims, demands or judgments incident thereto, caused by or arising out of any breach of this Policy.',
                            style: textStyle),
                        SizedBox(height: 20),
                        Row(
                          children: [
                            Text('6  ', style: blacStyle),
                            Container(
                              decoration: BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                          color: DynamicColor.gredient1))),
                              child: Text('MISCELLANEOUS', style: blacStyle),
                            ),
                          ],
                        ),

                        SizedBox(height: 20),
                        Text(
                            '6.1  No failure or delay by the Application in exercising any right, power or privilege hereunder will operate as a waiver thereof nor will any single or partial exercise thereof preclude any other or further exercise thereof or the exercise of any other right, power or privilege that Application may be entitled to under this Policy or the law.',
                            style: textStyle),
                        SizedBox(height: 20),
                        Text(
                            '6.2  If any provision of this Policy or the application of any such provision to any person or circumstance is held invalid, illegal or unenforceable in any respect by a court of competent jurisdiction, such invalidity or illegality will not affect any other provision hereof.',
                            style: textStyle),
                        SizedBox(height: 30),
                        // biographyController.signature.path.contains('https')
                        biographyController.signatureStatus == 2
                            // ||
                            //         biographyController.signature.path
                            //             .contains('https')
                            ? Stack(
                                alignment: Alignment.bottomRight,
                                children: [
                                  Container(
                                    height: 160,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        color: DynamicColor.white,
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                            color: DynamicColor.gredient2,
                                            width: 2)),
                                    child: Text(
                                      biographyController.signatureStatus == 2
                                          ? 'signature verified'.toUpperCase()
                                          : 'signature not verified'
                                              .toUpperCase(),
                                      style: gredient119,
                                    ),
                                  ),
                                  Container(
                                    height:
                                        SizeConfig.getSize35(context: context),
                                    width:
                                        SizeConfig.getSize35(context: context),
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        gradient:
                                            DynamicColor.gradientColorChange,
                                        borderRadius:
                                            BorderRadius.circular(50)),
                                    child: Icon(
                                      biographyController.signatureStatus == 2
                                          ? Icons.check
                                          : Icons.close,
                                      color: DynamicColor.white,
                                    ),
                                  )
                                ],
                              )
                            : Container(
                                height: 160,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                        color: DynamicColor.gredient2,
                                        width: 2)),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: SfSignaturePad(
                                    key: _signaturePadKey,
                                    minimumStrokeWidth: 1,
                                    maximumStrokeWidth: 3,
                                    strokeColor: DynamicColor.gredient1,
                                    backgroundColor: DynamicColor.white,
                                    onDraw: (offset, time) {
                                      setState(() {
                                        biographyController.isSignature.value =
                                            true;
                                      });
                                    },
                                  ),
                                ),
                              ),
                        SizedBox(height: 20),
                        biographyController.signature.path.contains('https')
                            ? Container()
                            : Text('Signature'.toUpperCase(),
                                style: gredient116bold),
                        SizedBox(height: 50),
                        biographyController.signature.path.contains('https')
                            ? Card(
                                elevation: isSelect == 3 ? 0 : 10,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                child: InkWell(
                                  onTap: () {
                                    setState(() {
                                      isSelect = 3;
                                    });
                                    Get.to(() => ConfirmationBio());
                                  },
                                  child: Container(
                                    height: 6.h,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        gradient: isSelect == 3
                                            ? null
                                            : DynamicColor.gradientColorChange,
                                        color: isSelect == 3
                                            ? DynamicColor.white
                                            : null,
                                        borderRadius: BorderRadius.circular(10),
                                        border: isSelect == 3
                                            ? Border.all(
                                                color: DynamicColor.gredient2)
                                            : null),
                                    child: Text(
                                      "Accepted",
                                      style: isSelect == 3
                                          ? gredient116bold
                                          : white15TextStyle,
                                    ),
                                  ),
                                ),
                              )
                            : Row(
                                children: [
                                  Expanded(
                                    child: Card(
                                      elevation: isSelect == 1 ? 0 : 10,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: InkWell(
                                        onTap: () async {
                                          //_signaturePadKey.currentState!.clear();
                                          setState(() {
                                            isSelect = 1;

                                            biographyController
                                                .handleSaveButtonPressed(
                                                    _signaturePadKey,
                                                    'NotAccept');
                                          });
                                        },
                                        child: Container(
                                          height: 6.h,
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(10),
                                                  bottomLeft:
                                                      Radius.circular(10)),
                                              gradient: isSelect == 1
                                                  ? null
                                                  : DynamicColor
                                                      .gradientColorChange,
                                              color: isSelect == 1
                                                  ? DynamicColor.white
                                                  : null,
                                              border: isSelect == 1
                                                  ? Border.all(
                                                      color: DynamicColor
                                                          .gredient2)
                                                  : null),
                                          child: Text(
                                            "Do Not Accept",
                                            style: isSelect == 1
                                                ? gredient116bold
                                                : white15TextStyle,
                                          ), // the sorcerer's apprentice
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Card(
                                      elevation: isSelect == 2 ? 0 : 10,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      margin: EdgeInsets.zero,
                                      child: InkWell(
                                        onTap: () {
                                          setState(() {
                                            isSelect = 2;
                                            if (biographyController
                                                .isSignature.value) {
                                              biographyController
                                                  .handleSaveButtonPressed(
                                                      _signaturePadKey,
                                                      'Accept');
                                            } else {
                                              myToast(context,
                                                  msg:
                                                      'Please give your signature');
                                            }
                                          });
                                        },
                                        child: Container(
                                          height: 6.h,
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.only(
                                                  topRight: Radius.circular(10),
                                                  bottomRight:
                                                      Radius.circular(10)),
                                              gradient: isSelect == 2
                                                  ? null
                                                  : DynamicColor
                                                      .gradientColorChange,
                                              color: isSelect == 2
                                                  ? DynamicColor.white
                                                  : null,
                                              border: isSelect == 2
                                                  ? Border.all(
                                                      color: DynamicColor
                                                          .gredient2)
                                                  : null),
                                          child: Text(
                                            "Accept",
                                            style: isSelect == 2
                                                ? gredient116bold
                                                : white15TextStyle,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                        spaceHeight(SizeConfig.getSizeHeightBy(
                            context: context, by: 0.2))
                      ],
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}

class NDA2Page extends StatefulWidget {
  PageController pageController;
  NDA2Page({super.key, required this.pageController});

  @override
  State<NDA2Page> createState() => _NDA2PageState();
}

class _NDA2PageState extends State<NDA2Page> {
  GlobalKey<SfSignaturePadState> _signaturePadKey = GlobalKey();
  BiographyController biographyController = Get.put(BiographyController());

  @override
  Widget build(BuildContext context) {
    final sizeH = MediaQuery.of(context).size.height;
    return Scaffold(
      body: BackGroundWidget(
        backgroundImage: Assets.backgroundImage,
        fit: BoxFit.fill,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
                left: SizeConfig.getSize25(context: context),
                right: SizeConfig.getSize25(context: context)),
            child: Column(
              children: [],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    biographyController.isSignature.value = false;
    _signaturePadKey.currentState!.clear();
    super.dispose();
  }
}
