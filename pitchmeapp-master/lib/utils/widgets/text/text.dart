import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pitch_me_app/utils/colors/colors.dart';

Widget inter(
    {required double size,
    required String text,
    Color color = DynamicColor.white,
    FontWeight fontWeight = FontWeight.normal,
    TextAlign textAlign = TextAlign.left}) {
  return Text(
    text,
    style: GoogleFonts.inter(
        textStyle: TextStyle(
      fontSize: size,
      color: color,
      fontWeight: fontWeight,
    )),
    textAlign: textAlign,
  );
}

Widget roboto(
    {required double size,
    required String text,
    Color color = DynamicColor.gredient1,
    FontWeight fontWeight = FontWeight.normal,
    TextAlign textAlign = TextAlign.center}) {
  return Text(
    text,
    style: GoogleFonts.roboto(
        textStyle: TextStyle(
      fontSize: size,
      color: color,
      fontWeight: fontWeight,
    )),
    // style: TextStyle(
    //     fontFamily: 'Proxima Nova',
    //     fontSize: size,
    //     color: color,
    //     fontWeight: fontWeight),
    textHeightBehavior: TextHeightBehavior(applyHeightToFirstAscent: false),
    textAlign: textAlign,
  );
}
