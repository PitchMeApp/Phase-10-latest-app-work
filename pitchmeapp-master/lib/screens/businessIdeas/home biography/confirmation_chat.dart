import 'package:flutter/material.dart';
import 'package:pitch_me_app/main.dart';
import 'package:pitch_me_app/screens/businessIdeas/home%20biography/Chat/chat.dart';
import 'package:pitch_me_app/screens/businessIdeas/home%20biography/Chat/chat_appsupports.dart';
import 'package:pitch_me_app/utils/strings/images.dart';
import 'package:pitch_me_app/utils/widgets/Navigation/custom_navigation.dart';
import 'package:pitch_me_app/utils/widgets/extras/backgroundWidget.dart';
import 'package:pitch_me_app/utils/widgets/extras/banner.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

import '../../../utils/colors/colors.dart';
import '../../../utils/extras/extras.dart';
import '../../../utils/sizeConfig/sizeConfig.dart';
import '../../../utils/styles/styles.dart';

class ConfirmationChat extends StatefulWidget {
  dynamic id;
  dynamic name;
  dynamic img;
  dynamic recieverid;
  ConfirmationChat({
    super.key,
    this.id,
    this.recieverid,
    this.name,
    this.img,
  });

  @override
  State<ConfirmationChat> createState() => _ConfirmationChatState();
}

class _ConfirmationChatState extends State<ConfirmationChat> {
  dynamic chatData;
  dynamic adminchatID;
  dynamic adminmessage;
  dynamic adminunread = 0;
  @override
  void initState() {
    createChat();
    super.initState();
  }

  void createChat() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var senderID = prefs.get('user_id').toString();

    var onCreate = {'sendorid': senderID, 'recieverid': widget.recieverid};
    socket.emit('createchat', onCreate);
    socket.on('receive_user', (data) {
      chatData = data;
    });
  }

  int isCheck = 0;
  @override
  Widget build(BuildContext context) {
    final sizeH = MediaQuery.of(context).size.height;

    return Scaffold(
        bottomNavigationBar: BannerWidget(
          onPressad: () {},
        ),
        body: BackGroundWidget(
          backgroundImage: Assets.backgroundImage,
          fit: BoxFit.fill,
          child: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: sizeH * 0.08,
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: SizeConfig.getSize15(context: context)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          "assets/imagess/Group.png",
                          height: sizeH * 0.09,
                        ),
                        Image.asset(
                          "assets/imagess/Group 2.png",
                          height: sizeH * 0.09,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: sizeH * 0.05,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 0),
                    child: Image.asset(
                      "assets/imagess/Pitch me Logo.png",
                      height: sizeH * 0.17,
                    ),
                  ),
                  spaceHeight(SizeConfig.getSize20(context: context)),
                  Padding(
                    padding: EdgeInsets.only(
                        left: SizeConfig.getSize15(context: context)),
                    child: Image.asset(
                      'assets/imagess/Are you.png',
                      height: SizeConfig.getSizeHeightBy(
                          context: context, by: 0.14),
                    ),
                  ),
                  //spaceHeight(SizeConfig.getSize30(context: context)),
                  SizedBox(
                    child: Column(
                      children: [
                        Text(
                          'You want to connect',
                          style: TextStyle(
                            fontSize: sizeH * 0.025,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.6,
                            color: DynamicColor.textColor,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          'with this person?',
                          style: TextStyle(
                            fontSize: sizeH * 0.025,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.6,
                            color: DynamicColor.textColor,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: sizeH * 0.05,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Card(
                        elevation: 10,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              isCheck = 1;
                            });
                            if (widget.name == 'Pitch Me App') {
                              PageNavigateScreen().normalpushReplesh(
                                  context,
                                  AppSupporterChatPage(
                                    id: adminchatID,
                                    recieverid: 'admin',
                                    name: 'Pitch Me App',
                                    img: '',
                                  ));
                            } else {
                              PageNavigateScreen().normalpushReplesh(
                                  context,
                                  ChatPage(
                                    id: chatData['messages']['_id'],
                                    recieverid: widget.recieverid,
                                    name: widget.name,
                                    img: widget.img,
                                    userID: widget.id,
                                  ));
                            }
                          },
                          child: Container(
                            height: 5.h,
                            width: MediaQuery.of(context).size.width * 0.35,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    bottomLeft: Radius.circular(10)),
                                color: isCheck == 1 ? DynamicColor.white : null,
                                border: isCheck == 1
                                    ? Border.all(color: DynamicColor.gredient2)
                                    : null,
                                gradient: isCheck == 1
                                    ? null
                                    : DynamicColor.gradientColorChange),
                            child: Text(
                              "Yes",
                              style:
                                  isCheck == 1 ? gredient216bold : white16bold,
                            ),
                          ),
                        ),
                      ),
                      Card(
                        elevation: 10,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        margin: EdgeInsets.zero,
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              isCheck = 2;
                            });
                            Navigator.of(context).pop();
                          },
                          child: Container(
                            height: 5.h,
                            width: MediaQuery.of(context).size.width * 0.35,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(10),
                                    bottomRight: Radius.circular(10)),
                                color: isCheck == 2 ? DynamicColor.white : null,
                                border: isCheck == 2
                                    ? Border.all(color: DynamicColor.gredient2)
                                    : null,
                                gradient: isCheck == 2
                                    ? null
                                    : DynamicColor.gradientColorChange),
                            child: Text(
                              "Return",
                              style:
                                  isCheck == 2 ? gredient216bold : white16bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}
