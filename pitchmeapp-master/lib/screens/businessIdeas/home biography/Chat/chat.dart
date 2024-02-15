import 'dart:async';
import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pitch_me_app/View/Custom%20header%20view/appbar_with_white_bg.dart';
import 'package:pitch_me_app/View/Manu/manu.dart';
import 'package:pitch_me_app/main.dart';
import 'package:pitch_me_app/screens/businessIdeas/home%20biography/Chat/Model/chat_room_model.dart';
import 'package:pitch_me_app/screens/businessIdeas/home%20biography/Chat/controller.dart';
import 'package:pitch_me_app/screens/businessIdeas/home%20biography/Chat/normal_user_chat_list.dart';
import 'package:pitch_me_app/screens/businessIdeas/home%20biography/home_page_biography.dart';
import 'package:pitch_me_app/utils/colors/colors.dart';
import 'package:pitch_me_app/utils/sizeConfig/sizeConfig.dart';
import 'package:pitch_me_app/utils/strings/images.dart';
import 'package:pitch_me_app/utils/widgets/Navigation/custom_navigation.dart';
import 'package:pitch_me_app/utils/widgets/containers/containers.dart';
import 'package:pitch_me_app/utils/widgets/extras/backgroundWidget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:voice_message_package/voice_message_package.dart';

import '../../../../utils/widgets/Alert Box/show_image_popup.dart';

class ChatPage extends StatefulWidget {
  dynamic id;
  dynamic recieverid;
  dynamic name;
  dynamic img;
  dynamic back;
  String userID;
  ChatPage({
    Key? key,
    required this.id,
    required this.recieverid,
    required this.name,
    required this.img,
    required this.userID,
    this.back,
  }) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation _colorTween;
  //LocalStorage storage = LocalStorage('user');
  StreamController<List<RoomMessage>> streamController =
      StreamController<List<RoomMessage>>();

  FocusNode focusNode = FocusNode();
  ScrollController controller = ScrollController();
  final ChatController chatController = Get.put(ChatController());
  bool changeColore = false;
  List<RoomMessage> chatRoomModel = [];

  String senderID = '';
  String datetime = '';
  @override
  void initState() {
    //log('recierverid = ' + widget.recieverid.toString());
    if (widget.id != null && widget.recieverid != null) {
      chatController.chatID.value = widget.id;
      chatController.recieverid.value = widget.recieverid;
    }

    // chatController.userID;
    connectAndListen();

    chatController.recordSub = chatController.audioRecorder.value
        .onStateChanged()
        .listen((recordState) {
      //chatController.recordState = recordState;
      setState(() => chatController.recordState = recordState);
    });

    chatController.amplitudeSub = chatController.audioRecorder.value
        .onAmplitudeChanged(const Duration(milliseconds: 300))
        .listen((amp) => setState(() => chatController.amplitude = amp));
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 600));

    _colorTween = ColorTween(begin: DynamicColor.white, end: DynamicColor.white)
        .animate(_animationController);

    Future.delayed(const Duration(seconds: 0), () {
      _animationController.status == AnimationStatus.completed
          ? _animationController.reset()
          : _animationController.forward();
    });

    super.initState();
  }

  connectAndListen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    senderID = prefs.get('user_id').toString();
    chatController.senderID.value = senderID;
    var onjoin = {
      'userid': senderID,
      'chatid': widget.id,
    };
    socket.emit('join_chat', onjoin);
    socket.on('receive_messages', (data) {
      //log(data.toString());
      if (data['roomid'] == widget.id) {
        for (var element in data['message']) {
          chatRoomModel.insert(0, RoomMessage.fromJson(element));
          if (data['message'].length == 1 && element['sendorid'] != senderID) {
            socket.emit('markread', {'id': element['_id']});
          }
        }
        streamController.add(chatRoomModel);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // resizeToAvoidBottomInset: false,
        body: BackGroundWidget(
      backgroundImage: Assets.backgroundImage,
      bannerRequired: false,
      fit: BoxFit.fill,
      child: Stack(
        children: [
          Column(
            children: [
              ClipPath(
                clipper: CurveClipper(),
                child: Container(
                  decoration:
                      BoxDecoration(gradient: DynamicColor.gradientColorChange),
                  height: MediaQuery.of(context).size.height * 0.27,
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      Column(
                        children: [
                          SizedBox(
                            height: SizeConfig.getSize60(context: context) +
                                SizeConfig.getSize20(context: context),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                top: 2,
                                left:
                                    SizeConfig.getFontSize25(context: context),
                                right:
                                    SizeConfig.getFontSize25(context: context)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                AppBarIconContainer(
                                  onTap: () {
                                    if (widget.back != null) {
                                      Navigator.of(context).pop();
                                    } else {
                                      PageNavigateScreen().normalpushReplesh(
                                          context,
                                          ChatListPage(
                                            notifyID: '',
                                          ));
                                    }
                                  },
                                  height:
                                      SizeConfig.getSize38(context: context),
                                  width: SizeConfig.getSize38(context: context),
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(10),
                                      bottomLeft: Radius.circular(10)),
                                  color: DynamicColor.white,
                                  child: Padding(
                                    padding: EdgeInsets.only(left: 0),
                                    child: Icon(
                                      Icons.forum,
                                      color: DynamicColor.gredient1,
                                      size: 28,
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
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          widget.name == null
                              ? Container()
                              : Text(
                                  widget.name,
                                  style: TextStyle(
                                      color: DynamicColor.white,
                                      fontWeight: FontWeight.w500),
                                ),
                          widget.img == null
                              ? Container()
                              : InkWell(
                                  onTap: () {
                                    PageNavigateScreen().push(
                                        context,
                                        HomeBiographyPage(
                                          type: 'back',
                                          userID: widget.userID,
                                          notifyID: '',
                                        ));
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 10, bottom: 10),
                                    child: CachedNetworkImage(
                                      // height: 10.h,
                                      // width: 10.w,
                                      imageUrl: widget.img,
                                      imageBuilder: (context, imageProvider) =>
                                          CircleAvatar(
                                              radius: 25,
                                              backgroundColor:
                                                  DynamicColor.white,
                                              backgroundImage: imageProvider),
                                      placeholder: (context, url) =>
                                          const Center(
                                              child: CircularProgressIndicator(
                                        color: DynamicColor.white,
                                      )),
                                      errorWidget: (context, url, error) =>
                                          const CircleAvatar(
                                        radius: 25,
                                        backgroundColor: DynamicColor.white,
                                        child: Icon(
                                          Icons.person,
                                          size: 28,
                                          color: DynamicColor.gredient1,
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                  flex: 6,
                  child: StreamBuilder<List<RoomMessage>>(
                      stream: streamController.stream,
                      builder: (context, snapshot) {
                        switch (snapshot.connectionState) {
                          case ConnectionState.waiting:
                            return Padding(
                              padding: EdgeInsets.only(
                                  bottom:
                                      SizeConfig.getSize60(context: context)),
                              child: const Center(
                                  child: CircularProgressIndicator(
                                color: DynamicColor.gredient1,
                              )),
                            );
                          default:
                            if (snapshot.hasError) {
                              log(snapshot.error.toString());
                              return Padding(
                                  padding: EdgeInsets.only(
                                      bottom: SizeConfig.getSize60(
                                          context: context)),
                                  child: const Center(
                                      child: Text('No chat available')));
                            } else if (snapshot.data!.isEmpty) {
                              return Padding(
                                  padding: EdgeInsets.only(
                                      bottom: SizeConfig.getSize60(
                                          context: context)),
                                  child: const Center(
                                      child: Text('Start new chat')));
                            } else {
                              return
                                  // chatController.isloading.value != false
                                  //     ?
                                  listData(snapshot.data!);
                              // : Center(
                              //     child: SizedBox(
                              //     height: 170,
                              //     width: 200,
                              //     child: AlertDialog(
                              //       backgroundColor: DynamicColor.lightGrey,
                              //       shape: RoundedRectangleBorder(
                              //           borderRadius:
                              //               BorderRadius.circular(10)),
                              //       alignment: Alignment.center,

                              //       content: Column(
                              //         mainAxisAlignment:
                              //             MainAxisAlignment.center,
                              //         crossAxisAlignment:
                              //             CrossAxisAlignment.center,
                              //         children: [
                              //           CircularProgressIndicator(
                              //               color: DynamicColor.blue),
                              //           SizedBox(height: 20),
                              //           Text(
                              //             'Sending',
                              //             style: blue15,
                              //           ),
                              //         ],
                              //       ),
                              //       // child: Column(
                              //       // mainAxisAlignment: MainAxisAlignment.center,
                              //       // crossAxisAlignment:
                              //       //     CrossAxisAlignment.center,
                              //       // children: [
                              //       //   CircularProgressIndicator(
                              //       //       color: DynamicColor.blue),
                              //       //   SizedBox(height: 20),
                              //       //   Text(
                              //       //     'Sending',
                              //       //     style: blue15,
                              //       //   ),
                              //       // ],
                              //       //                                 ),
                              //     ),
                              //   ));
                            }
                        }
                      })),

              // inputBox()

              chatController.isRecorder.value ? voiceRecord() : Container(),

              chatController.isKeyboardOpen.value
                  ? textBox()
                  : audioMagAndImage()
            ],
          ),
          CustomAppbarWithWhiteBg(
            title: 'CHAT',
            colorTween: 'BIOGRAPHY',
            onPressad: () {
              PageNavigateScreen().push(
                  context,
                  ManuPage(
                    title: 'CHAT',
                    pageIndex: 3,
                    isManu: 'Manu',
                  ));
            },
          ),
        ],
      ),
    ));
  }

  Widget audioMagAndImage() {
    return Padding(
      padding: EdgeInsets.only(bottom: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            height: SizeConfig.getSize50(context: context),
            width: SizeConfig.getSize50(context: context),
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: DynamicColor.white,
                borderRadius: BorderRadius.circular(50),
                border: Border.all(color: DynamicColor.lightGrey)),
            child: InkWell(
              onTap: () {
                setState(() {
                  chatController.isKeyboardOpen.value = true;
                  chatController.audioPath.value = '';
                });
              },
              child: Image.asset(
                'assets/imagess/text.png',
                color: DynamicColor.gredient2,
                height: 25,
              ),
            ),
          ),
          Container(
            height: changeColore
                ? SizeConfig.getSize60(context: context)
                : SizeConfig.getSize50(context: context),
            width: changeColore
                ? SizeConfig.getSize60(context: context)
                : SizeConfig.getSize50(context: context),
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: changeColore ? Colors.red[200] : DynamicColor.white,
                borderRadius: BorderRadius.circular(50),
                border: Border.all(color: DynamicColor.lightGrey)),
            child: GestureDetector(
              onLongPress: () {
                setState(() {
                  chatController.start();
                  changeColore = true;
                  chatController.isRecorder.value = true;
                  chatController.audioPath.value = '';
                });
              },
              onLongPressEnd: (value) {
                setState(() {
                  chatController.stop();
                  changeColore = false;
                  chatController.isRecorder.value = false;
                });
                //_sendMessage();
              },
              // onTap: () {
              //   setState(() {
              //     isRecorder = true;
              //   });
              // },
              child: Icon(
                Icons.mic,
                color: changeColore
                    ? DynamicColor.redColor
                    : DynamicColor.gredient2,
                size: 30,
              ),
            ),
          ),
          Container(
            height: SizeConfig.getSize50(context: context),
            width: SizeConfig.getSize50(context: context),
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: DynamicColor.white,
                borderRadius: BorderRadius.circular(50),
                border: Border.all(color: DynamicColor.lightGrey)),
            child: InkWell(
              onTap: () {
                setState(() {
                  chatController.audioPath.value = '';
                });
                chatController.selectImage();
              },
              child: Icon(
                Icons.perm_media,
                color: DynamicColor.gredient2,
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget textBox() {
    return Container(
      color: Colors.transparent,
      padding: const EdgeInsets.only(top: 8, bottom: 20, left: 8, right: 8),
      child: Row(
        children: <Widget>[
          Container(
            height: 40,
            width: 40,
            alignment: Alignment.center,
            padding: EdgeInsets.only(left: 8),
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: DynamicColor.white,
                border: Border.all(color: DynamicColor.gredient1)),
            child: InkWell(
              onTap: () {
                setState(() {
                  chatController.isKeyboardOpen.value = false;
                });
              },
              child: const Icon(Icons.arrow_back_ios,
                  color: DynamicColor.gredient2),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: SizedBox(
              height: 60,
              child: TextFormField(
                controller: chatController.messageController,
                focusNode: focusNode,
                textCapitalization: TextCapitalization.sentences,
                textInputAction: TextInputAction.done,
                enabled: true,
                expands: true,
                maxLines: null,
                minLines: null,
                autocorrect: true,
                enableSuggestions: true,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey[100],
                  labelText: 'Type new message',
                  labelStyle: TextStyle(color: DynamicColor.gredient2),
                  contentPadding: const EdgeInsets.all(10),
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(
                        width: 2, color: DynamicColor.gredient1),
                    gapPadding: 10,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                        width: 1, color: DynamicColor.gredient1),
                    gapPadding: 0,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                        width: 2, color: DynamicColor.gredient1),
                    gapPadding: 0,
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                onTap: () {
                  if (focusNode.canRequestFocus == true) {
                    // Timer(const Duration(milliseconds: 10), () {
                    //   controller.animateTo(
                    //     controller.position.maxScrollExtent,
                    //     curve: Curves.easeOut,
                    //     duration: const Duration(milliseconds: 10),
                    //   );
                    // });
                  }
                },
              ),
            ),
          ),
          const SizedBox(width: 10),
          GestureDetector(
            onTap: () {
              chatController.sendMessage();
              // Timer(const Duration(milliseconds: 200), () {
              //   controller.animateTo(
              //     controller.position.maxScrollExtent,
              //     curve: Curves.easeOut,
              //     duration: const Duration(milliseconds: 30),
              //   );
              // });
            },
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: DynamicColor.white,
                  border: Border.all(color: DynamicColor.gredient1)),
              child: const Icon(Icons.send, color: DynamicColor.gredient2),
            ),
          ),
        ],
      ),
    );
  }

  Widget voiceRecord() {
    final String minutes =
        chatController.formatNumber(chatController.recordDuration.value ~/ 60);
    final String seconds =
        chatController.formatNumber(chatController.recordDuration.value % 60);
    return SizedBox(
        //height: 80,
        child: Text(
      '$minutes : $seconds',
      style: TextStyle(
          color: DynamicColor.redColor,
          fontSize: 17,
          fontWeight: FontWeight.w500),
    ));
  }

  Widget showMsg(msg) {
    return VoiceMessage(
      // contactCircleColor: Colors.transparent,
      audioSrc: Uri.parse(msg
              .toString()
              .replaceAll('ciu.ody.mybluehostin.me', 'curveinfotech.com'))
          .toString(),
      meBgColor: DynamicColor.lightGrey,
      contactBgColor: DynamicColor.gredient2,
      contactCircleColor: DynamicColor.gredient2,
      contactFgColor: DynamicColor.gredient2,
      contactPlayIconColor: DynamicColor.white,
      mePlayIconColor: DynamicColor.white,
      contactPlayIconBgColor: DynamicColor.gredient2,
      meFgColor: DynamicColor.gredient2,

      played: false,
      me: true,
      onPlay: () {},
    );
  }

  Widget listData(List<RoomMessage> list) {
    return ListView.builder(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      controller: controller,
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      reverse: true,
      itemCount: list.length,
      itemBuilder: (BuildContext context, int index) {
        var message = list[index];
        // log(message.toString());
        if (message != null) {
          int ts = message.time;
          DateTime tsdate = DateTime.fromMillisecondsSinceEpoch(ts * 1000);
          datetime = DateFormat('h:mm a').format(tsdate);
        }
        return (message.sendorid == senderID)
            ? Align(
                alignment: Alignment.centerRight,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.7,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Card(
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)),
                          child: Container(
                            decoration: BoxDecoration(
                                color: Color(0xffE5E5E5),
                                borderRadius: BorderRadius.circular(30)),
                            padding: EdgeInsets.all(10),
                            constraints: BoxConstraints(
                                maxWidth:
                                    MediaQuery.of(context).size.width * 0.7),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                message.voice != ''
                                    ? showMsg(message.voice)
                                    : Container(
                                        height: 0,
                                        width: 0,
                                      ),
                                message.image != ''
                                    ? CachedNetworkImage(
                                        // height: 12.h,
                                        // width: 12.w,
                                        imageUrl: message.image.replaceAll(
                                            'ciu.ody.mybluehostin.me',
                                            'curveinfotech.com'),
                                        imageBuilder:
                                            (context, imageProvider) => InkWell(
                                          onTap: () {
                                            showDialog(
                                                context: context,
                                                builder: (context) =>
                                                    ShowFullImagePopup(
                                                      image_url: message.image
                                                          .replaceAll(
                                                              'ciu.ody.mybluehostin.me',
                                                              'curveinfotech.com'),
                                                    ));
                                          },
                                          child: Container(
                                            height: 150,
                                            width: 150,
                                            decoration: BoxDecoration(
                                              image: DecorationImage(
                                                  image: imageProvider),
                                            ),
                                          ),
                                        ),
                                        placeholder: (context, url) =>
                                            const Center(
                                                child:
                                                    CircularProgressIndicator(
                                          color: DynamicColor.gredient2,
                                        )),
                                        errorWidget: (context, url, error) =>
                                            Container(
                                          child: Icon(Icons.error),
                                        ),
                                      )
                                    : Container(
                                        height: 0,
                                        width: 0,
                                      ),
                                message.message != ''
                                    ? Text(message.message,
                                        style: const TextStyle(
                                            color: DynamicColor.black,
                                            fontSize: 16))
                                    : Container(
                                        height: 0,
                                        width: 0,
                                      ),
                              ],
                            ),
                          ),
                        ),
                        Text(datetime,
                            style: const TextStyle(
                                color: Colors.grey, fontSize: 10)),
                      ],
                    ),
                  ),
                ),
              )
            : Align(
                alignment: Alignment.centerLeft,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.7,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Card(
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)),
                          child: Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                color: DynamicColor.white,
                                borderRadius: BorderRadius.circular(30)),
                            // constraints: BoxConstraints(
                            //     maxWidth: MediaQuery.of(context).size.width * 0.7),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                message.voice != ''
                                    ? showMsg(message.voice)
                                    : Container(
                                        height: 0,
                                        width: 0,
                                      ),
                                message.image != ''
                                    ? CachedNetworkImage(
                                        // height: 12.h,
                                        // width: 12.w,
                                        imageUrl: message.image,
                                        imageBuilder:
                                            (context, imageProvider) => InkWell(
                                          onTap: () {
                                            showDialog(
                                                context: context,
                                                builder: (context) =>
                                                    ShowFullImagePopup(
                                                      image_url: message.image,
                                                    ));
                                          },
                                          child: Container(
                                            height: 150,
                                            width: 150,
                                            decoration: BoxDecoration(
                                                image: DecorationImage(
                                                    image: imageProvider)),
                                          ),
                                        ),
                                        placeholder: (context, url) =>
                                            const Center(
                                                child:
                                                    CircularProgressIndicator(
                                          color: DynamicColor.gredient2,
                                        )),
                                        errorWidget: (context, url, error) =>
                                            Container(
                                          child: Icon(Icons.error),
                                        ),
                                      )
                                    : Container(
                                        height: 0,
                                        width: 0,
                                      ),
                                message.message != ''
                                    ? Text(message.message,
                                        style: const TextStyle(
                                            color: DynamicColor.black,
                                            fontSize: 16))
                                    : Container(
                                        height: 0,
                                        width: 0,
                                      ),
                              ],
                            ),
                          ),
                        ),
                        Text(datetime,
                            style: const TextStyle(
                                color: Colors.grey, fontSize: 10)),
                      ],
                    ),
                  ),
                ),
              );
      },
    );
  }

  @override
  void dispose() {
    //('despose');
    chatController.recordSub!.cancel();
    chatController.amplitudeSub!.cancel();
    // streamController.close();

    // streamSocket.dispose();
    //_messageController.dispose();
    // _animationController.dispose();

    super.dispose();
  }
}
