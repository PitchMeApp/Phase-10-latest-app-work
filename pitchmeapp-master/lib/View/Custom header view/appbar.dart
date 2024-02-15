import 'package:flutter/material.dart';
import 'package:pitch_me_app/utils/colors/colors.dart';
import 'package:pitch_me_app/utils/extras/extras.dart';
import 'package:pitch_me_app/utils/sizeConfig/sizeConfig.dart';
import 'package:pitch_me_app/utils/styles/styles.dart';
import 'package:pitch_me_app/utils/widgets/containers/containers.dart';

import '../Notification/notification_list.dart';

class CustomAppbar extends StatefulWidget {
  final String title;
  VoidCallback onPressad;
  VoidCallback onPressadForNotify;
  dynamic isManuColor;
  dynamic notifyIconForTutorial;

  CustomAppbar({
    super.key,
    required this.title,
    required this.onPressad,
    required this.onPressadForNotify,
    this.isManuColor,
    this.notifyIconForTutorial,
  });

  @override
  State<CustomAppbar> createState() => _CustomAppbarState();
}

class _CustomAppbarState extends State<CustomAppbar> {
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
            child: Row(
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
                    style: gredient117bold,
                  ),
                ),
                AppBarIconContainer(
                  onTap: widget.onPressad,
                  height: SizeConfig.getSize38(context: context),
                  width: SizeConfig.getSize38(context: context),
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: loadSvg(
                        image: 'assets/image/menu.svg',
                        color: widget.isManuColor == null
                            ? null
                            : DynamicColor.darkBlue),
                  ),
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
