import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pitch_me_app/View/Custom%20header%20view/appbar_with_white_bg.dart';
import 'package:pitch_me_app/View/Manu/manu.dart';
import 'package:pitch_me_app/main.dart';
import 'package:pitch_me_app/screens/businessIdeas/home%20biography/Chat/Model/chat_room_model.dart';
import 'package:pitch_me_app/screens/businessIdeas/home%20biography/Chat/normal_user_chat_list.dart';
import 'package:pitch_me_app/screens/businessIdeas/home%20biography/Chat/show_full_video.dart';
import 'package:pitch_me_app/screens/businessIdeas/home%20biography/Chat/suport_conroller.dart';
import 'package:pitch_me_app/utils/colors/colors.dart';
import 'package:pitch_me_app/utils/sizeConfig/sizeConfig.dart';
import 'package:pitch_me_app/utils/widgets/Navigation/custom_navigation.dart';
import 'package:pitch_me_app/utils/widgets/containers/containers.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_viewer/video_viewer.dart';
import 'package:voice_message_package/voice_message_package.dart';

import '../../../../utils/widgets/Alert Box/show_image_popup.dart';

class AppSupporterChatPage extends StatefulWidget {
  dynamic id;
  dynamic recieverid;
  dynamic name;
  dynamic img;
  dynamic back;
  AppSupporterChatPage({
    Key? key,
    this.id,
    this.recieverid,
    this.name,
    this.img,
    this.back,
  }) : super(key: key);

  @override
  State<AppSupporterChatPage> createState() => _AppSupporterChatPageState();
}

class _AppSupporterChatPageState extends State<AppSupporterChatPage> {
  StreamController<List<RoomMessage>> streamController =
      StreamController<List<RoomMessage>>();

  FocusNode focusNode = FocusNode();
  VideoViewerController videoViewerController = VideoViewerController();
  ScrollController controller = ScrollController();
  final SuportChatController chatController = Get.put(SuportChatController());
  bool changeColore = false;
  List<RoomMessage> chatRoomModel = [];

  String senderID = '';
  @override
  void initState() {
    if (widget.id != null && widget.recieverid != null) {
      chatController.chatID.value = widget.id.toString();
      chatController.recieverid.value = widget.recieverid.toString();
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
    //log()
    socket.emit('join_chat_admin', onjoin);
    socket.on('receive_messages_admin', (data) {
      //  log('test  =' + data.toString());
      if (data['roomid'] == widget.id) {
        for (var element in data['message']) {
          chatRoomModel.insert(0, RoomMessage.fromJson(element));
          // if (data['message'].length == 1 && element['sendorid'] != senderID) {
          //   socket.emit('markread', {'id': element['_id']});
          // }
        }
        streamController.add(chatRoomModel);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // resizeToAvoidBottomInset: false,
        body: Stack(
      children: [
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
                              left: SizeConfig.getFontSize25(context: context),
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
                                height: SizeConfig.getSize38(context: context),
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
                        CircleAvatar(
                          radius: 35,
                          backgroundColor: Colors.transparent,
                          backgroundImage:
                              AssetImage('assets/image/handshake.png'),
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
                                    bottom:
                                        SizeConfig.getSize60(context: context)),
                                child: const Center(
                                    child: Text('No chat available')));
                          } else if (snapshot.data!.isEmpty) {
                            return Padding(
                                padding: EdgeInsets.only(
                                    bottom:
                                        SizeConfig.getSize60(context: context)),
                                child: const Center(
                                    child: Text('Start new chat')));
                          } else {
                            return
                                // chatController.isloading.value == false
                                //     ?
                                listData(snapshot.data!);
                            // : Center(
                            //     child: Column(
                            //     mainAxisAlignment: MainAxisAlignment.center,
                            //     crossAxisAlignment:
                            //         CrossAxisAlignment.center,
                            //     children: [
                            //       CircularProgressIndicator(
                            //           color: DynamicColor.gredient1),
                            //       SizedBox(height: 20),
                            //       Text(
                            //         'Sending',
                            //         style: blue15,
                            //       ),
                            //     ],
                            //   ));
                          }
                      }
                    })),

            // inputBox()

            chatController.isRecorder.value ? voiceRecord() : Container(),

            chatController.isKeyboardOpen.value ? textBox() : audioMagAndImage()
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
                height: 25,
                color: DynamicColor.gredient2,
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
                  labelStyle: TextStyle(color: DynamicColor.gredient1),
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
              chatController.sendMessageAdmin();
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

  Widget showVideo(String url) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Container(
            width: SizeConfig.getSizeWidthBy(context: context, by: 0.4),
            height: SizeConfig.getSizeHeightBy(context: context, by: 0.2),
            color: Color.fromARGB(255, 254, 254, 254),
            child: VideoViewer(
              controller: videoViewerController,
              autoPlay: false,
              enableHorizontalSwapingGesture: false,
              enableVerticalSwapingGesture: false,
              volumeManager: VideoViewerVolumeManager.device,
              onFullscreenFixLandscape: false,
              forwardAmount: 5,
              defaultAspectRatio: 9 / 16,
              rewindAmount: -5,
              looping: true,
              enableChat: true,
              enableShowReplayIconAtVideoEnd: false,
              style: VideoViewerStyle(
                  playAndPauseStyle: PlayAndPauseWidgetStyle(
                    background: Colors.transparent,
                    circleRadius: 80.0,
                    play: Center(
                      child: Icon(
                        Icons.play_arrow,
                        size: 80,
                        color: DynamicColor.white,
                      ),
                    ),
                    pause: Center(
                      child: Icon(
                        Icons.pause,
                        size: 80,
                        color: DynamicColor.white,
                      ),
                    ),
                  ),
                  thumbnail: Image.asset(''),
                  loading: CircularProgressIndicator(
                    color: DynamicColor.gredient1,
                  )),
              source: {
                "Source": VideoSource(
                  video: VideoPlayerController.network(url),
                )
              },
            ),
          ),
        ),
        Container(
          width: SizeConfig.getSizeWidthBy(context: context, by: 0.4),
          height: SizeConfig.getSizeHeightBy(context: context, by: 0.2),
          child: InkWell(
            onTap: () {
              showDialog(
                  context: context,
                  builder: (context) => ShowFullVideo(videoUrl: url));
            },
            child: Center(
              child: Icon(
                Icons.play_arrow,
                size: 80,
                color: DynamicColor.white,
              ),
            ),
          ),
        )
      ],
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
        // log(message.toJson().toString());
        return (message.sendorid == senderID)
            ? Align(
                alignment: Alignment.centerRight,
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
                                      imageBuilder: (context, imageProvider) =>
                                          InkWell(
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
                                                  image: imageProvider)),
                                        ),
                                      ),
                                      placeholder: (context, url) =>
                                          const Center(
                                              child: CircularProgressIndicator(
                                        color: DynamicColor.gredient1,
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
                      Text(
                          DateFormat('h:mm a')
                              .format(DateTime.parse(message.updatedAt)),
                          style: const TextStyle(
                              color: Colors.grey, fontSize: 10)),
                    ],
                  ),
                ),
              )
            : Align(
                alignment: Alignment.centerLeft,
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
                              message.video != ''
                                  ? showVideo(message.video)
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
                                      imageBuilder: (context, imageProvider) =>
                                          InkWell(
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
                                                  image: imageProvider)),
                                        ),
                                      ),
                                      placeholder: (context, url) =>
                                          const Center(
                                              child: CircularProgressIndicator(
                                        color: DynamicColor.gredient1,
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
                      Text(
                          DateFormat('h:mm a')
                              .format(DateTime.parse(message.updatedAt)),
                          style: const TextStyle(
                              color: Colors.grey, fontSize: 10)),
                    ],
                  ),
                ),
              );
      },
    );
  }

  @override
  void dispose() {
    // log('despose');
    chatController.recordSub!.cancel();
    chatController.amplitudeSub!.cancel();
    videoViewerController.pause();
    videoViewerController.dispose();
    // streamController.close();

    // streamSocket.dispose();
    //_messageController.dispose();
    // _animationController.dispose();

    super.dispose();
  }
}
