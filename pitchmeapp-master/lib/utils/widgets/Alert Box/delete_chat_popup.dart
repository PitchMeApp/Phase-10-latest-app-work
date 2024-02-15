import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pitch_me_app/screens/businessIdeas/home%20biography/Chat/controller.dart';
import 'package:pitch_me_app/utils/colors/colors.dart';
import 'package:pitch_me_app/utils/strings/strings.dart';
import 'package:pitch_me_app/utils/styles/styles.dart';

class DeleteChatPostPopUp extends StatefulWidget {
  String type;
  VoidCallback onTap;
  DeleteChatPostPopUp({
    Key? key,
    required this.type,
    required this.onTap,
  }) : super(key: key);

  @override
  _DeleteChatPostPopUpState createState() => _DeleteChatPostPopUpState();
}

class _DeleteChatPostPopUpState extends State<DeleteChatPostPopUp> {
  ChatController chatController = Get.put(ChatController());

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      title: Center(
        child: Text(
          TextStrings.textKey['delete_chat']!,
          style: const TextStyle(
              color: DynamicColor.gredient1, fontWeight: FontWeight.bold),
        ),
      ),
      content: Text(
        TextStrings.textKey['delete_chat_sub']!,
        textAlign: TextAlign.center,
      ),
      actions: [
        chatController.isloading.value == false
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
                        onPressed: widget.onTap,
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
