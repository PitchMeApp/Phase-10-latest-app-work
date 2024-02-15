import 'package:flutter/material.dart';
import 'package:pitch_me_app/utils/colors/colors.dart';

Widget myCheckBox(bool value) {
  return value
      ? Icon(
          Icons.check_box_outlined,
          color: DynamicColor.gredient1,
        )
      : Icon(
          Icons.check_box_outline_blank_rounded,
          color: DynamicColor.textColor,
        );
}
