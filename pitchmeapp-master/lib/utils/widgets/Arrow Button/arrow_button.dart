import 'package:flutter/material.dart';
import 'package:pitch_me_app/utils/colors/colors.dart';
import 'package:sizer/sizer.dart';

class ArrowButton extends StatefulWidget {
  final VoidCallback onPressed;
  const ArrowButton({
    super.key,
    required this.onPressed,
  });

  @override
  State<ArrowButton> createState() => _ArrowButtonState();
}

class _ArrowButtonState extends State<ArrowButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onPressed,
      child: Padding(
        padding: const EdgeInsets.only(top: 20, right: 0),
        child: Stack(alignment: Alignment.center, children: [
          Material(
            elevation: 10,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
            child: Container(
              height: 5.h,
              width: 10.w,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: DynamicColor.gredient1,
              ),
            ),
          ),
          Image.asset(
            'assets/icons/arrow.png',
            height: 20,
          ),
        ]),
      ),
    );
  }
}
