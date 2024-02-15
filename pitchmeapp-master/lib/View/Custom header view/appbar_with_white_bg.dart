import 'package:flutter/material.dart';
import 'package:pitch_me_app/View/Notification/notification_list.dart';
import 'package:pitch_me_app/utils/colors/colors.dart';
import 'package:pitch_me_app/utils/extras/extras.dart';
import 'package:pitch_me_app/utils/sizeConfig/sizeConfig.dart';
import 'package:pitch_me_app/utils/styles/styles.dart';
import 'package:pitch_me_app/utils/widgets/containers/containers.dart';

import '../../utils/widgets/Arrow Button/back_arrow.dart';

class CustomAppbarWithWhiteBg extends StatefulWidget {
  final String title;
  VoidCallback onPressad;
  VoidCallback? nextOnTap;
  VoidCallback? backOnTap;
  dynamic backCheckBio;
  dynamic checkNew;
  dynamic checkNext;
  dynamic isManuColor;
  dynamic colorTween;
  dynamic notifyIconForTutorial;
  CustomAppbarWithWhiteBg({
    super.key,
    required this.title,
    required this.onPressad,
    this.isManuColor,
    this.colorTween,
    this.nextOnTap,
    this.checkNext,
    this.checkNew,
    this.backCheckBio,
    this.backOnTap,
    this.notifyIconForTutorial,
  });

  @override
  State<CustomAppbarWithWhiteBg> createState() =>
      _CustomAppbarWithWhiteBgState();
}

class _CustomAppbarWithWhiteBgState extends State<CustomAppbarWithWhiteBg> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Align(
          alignment: Alignment.topCenter,
          child: Padding(
            padding: EdgeInsets.only(
                top: SizeConfig.getSize30(context: context) +
                    MediaQuery.of(context).size.height * 0.021,
                left: SizeConfig.getFontSize25(context: context),
                right: SizeConfig.getFontSize25(context: context)),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: SizeConfig.getSize38(context: context),
                      width: SizeConfig.getSize38(context: context),
                    ),
                    Container(
                      height: SizeConfig.getSize38(context: context),
                      alignment: Alignment.center,
                      child: Text(
                        widget.title.toUpperCase(),
                        style: white17wBold,
                      ),
                    ),
                    AppBarIconContainer(
                      onTap: widget.onPressad,
                      height: SizeConfig.getSize38(context: context),
                      width: SizeConfig.getSize38(context: context),
                      color: DynamicColor.white,
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: loadSvg(
                            image: 'assets/image/menu.svg',
                            color: widget.isManuColor == null
                                ? DynamicColor.gredient2
                                : DynamicColor.darkBlue),
                      ),
                    )
                  ],
                ),
                SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    widget.backCheckBio != null
                        ? BackArrow(
                            alignment: Alignment.topLeft,
                            direction: 1,
                            onPressed: widget.backOnTap!,
                          )
                        : widget.checkNext == null
                            ? SizedBox(
                                height: SizeConfig.getSize38(context: context),
                                width: SizeConfig.getSize38(context: context),
                              )
                            : BackArrow(
                                alignment: Alignment.topLeft,
                                direction: 1,
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                    widget.checkNew == null
                        ? SizedBox(
                            height: SizeConfig.getSize38(context: context),
                            width: SizeConfig.getSize38(context: context),
                          )
                        : BackArrow(
                            alignment: Alignment.topRight,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                bottomRight: Radius.circular(10)),
                            direction: 3,
                            onPressed: widget.nextOnTap!,
                          ),
                  ],
                )
              ],
            ),
          ),
        ),
        NotificationManuList(
          isManu: widget.notifyIconForTutorial == null ? true : false,
          isFilter: widget.notifyIconForTutorial == null ? true : false,
        )
      ],
    );
  }
}
