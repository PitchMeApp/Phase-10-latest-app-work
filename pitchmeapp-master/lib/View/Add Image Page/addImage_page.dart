import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pitch_me_app/View/Add%20Image%20Page/controller.dart';
import 'package:pitch_me_app/View/Custom%20header%20view/new_bottom_bar.dart';
import 'package:pitch_me_app/View/navigation_controller.dart';
import 'package:pitch_me_app/utils/colors/colors.dart';
import 'package:pitch_me_app/utils/extras/extras.dart';
import 'package:pitch_me_app/utils/sizeConfig/sizeConfig.dart';
import 'package:pitch_me_app/utils/strings/strings.dart';
import 'package:pitch_me_app/utils/styles/styles.dart';

import '../../utils/strings/images.dart';
import '../../utils/widgets/Navigation/custom_navigation.dart';
import '../../utils/widgets/extras/backgroundWidget.dart';
import '../Custom header view/custom_header_view.dart';
import '../video page/upload_add_video.dart';

class AddImagePage extends StatefulWidget {
  const AddImagePage({super.key});

  @override
  State<AddImagePage> createState() => _AddImagePageState();
}

class _AddImagePageState extends State<AddImagePage> {
  final AddImageController _addImageController = Get.put(AddImageController());
  final NavigationController _navigationController =
      Get.put(NavigationController());
  GlobalKey<FormState> abcKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddImageController>(builder: (controller) {
      return Scaffold(
          body: BackGroundWidget(
        backgroundImage: Assets.backgroundImage,
        fit: BoxFit.fill,
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: SizeConfig.getSize100(context: context) +
                        SizeConfig.getSize55(context: context),
                  ),
                  const SizedBox(height: 30),

                  Container(
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(color: DynamicColor.black))),
                    child: Text(
                      TextStrings.textKey['attechment']!,
                      style: textColor22,
                    ),
                  ),
                  const SizedBox(height: 30),
                  uploadImage(),
                  const SizedBox(height: 10),
                  uploadFile(),
                  const SizedBox(height: 5),
                  Text(
                    'Note: Maximum 15MB file size allowed',
                    style:
                        TextStyle(color: DynamicColor.textColor, fontSize: 15),
                  ),
                  // selectImages(),
                  const SizedBox(height: 20),
                  _imagesGridView(),
                  spaceHeight(
                      SizeConfig.getSizeHeightBy(context: context, by: 0.18))
                  // Text(_addImageController.filePath)
                  // _addFileButton()
                ],
              ),
            ),
            CustomHeaderView(
              progressPersent: 0.8,
              checkNext: _addImageController.listImagePaths.isNotEmpty ||
                      _addImageController.filePath.isNotEmpty
                  ? 'next'
                  : null,
              nextOnTap: () {
                try {
                  if (_navigationController.navigationType.value == 'Post') {
                    if (_addImageController.listImagePaths.isNotEmpty) {
                      PageNavigateScreen().push(
                          context,
                          UploadAndAddImage(
                            key: abcKey,
                          ));
                    } else {
                      myToast(context, msg: 'Please select atleast one image');
                    }
                  } else {
                    Navigator.of(context).pop();
                  }
                } catch (e) {}
              },
            ),
            NewCustomBottomBar(
              index: 2,
            ),
          ],
        ),
      ));
    });
  }

  Widget uploadImage() {
    return Padding(
      padding: EdgeInsets.only(
        left: SizeConfig.getSize50(context: context),
        right: SizeConfig.getSize50(context: context),
      ),
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Container(
          height: MediaQuery.of(context).size.height * 0.2,
          alignment: Alignment.center,
          child: InkWell(
            onTap: () {
              _addImageController.selectImages();
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 50,
                  width: 50,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      gradient: DynamicColor.gradientColorChange,
                      borderRadius: BorderRadius.circular(50)),
                  child: Icon(
                    Icons.add,
                    color: DynamicColor.white,
                    size: 30,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  'Upload up to 3 Images',
                  style: TextStyle(color: DynamicColor.textColor),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget uploadFile() {
    return Padding(
      padding: EdgeInsets.only(
        left: SizeConfig.getSize50(context: context),
        right: SizeConfig.getSize50(context: context),
      ),
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Container(
          height: MediaQuery.of(context).size.height * 0.2,
          alignment: Alignment.center,
          child: InkWell(
            onTap: () {
              _addImageController.getDocumnetFile(context);
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                    height: 50,
                    width: 50,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        gradient: DynamicColor.gradientColorChange,
                        borderRadius: BorderRadius.circular(50)),
                    child: Image.asset(
                      'assets/imagess/Path 103.png',
                      height: 25,
                      width: 25,
                    )),
                SizedBox(height: 5),
                Text(
                  'Upload 1 Pdf',
                  style: TextStyle(color: DynamicColor.textColor),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _imagesGridView() {
    return _addImageController.listImagePaths.isEmpty &&
            _addImageController.filePath.isEmpty
        ? Container()
        : GridView.builder(
            padding: EdgeInsets.only(
              left: SizeConfig.getSize50(context: context),
              right: SizeConfig.getSize50(context: context),
            ),
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: _addImageController.listImagePaths.length + 1,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              mainAxisExtent: 130,
            ),
            itemBuilder: (context, index) {
              if (index == _addImageController.listImagePaths.length) {
                return _addImageController.filePath.isNotEmpty
                    ? Stack(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                gradient: LinearGradient(colors: const [
                                  Color(0xff5388C0),
                                  Color(0xff67C8B5)
                                ]),
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image:
                                        AssetImage('assets/images/pdf.png'))),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Align(
                              alignment: Alignment.topRight,
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    _addImageController.filePath = '';
                                  });
                                },
                                child: Container(
                                  height: 20,
                                  width: 20,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(2),
                                      gradient:
                                          DynamicColor.gradientColorChange),
                                  child: Icon(
                                    Icons.close,
                                    color: DynamicColor.white,
                                    size: 15,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    : Container();
              }
              return Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: FileImage(File(_addImageController
                                .listImagePaths[index]
                                .toString())))),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Align(
                      alignment: Alignment.topRight,
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            _addImageController.listImagePaths.remove(
                                _addImageController.listImagePaths[index]);
                          });
                        },
                        child: Container(
                          height: 20,
                          width: 20,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(2),
                              gradient: DynamicColor.gradientColorChange),
                          child: Icon(
                            Icons.close,
                            color: DynamicColor.white,
                            size: 15,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            });
  }
}
