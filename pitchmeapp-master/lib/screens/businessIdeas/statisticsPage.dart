import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pitch_me_app/models/statisticsModel/statisticsModel.dart';
import 'package:pitch_me_app/utils/colors/colors.dart';
import 'package:pitch_me_app/utils/extras/extras.dart';
import 'package:pitch_me_app/utils/sizeConfig/sizeConfig.dart';
import 'package:pitch_me_app/utils/styles/styles.dart';
import 'package:pitch_me_app/utils/widgets/text/text.dart';

class StatisticsPage extends StatelessWidget {
  const StatisticsPage(
      {Key? key, required this.pagecont, required this.statisticsModel})
      : super(key: key);
  final PageController pagecont;
  final StatisticsModel statisticsModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration:
                BoxDecoration(gradient: DynamicColor.gradientColorChange),
          ),
          SizedBox(
              height: Get.height * 0.30,
              width: Get.width,
              child: Image.asset('assets/imagess/Map.png')),
          //
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // spaceHeight(SizeConfig.getSize10(context: context)),
              // Expanded(
              //   flex: 1,
              //   child:
              GestureDetector(
                  onTap: () {
                    pagecont.previousPage(
                        duration: Duration(milliseconds: 200),
                        curve: Curves.linear);
                  },
                  child: Padding(
                      padding: EdgeInsets.only(
                          top: SizeConfig.getSize60(context: context)),
                      child: /* SvgPicture.asset(Assets.tiktokPreviousIco),*/
                          RotatedBox(
                        quarterTurns: 6,
                        child: Image.asset(
                          "assets/Phase 2 icons/ic_keyboard_arrow_down_24px.png",
                          color: DynamicColor.white,
                          height: SizeConfig.getSize35(context: context),
                          width: SizeConfig.getSize35(context: context),
                        ),
                      ))
                  //),
                  ),
              staticData(context),
              Container()
              // Expanded(
              //     flex: 3,
              //     child:
              // SingleChildScrollView(
              //     child: Column(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   crossAxisAlignment: CrossAxisAlignment.center,
              //   children: [
              //     staticData(context),
              //     //spaceHeight(SizeConfig.getSize60(context: context)),
              //   ],
              // ))
              //)
            ],
          ),
        ],
      ),
    );
  }

  Widget staticData(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        commanWidget(context, 'Business Ideas',
            '${statisticsModel.result!.businessIdea!.number}'),
        commanWidget(context, 'Business Owners',
            '${statisticsModel.result!.business!.number}'),
        commanWidget(context, 'Investors',
            '${statisticsModel.result!.investors!.number}'),
        commanWidget(context, 'Service Providers',
            '${statisticsModel.result!.facilitator!.number}'),
        // commanWidget(context, 'Raised Funds',
        //     '${statisticsModel.result!.raisedFunds!.number} USD'),
        // commanWidget(context, 'Verified Funds',
        //     '${statisticsModel.result!.verifiedFunds!.number} USD'),
        commanWidget(
            context, 'Cities', '${statisticsModel.result!.cities!.number}'),
        commanWidget(context, 'Countries',
            '${statisticsModel.result!.countries!.number}'),
        // commanWidget(context, 'Continent',
        //     '${statisticsModel.result!.continents!.number}'),
      ],
    );
  }

  Widget commanWidget(BuildContext context, String title, value) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.6,
          child: Divider(
            height: 1,
            color: DynamicColor.white,
          ),
        ),
        SizedBox(height: 5),
        Text(title, style: white21wBold),
        SizedBox(height: 10),
        Text(value, style: white17wBold),
        SizedBox(height: 10),
      ],
    );
  }

  Widget appStatistics({required BuildContext context}) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: SizeConfig.getSize35(context: context),
          vertical: SizeConfig.getSize15(context: context)),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: EdgeInsets.all(SizeConfig.getSize15(context: context)),
          child: Column(
            children: [
              IntrinsicHeight(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: width(context) * 0.35,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          roboto(
                              size: SizeConfig.getFontSize14(context: context),
                              text: 'Investors',
                              color: DynamicColor.black,
                              textAlign: TextAlign.left,
                              fontWeight: FontWeight.w400),
                          spaceHeight(SizeConfig.getSize10(context: context)),
                          roboto(
                              size: SizeConfig.getFontSize19(context: context),
                              text:
                                  '${statisticsModel.result!.investors!.number}',
                              fontWeight: FontWeight.w800,
                              color: DynamicColor.black),
                        ],
                      ),
                    ),
                    VerticalDivider(
                      thickness: 1,
                      color: DynamicColor.black,
                    ),
                    Container(
                      width: width(context) * 0.36,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          roboto(
                              size: SizeConfig.getFontSize14(context: context),
                              text: 'Businesses',
                              color: DynamicColor.black,
                              fontWeight: FontWeight.w400),
                          spaceHeight(SizeConfig.getSize10(context: context)),
                          roboto(
                              size: SizeConfig.getFontSize19(context: context),
                              text:
                                  '${statisticsModel.result!.business!.number}',
                              fontWeight: FontWeight.w800,
                              color: DynamicColor.black),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              spaceHeight(SizeConfig.getSize20(context: context)),
              IntrinsicHeight(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: width(context) * 0.35,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          roboto(
                              size: SizeConfig.getFontSize14(context: context),
                              text: 'Raised Funds',
                              color: DynamicColor.black,
                              textAlign: TextAlign.start,
                              fontWeight: FontWeight.w400),
                          spaceHeight(SizeConfig.getSize10(context: context)),
                          roboto(
                              size: SizeConfig.getFontSize19(context: context),
                              text:
                                  '${statisticsModel.result!.raisedFunds!.number} USD',
                              fontWeight: FontWeight.w800,
                              textAlign: TextAlign.start,
                              color: DynamicColor.black),
                        ],
                      ),
                    ),
                    VerticalDivider(
                      thickness: 1,
                      color: DynamicColor.black,
                    ),
                    Container(
                      width: width(context) * 0.36,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          roboto(
                              size: SizeConfig.getFontSize14(context: context),
                              text: 'Verified Funds',
                              color: DynamicColor.black,
                              fontWeight: FontWeight.w400),
                          spaceHeight(SizeConfig.getSize10(context: context)),
                          roboto(
                              size: SizeConfig.getFontSize19(context: context),
                              text:
                                  '${statisticsModel.result!.verifiedFunds!.number} USD',
                              fontWeight: FontWeight.w800,
                              textAlign: TextAlign.start,
                              color: DynamicColor.black),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
