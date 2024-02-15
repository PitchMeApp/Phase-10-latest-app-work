import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pitch_me_app/View/Profile/Likes/controller.dart';
import 'package:pitch_me_app/View/Profile/Pitches/controller.dart';
import 'package:pitch_me_app/View/posts/post_conttroller.dart';
import 'package:pitch_me_app/utils/colors/colors.dart';
import 'package:pitch_me_app/utils/strings/strings.dart';
import 'package:pitch_me_app/utils/styles/styles.dart';

class DeleteSalesPostPopUp extends StatefulWidget {
  final id;
  String type;
  DeleteSalesPostPopUp({Key? key, required this.id, required this.type})
      : super(key: key);

  @override
  _DeleteSalesPostPopUpState createState() => _DeleteSalesPostPopUpState();
}

class _DeleteSalesPostPopUpState extends State<DeleteSalesPostPopUp> {
  final PostController postController = Get.put(PostController());
  final LikesController likesController = Get.put(LikesController());
  final PitcheController pitcheController = Get.put(PitcheController());

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      title: Center(
        child: Text(
          widget.type == 'Posts'
              ? TextStrings.textKey['delete_sales']!
              : widget.type == 'Pitches'
                  ? TextStrings.textKey['delete_pitchs']!
                  : widget.type == 'Likes'
                      ? TextStrings.textKey['delete_likes']!
                      : TextStrings.textKey['delete_sales']!,
          style: const TextStyle(
              color: DynamicColor.gredient1, fontWeight: FontWeight.bold),
        ),
      ),
      content: Text(
        widget.type == 'Posts'
            ? TextStrings.textKey['delete_sales_sub']!
            : widget.type == 'Pitches'
                ? TextStrings.textKey['delete_pitchs_sub']!
                : widget.type == 'Likes'
                    ? TextStrings.textKey['delete_likes_sub']!
                    : TextStrings.textKey['delete_sales_sub']!,
        textAlign: TextAlign.center,
      ),
      actions: [
        postController.isLoading.value == false
            ? Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          TextStrings.textKey['no']!,
                          style: gredient115,
                        )),
                    TextButton(
                        onPressed: () {
                          if (widget.type == 'Posts') {
                            postController.deleteApiCall(widget.id, context);
                          } else if (widget.type == 'Pitches') {
                            pitcheController.deleteData(widget.id, context);
                          } else if (widget.type == 'Likes') {
                            likesController.deleteApiCall(widget.id, context);
                          }
                        },
                        child: Text(
                          TextStrings.textKey['yes']!,
                          style: red15,
                        ))
                  ],
                ),
              )
            : const Center(
                child: CircularProgressIndicator(
                  color: DynamicColor.gredient1,
                ),
              )
      ],
    );
  }
}
