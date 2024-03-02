import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pitch_me_app/View/Custom%20header%20view/appbar_with_white_bg.dart';
import 'package:pitch_me_app/View/Custom%20header%20view/new_bottom_bar.dart';
import 'package:pitch_me_app/View/Feedback/controller.dart';
import 'package:pitch_me_app/View/Manu/manu.dart';
import 'package:pitch_me_app/main.dart';
import 'package:pitch_me_app/screens/businessIdeas/home%20biography/Chat/Model/model.dart';
import 'package:pitch_me_app/screens/businessIdeas/home%20biography/Chat/chat.dart';
import 'package:pitch_me_app/screens/businessIdeas/home%20biography/Chat/chat_appsupports.dart';
import 'package:pitch_me_app/screens/businessIdeas/home%20biography/Chat/controller.dart';
import 'package:pitch_me_app/utils/colors/colors.dart';
import 'package:pitch_me_app/utils/sizeConfig/sizeConfig.dart';
import 'package:pitch_me_app/utils/styles/styles.dart';
import 'package:pitch_me_app/utils/widgets/Alert%20Box/delete_chat_popup.dart';
import 'package:pitch_me_app/utils/widgets/Navigation/custom_navigation.dart';
import 'package:pitch_me_app/utils/widgets/containers/containers.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

import '../../../../utils/extras/extras.dart';

class ChatListPage extends StatefulWidget {
  String notifyID;
  ChatListPage({
    super.key,
    required this.notifyID,
  });

  @override
  State<ChatListPage> createState() => _ChatListPageState();
}

class _ChatListPageState extends State<ChatListPage> {
  final ChatController chatController = Get.put(ChatController());
  FeebackController feebackController = Get.put(FeebackController());
  StreamController<ChatListModel> controller =
      StreamController<ChatListModel>();

  dynamic adminChatID;
  dynamic adminmessage;
  dynamic adminunread = 0;
  String datetime = '';
  String usertype = '';
  String adminUser = '';
  dynamic proUser;

  bool isCheckProUser = false;
  @override
  void initState() {
    if (widget.notifyID.isNotEmpty) {
      feebackController.readAllNotiApi(widget.notifyID);
    }
    checkAuth();
    getUserList();

    super.initState();
  }

  void checkAuth() async {
    SharedPreferences preferencesData = await SharedPreferences.getInstance();
    setState(() {
      usertype = preferencesData.getString('log_type').toString();
      adminUser = preferencesData.getString('bot').toString();
      proUser = jsonDecode(preferencesData.getString('pro_user').toString());
    });

    checkUser();
  }

  void checkUser() {
    if (adminUser == 'null' && usertype != '5') {
      if (proUser != null) {
        setState(() {
          isCheckProUser = true;
        });
      }
    } else {
      setState(() {
        isCheckProUser = false;
      });
    }
  }

  void getUserList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var senderID = prefs.get('user_id').toString();
    // log('check = ' + senderID.toString());
    var onCreate = {'sendorid': senderID};
    socket.emit('join_user', onCreate);
    socket.emit('join_admin', onCreate);
    socket.on('receive_users_admin', (data) {
      if (data['messages'] == false) {
        socket.emit('join_admin', onCreate);
      }

      if (data['messages'].length > 0 && senderID == data['roomid']) {
        log(data['messages'].toString());

        Timer(Duration(milliseconds: 500), () {
          setState(() {
            adminChatID = data['messages'][0]['chat']['_id'];
            adminunread = data['messages'][0]['unread'];
            log(adminunread.toString());
            adminmessage = data['messages'][0]['message'];
          });
        });
      }
    });
    if (isCheckProUser) {
      socket.on('receive_users', (data) {
        ChatListModel chatListModel = ChatListModel.fromJson(data);
        controller.add(chatListModel);
        //log(data.toString());
      });
    }
  }

  void deleteChat(chatID) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var senderID = prefs.get('user_id').toString();

    var onCreate = {
      'userid': senderID,
      'chatid': chatID,
    };
    socket.emit('delete_chat', onCreate);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        // appBar:
        body: Stack(children: [
          SizedBox(
            child: Image.asset(
              'assets/images/17580.png',
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.cover,
            ),
          ),
          Column(
            children: [
              Expanded(
                flex: 2,
                child: PreferredSize(
                  preferredSize: Size.fromHeight(160),
                  child: Stack(
                    children: [
                      ClipPath(
                        clipper: CurveClipper(),
                        child: Container(
                          decoration: BoxDecoration(
                              gradient: DynamicColor.gradientColorChange),
                          height: MediaQuery.of(context).size.height * 0.235,
                          child: Stack(
                            alignment: Alignment.bottomCenter,
                            children: [
                              Column(
                                children: [
                                  SizedBox(
                                    height: SizeConfig.getSize60(
                                            context: context) +
                                        SizeConfig.getSize20(context: context),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        top: 2,
                                        left: SizeConfig.getFontSize25(
                                            context: context),
                                        right: SizeConfig.getFontSize25(
                                            context: context)),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        AppBarIconContainer(
                                          onTap: () {
                                            Navigator.of(context).pop();
                                          },
                                          height: SizeConfig.getSize38(
                                              context: context),
                                          width: SizeConfig.getSize38(
                                              context: context),
                                          borderRadius: BorderRadius.only(
                                              topRight: Radius.circular(10),
                                              bottomLeft: Radius.circular(10)),
                                          color: DynamicColor.white,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: RotatedBox(
                                              quarterTurns: 1,
                                              child: Image.asset(
                                                  "assets/Phase 2 icons/ic_keyboard_arrow_down_24px.png",
                                                  height: 30,
                                                  width: 30,
                                                  color:
                                                      DynamicColor.gredient1),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          width: 50,
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              Image.asset(
                                "assets/image/handshake.png",
                                height: 100,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 6,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      aapSupporter(),
                      isCheckProUser ? list() : Container(),
                    ],
                  ),
                ),
              ),
            ],
          ),
          CustomAppbarWithWhiteBg(
            title: 'CHATS',
            colorTween: 'BIOGRAPHY',
            onPressad: () {
              PageNavigateScreen().push(
                  context,
                  ManuPage(
                    title: 'CHATS',
                    pageIndex: 3,
                    isManu: 'Manu',
                  ));
            },
          ),
          NewCustomBottomBar(
            index: 3,
            isBack: true,
          ),
        ]));
  }

  Widget list() {
    return Padding(
      padding: EdgeInsets.only(
          left: SizeConfig.getFontSize20(context: context),
          right: SizeConfig.getFontSize20(context: context)),
      child: StreamBuilder<ChatListModel>(
          stream: controller.stream,
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return Padding(
                  padding: EdgeInsets.only(
                      top: SizeConfig.getSize100(context: context),
                      bottom: SizeConfig.getSize60(context: context)),
                  child: const Center(
                      child: CircularProgressIndicator(
                    color: DynamicColor.gredient1,
                  )),
                );
              default:
                if (snapshot.hasError) {
                  // log(snapshot.error.toString());
                  return Padding(
                      padding: EdgeInsets.only(
                          bottom: SizeConfig.getSize60(context: context)),
                      child: const Center(child: Text('No chats available')));
                } else if (snapshot.data!.messages.isEmpty) {
                  return Padding(
                      padding: EdgeInsets.only(
                          bottom: SizeConfig.getSize60(context: context)),
                      child: const Center(child: Text('No chats available')));
                } else {
                  return ListView.builder(
                      shrinkWrap: true,
                      primary: false,
                      padding: EdgeInsets.zero,
                      itemCount: snapshot.data!.messages.length,
                      itemBuilder: (context, index) {
                        Message data = snapshot.data!.messages[index];
                        //log('cht = ' + data.toJson().toString());
                        if (data.message != null) {
                          int ts = data.message!.time;
                          DateTime tsdate =
                              DateTime.fromMillisecondsSinceEpoch(ts * 1000);
                          datetime = DateFormat('h:mm a').format(tsdate);
                        }

                        return Column(
                          children: [
                            ListTile(
                              onTap: () {
                                PageNavigateScreen().push(
                                    context,
                                    ChatPage(
                                      id: data.chat.id,
                                      recieverid: data.user!.id,
                                      img: data.user!.profilePic,
                                      name: data.user!.username,
                                      userID: data.user!.id,
                                      back: 'back',
                                    ));
                              },
                              contentPadding: EdgeInsets.zero,
                              horizontalTitleGap: 5.0,
                              minLeadingWidth: 0.0,
                              leading: CachedNetworkImage(
                                height: 12.h,
                                width: 12.w,
                                imageUrl: data.user!.profilePic,
                                imageBuilder: (context, imageProvider) =>
                                    CircleAvatar(
                                        radius: 30,
                                        backgroundColor: DynamicColor.white,
                                        backgroundImage: imageProvider),
                                placeholder: (context, url) => const Center(
                                    child: CircularProgressIndicator(
                                  color: DynamicColor.gredient1,
                                )),
                                errorWidget: (context, url, error) =>
                                    const CircleAvatar(
                                  radius: 30,
                                  backgroundColor: DynamicColor.gredient2,
                                  child: Icon(
                                    Icons.person,
                                    size: 28,
                                    color: DynamicColor.white,
                                  ),
                                ),
                              ),
                              title: Text(
                                data.user!.username,
                                style: TextStyle(fontWeight: FontWeight.w500),
                              ),
                              subtitle: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  (data.message) != null
                                      ? data.message!.voice != ''
                                          ? Text(
                                              'Audio',
                                              style: TextStyle(
                                                  color: DynamicColor.hintclr,
                                                  fontWeight: FontWeight.w400),
                                            )
                                          : Container(
                                              height: 0,
                                              width: 0,
                                            )
                                      : Container(
                                          height: 0,
                                          width: 0,
                                        ),
                                  (data.message) != null
                                      ? data.message!.image != ''
                                          ? Text(
                                              'Image',
                                              style: TextStyle(
                                                  color: DynamicColor.hintclr,
                                                  fontWeight: FontWeight.w400),
                                            )
                                          : Container(
                                              height: 0,
                                              width: 0,
                                            )
                                      : Container(
                                          height: 0,
                                          width: 0,
                                        ),
                                  (data.message) != null
                                      ? data.message!.message != ''
                                          ? Text(
                                              data.message!.message,
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  color: DynamicColor.hintclr,
                                                  fontWeight: FontWeight.w400),
                                            )
                                          : Container(
                                              height: 0,
                                              width: 0,
                                            )
                                      : Container(
                                          height: 0,
                                          width: 0,
                                        ),
                                ],
                              ),
                              trailing: SizedBox(
                                width: SizeConfig.getSizeWidthBy(
                                    context: context, by: 0.23),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Column(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(
                                            bottom: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.01,
                                          ),
                                          child: Text(
                                            datetime,
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: DynamicColor.hintclr),
                                          ),
                                        ),
                                        data.unread != 0
                                            ? CircleAvatar(
                                                radius: 12,
                                                backgroundColor:
                                                    DynamicColor.gredient1,
                                                child: Text(
                                                  data.unread.toString(),
                                                  style: white13TextStyle,
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              )
                                            : Container(
                                                height: 0,
                                                width: 0,
                                              )
                                      ],
                                    ),
                                    InkWell(
                                      onTap: () {
                                        showDialog(
                                            context: context,
                                            builder: (context) =>
                                                DeleteChatPostPopUp(
                                                    type: 'chats',
                                                    onTap: () {
                                                      deleteChat(data.chat.id);
                                                    }));
                                      },
                                      child: Icon(
                                        Icons.delete,
                                        size: 25,
                                        color: DynamicColor.gredient2,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Divider(
                              height: 0,
                              color: DynamicColor.butnClr2,
                            )
                          ],
                        );
                      });
                }
            }
          }),
    );
  }

  Widget aapSupporter() {
    return Padding(
      padding: EdgeInsets.only(
          left: SizeConfig.getFontSize20(context: context),
          right: SizeConfig.getFontSize20(context: context)),
      child: Column(
        children: [
          Divider(
            height: 0,
            color: DynamicColor.butnClr2,
          ),
          ListTile(
            onTap: () {
              if (adminChatID == null) {
                myToast(context,
                    msg: 'Something went wrong please try again later.');
              } else {
                PageNavigateScreen().push(
                    context,
                    AppSupporterChatPage(
                      img: '',
                      name: 'Pitch Me App',
                      id: adminChatID,
                      recieverid: 'admin',
                      back: 'back',
                    ));
              }
            },
            contentPadding: EdgeInsets.zero,
            horizontalTitleGap: 5.0,
            minLeadingWidth: 0.0,
            leading: CircleAvatar(
              radius: 23,
              backgroundImage: AssetImage('assets/image/handshake.png'),
              backgroundColor: DynamicColor.gredient2,
            ),
            title: Text(
              'Pitch Me App Support',
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            subtitle: Text(
              'How can we help?',
              // adminmessage != null
              //     ? adminmessage['message']
              //     : 'How can we help?',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  color: DynamicColor.hintclr, fontWeight: FontWeight.w400),
            ),
            trailing: adminunread != 0
                ? Padding(
                    padding: EdgeInsets.only(right: 5),
                    child: CircleAvatar(
                      radius: 12,
                      backgroundColor: DynamicColor.gredient1,
                      child: Text(
                        adminunread.toString(),
                        style: white13TextStyle,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  )
                : Container(
                    height: 0,
                    width: 0,
                  ),
          ),
          Divider(
            height: 0,
            color: DynamicColor.butnClr2,
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    //controller.close();

    super.dispose();
  }
}
