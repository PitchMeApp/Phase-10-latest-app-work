import 'package:flutter/material.dart';
import 'package:pitch_me_app/utils/extras/extras.dart';

class BackGroundWidget extends StatelessWidget {
  final Widget child;
  final String backgroundImage;
  final bool bannerRequired;
  final bool backgroundRequired;
  final bool imagebottom;
  final BoxFit fit;
  const BackGroundWidget({
    super.key,
    required this.child,
    required this.backgroundImage,
    this.bannerRequired = true,
    this.backgroundRequired = true,
    this.imagebottom = false,
    this.fit = BoxFit.fitWidth,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          backgroundImage,
          fit: fit,
          width: width(context),
          height: height(context),
          // height: imagebottom
          //     ? MediaQuery.of(context).size.height / 2.3
          //     : height(context) * 0.85,
        ),
        child,
      ],
    );
  }
}
