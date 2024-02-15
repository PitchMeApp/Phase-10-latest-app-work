import 'package:flutter/material.dart';
import 'package:pitch_me_app/utils/colors/colors.dart';
import 'package:sizer/sizer.dart';

class ShowFullImagePopup extends StatefulWidget {
  final image_url;
  const ShowFullImagePopup({super.key, required this.image_url});

  @override
  State<ShowFullImagePopup> createState() => _ShowFullImagePopupState();
}

class _ShowFullImagePopupState extends State<ShowFullImagePopup> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: DynamicColor.black,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      contentPadding: const EdgeInsets.all(0),
      insetPadding: const EdgeInsets.all(10),
      content: Stack(alignment: Alignment.bottomRight, children: [
        Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                  image: NetworkImage(widget.image_url), fit: BoxFit.contain)),
        ),
        GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Container(
              height: 7.h,
              width: 14.w,
              alignment: Alignment.center,
              margin: const EdgeInsets.only(right: 8, bottom: 8),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: DynamicColor.lightBlack),
              child: const Icon(
                Icons.close,
                color: DynamicColor.white,
                size: 30,
              )),
        ),
      ]),
    );
  }
}
