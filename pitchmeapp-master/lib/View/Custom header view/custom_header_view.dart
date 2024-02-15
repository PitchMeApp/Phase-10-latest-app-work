import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:pitch_me_app/View/Manu/manu.dart';
import 'package:pitch_me_app/utils/colors/colors.dart';
import 'package:pitch_me_app/utils/extras/extras.dart';
import 'package:pitch_me_app/utils/sizeConfig/sizeConfig.dart';
import 'package:pitch_me_app/utils/strings/strings.dart';
import 'package:pitch_me_app/utils/styles/styles.dart';
import 'package:pitch_me_app/utils/widgets/Navigation/custom_navigation.dart';
import 'package:pitch_me_app/utils/widgets/containers/containers.dart';

import '../../utils/strings/images.dart';
import '../../utils/widgets/Arrow Button/back_arrow.dart';
import '../Notification/notification_list.dart';

class CustomHeaderView extends StatefulWidget {
  double progressPersent;

  VoidCallback? backOnTap;
  VoidCallback nextOnTap;
  dynamic checkNext;
  CustomHeaderView({
    super.key,
    required this.progressPersent,
    this.backOnTap,
    required this.nextOnTap,
    this.checkNext,
  });

  @override
  State<CustomHeaderView> createState() => _CustomHeaderViewState();
}

class _CustomHeaderViewState extends State<CustomHeaderView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          ClipPath(
            clipper: CurveClipper(),
            child: Container(
              decoration:
                  BoxDecoration(gradient: DynamicColor.gradientColorChange),
              height: MediaQuery.of(context).size.height * 0.27,
            ),
          ),
          Column(
            children: [
              iconsAndTitle(),
              iconAndProgressBar(),
            ],
          ),
          NotificationManuList(
            isManu: true,
            isFilter: true,
          )
        ],
      ),
    );
  }

  Widget iconsAndTitle() {
    return Padding(
        padding: EdgeInsets.only(
            top: SizeConfig.getSize30(context: context) +
                MediaQuery.of(context).size.height * 0.021,
            left: SizeConfig.getFontSize25(context: context),
            right: SizeConfig.getFontSize25(context: context)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: SizeConfig.getSize38(context: context),
              width: SizeConfig.getSize38(context: context),
            ),
            Container(
              height: SizeConfig.getSize38(context: context),
              alignment: Alignment.center,
              child: Text(
                TextStrings.textKey['add_seles_pitch']!.toUpperCase(),
                style: white17wBold,
              ),
            ),
            AppBarIconContainer(
              onTap: () {
                PageNavigateScreen().push(
                    context,
                    ManuPage(
                      title: 'Add Sales Pitch',
                      pageIndex: 2,
                    ));
              },
              height: SizeConfig.getSize38(context: context),
              width: SizeConfig.getSize38(context: context),
              color: DynamicColor.white,
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: loadSvg(
                    image: 'assets/image/menu.svg',
                    color: DynamicColor.gredient2),
              ),
            ),
          ],
        ));
  }

  Widget iconAndProgressBar() {
    return Padding(
      padding: EdgeInsets.only(
          top: 5,
          left: SizeConfig.getFontSize25(context: context),
          right: SizeConfig.getFontSize25(context: context)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        //alignment: Alignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              widget.backOnTap == null
                  ? BackArrow(
                      alignment: Alignment.topLeft,
                      direction: 1,
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    )
                  : BackArrow(
                      alignment: Alignment.topLeft,
                      direction: 1,
                      onPressed: widget.backOnTap!),
              widget.progressPersent == 0.0
                  ? Container(
                      height: 5,
                      width: MediaQuery.of(context).size.width - 150,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: DynamicColor.black),
                    )
                  : Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 2),
                          child: Text(
                            widget.progressPersent == 0.45
                                ? '45%'
                                : widget.progressPersent == 1
                                    ? '100%'
                                    : '${widget.progressPersent.toString().replaceAll('0.', '')}0%',
                            style: TextStyle(
                                fontSize: 12.0, color: DynamicColor.white),
                          ),
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: LinearPercentIndicator(
                            width: MediaQuery.of(context).size.width - 150,
                            lineHeight: 6.0,
                            percent: widget.progressPersent,
                            backgroundColor: DynamicColor.gredient1,
                            progressColor: DynamicColor.green,
                            barRadius: const Radius.circular(10),
                          ),
                        ),
                      ],
                    ),
              widget.checkNext == null
                  ? SizedBox(
                      height: SizeConfig.getSize38(context: context),
                      width: SizeConfig.getSize38(context: context),
                    )
                  : BackArrow(
                      alignment: Alignment.topRight,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10)),
                      onPressed: widget.nextOnTap,
                    ),
            ],
          ),
          whiteBorderContainer(
              child: Image.asset(Assets.handshakeImage),
              color: Colors.transparent,
              height: SizeConfig.getSizeHeightBy(context: context, by: 0.11),
              width: SizeConfig.getSizeHeightBy(context: context, by: 0.11),
              cornerRadius: 25),
        ],
      ),
    );
  }
}
