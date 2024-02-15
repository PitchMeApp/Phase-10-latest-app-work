import 'package:flutter/material.dart';
import 'package:pitch_me_app/utils/colors/colors.dart';
import 'package:pitch_me_app/utils/sizeConfig/sizeConfig.dart';
import 'package:pitch_me_app/utils/strings/images.dart';

class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> with SingleTickerProviderStateMixin {
  Animation<double>? withOpacity;
  AnimationController? _controller;

  @override
  void initState() {
    // TODO: implement initState
    _controller = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: Center(
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Opacity(
              opacity: 1.0,
              child: Image.asset(
                Assets.handshakeImage,
                height: SizeConfig.getSize40(context: context),
                width: SizeConfig.getSize40(context: context),
                fit: BoxFit.fitHeight,
              ),
            ),
            SizedBox(
                height: 50.0,
                width: 50.0,
                child: CircularProgressIndicator(
                  color: DynamicColor.gredient1,
                )),
          ],
        ),
      ),
    );
  }
}
