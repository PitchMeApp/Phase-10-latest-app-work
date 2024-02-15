import 'package:flutter/material.dart';

import '../../colors/colors.dart';
import '../../sizeConfig/sizeConfig.dart';
import '../containers/containers.dart';

class BackArrow extends StatelessWidget {
  Alignment alignment;
  VoidCallback onPressed;
  int? direction;
  BorderRadius? borderRadius;
  BackArrow({
    super.key,
    required this.alignment,
    required this.onPressed,
    this.direction,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment,
      child: AppBarIconContainer(
        height: SizeConfig.getSize38(context: context),
        width: SizeConfig.getSize38(context: context),
        borderRadius: borderRadius == null
            ? BorderRadius.only(
                topRight: Radius.circular(10), bottomLeft: Radius.circular(10))
            : borderRadius!,
        color: alignment == Alignment.topRight ||
                alignment == Alignment.bottomRight
            ? DynamicColor.green
            : DynamicColor.white,
        onTap: onPressed,
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: RotatedBox(
            quarterTurns: direction == null ? 3 : direction!,
            child: Image.asset(
              "assets/Phase 2 icons/ic_keyboard_arrow_down_24px.png",
              height: 30,
              width: 30,
              color: alignment == Alignment.topLeft
                  ? DynamicColor.gredient1
                  : DynamicColor.white,
            ),
          ),
        ),
      ),
    );
  }
}
