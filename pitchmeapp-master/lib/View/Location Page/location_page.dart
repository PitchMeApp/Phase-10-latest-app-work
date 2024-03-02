import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:google_places_flutter/model/prediction.dart';
import 'package:http/http.dart' as http;
import 'package:location/location.dart';
import 'package:pitch_me_app/View/Location%20Page/location_page_con.dart';
import 'package:pitch_me_app/View/navigation_controller.dart';
import 'package:pitch_me_app/utils/colors/colors.dart';
import 'package:pitch_me_app/utils/sizeConfig/sizeConfig.dart';
import 'package:pitch_me_app/utils/strings/keys.dart';
import 'package:pitch_me_app/utils/styles/styles.dart';
import 'package:pitch_me_app/utils/widgets/Navigation/custom_navigation.dart';
import 'package:sizer/sizer.dart';

import '../../utils/strings/images.dart';
import '../../utils/strings/strings.dart';
import '../../utils/widgets/extras/backgroundWidget.dart';
import '../Custom header view/custom_header_view.dart';
import '../Custom header view/new_bottom_bar.dart';
import '../Select industry/industry_controller.dart';
import '../what need/what_need_page.dart';

class LocationPage extends StatefulWidget {
  const LocationPage({super.key});

  @override
  State<LocationPage> createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  final LocationPageController _locationPageController =
      Get.put(LocationPageController());
  final NavigationController _navigationController =
      Get.put(NavigationController());
  final InsdustryController insdustryController =
      Get.put(InsdustryController());
  GlobalKey<FormState> abcKey = GlobalKey<FormState>();
  String customText = '';
  int checkColor = 0;
  int openSearchBox = 0;
  Location location = Location();
  Completer<GoogleMapController> controllerCompleter = Completer();

  Set<Marker> markers = <Marker>{};
  CameraPosition initialLocation =
      const CameraPosition(target: LatLng(0.0, 0.0));

  double currentLatitude = 0.0;
  double currentLongitude = 0.0;
  double placeLatitude = 0.0;
  double placeLongitude = 0.0;

  String placeAddress = '';

  bool isKeyboardOpen = false;
  //String selectedType = '';

  getCurentPosign() async {
    try {
      location.requestPermission().then((value) {});
      location.getLocation().then((value) {
        if (value != null) {
          currentLatitude = value.latitude!;
          currentLongitude = value.longitude!;
          initialLocation = CameraPosition(
            target: LatLng(value.latitude!, value.longitude!),
            zoom: 14.0,
          );

          markers.add(
            Marker(
              markerId: const MarkerId('place'),
              position: LatLng(value.latitude ?? 0.0, value.longitude ?? 0.0),
              //infoWindow: InfoWindow(title: element.driverName),
              icon: BitmapDescriptor.defaultMarker,
            ),
          );
          getAddress(value.latitude!, value.longitude!);
        }
      });
    } catch (e) {
      location.requestPermission();
    }
  }

  Future<Null> displayPrediction(Prediction p) async {
    try {
      if (p != null) {
        markers.clear();
        final lat = double.parse('${p.lat}').toDouble();

        final lng = double.parse('${p.lng}').toDouble();
        placeAddress = p.description!;
        placeLatitude = double.parse('${p.lat}').toDouble();
        placeLongitude = double.parse('${p.lng}').toDouble();
        final GoogleMapController controller = await controllerCompleter.future;
        controller.animateCamera(CameraUpdate.newCameraPosition(
          CameraPosition(
            target: LatLng(lat.toDouble(), lng.toDouble()),
            zoom: 14.0,
          ),
        ));

        markers.add(
          Marker(
            draggable: false,
            markerId: const MarkerId('place'),
            position: LatLng(lat.toDouble(), lng.toDouble()),
            //infoWindow: const InfoWindow(title: 'Find Place'),
          ),
        );
        setState(() {});
      }
    } catch (e) {
      // log('location = ' + e.toString());
    }
  }

  void getAddress(lat, lang) async {
    try {
      String url =
          'https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$lang&key=${Keys.googleApiKey}';

      var response = await http.get(Uri.parse(url));
      var jsonResponce = jsonDecode(response.body.toString());

      _locationPageController.searchController.text =
          jsonResponce['results'][0]['formatted_address'];
    } catch (e) {
      // log('message = ' + e.toString());
    }
  }

  @override
  void initState() {
    getCurentPosign();
    super.initState();
  }

  ScrollController scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: BackGroundWidget(
        backgroundImage: Assets.backgroundImage,
        fit: BoxFit.fill,
        child: Stack(
          children: [
            SingleChildScrollView(
              physics: ScrollPhysics(),
              controller: scrollController,
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
                      TextStrings.textKey['location']!,
                      style: textColor22,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: 10,
                        bottom: 10,
                        left: SizeConfig.getFontSize25(context: context),
                        right: SizeConfig.getFontSize25(context: context)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        customBox(0.0, 10.0, 10.0, 0.0, Icons.wifi, 'Online', 1,
                            onPressad: () {
                          _locationPageController.selectedType.value = 'Online';
                          setState(() {
                            openSearchBox = 0;
                            if (checkColor == 1) {
                              checkColor = 0;
                              _locationPageController.selectedType.value = '';
                              _locationPageController.customText.value = '';
                            } else {
                              _locationPageController.selectedType.value =
                                  'Online';
                              _locationPageController.customText.value =
                                  'Your Business is Digital.';
                              checkColor = 1;
                            }
                          });
                        }),
                        customBox(
                          10.0,
                          10.0,
                          10.0,
                          10.0,
                          Icons.public,
                          'Anywhere',
                          2,
                          onPressad: () {
                            setState(() {
                              openSearchBox = 0;
                              if (checkColor == 2) {
                                checkColor = 0;
                                _locationPageController.selectedType.value = '';
                                _locationPageController.customText.value = '';
                              } else {
                                _locationPageController.selectedType.value =
                                    'Anywhere';
                                _locationPageController.customText.value =
                                    'Your Business works in any city.';
                                checkColor = 2;
                              }
                            });
                          },
                        ),
                        customBox(
                          10.0,
                          0.0,
                          0.0,
                          10.0,
                          Icons.location_on,
                          'Place',
                          3,
                          onPressad: () {
                            setState(() {
                              if (checkColor == 3) {
                                checkColor = 0;
                                openSearchBox = 0;
                                _locationPageController.selectedType.value = '';
                                _locationPageController.customText.value = '';
                              } else {
                                openSearchBox = 1;
                                _locationPageController.selectedType.value =
                                    'Place';
                                _locationPageController.customText.value =
                                    'Your Business is in a Specific Place.';
                                checkColor = 3;
                              }
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      // _locationPageController.selectedType.value.isEmpty
                      //     ? Container()
                      //     : _footerHint(),
                      _footerHint(),
                      openSearchBox == 1 ? searchBox() : Container(),
                      const SizedBox(height: 20),
                      openSearchBox == 1 ? googleMap() : Container(),
                    ],
                  ),
                  isKeyboardOpen == true
                      ? SizedBox(
                          height: SizeConfig.getSize100(context: context) +
                              SizeConfig.getSize100(context: context) +
                              SizeConfig.getSize40(context: context),
                        )
                      : SizedBox(
                          height: Platform.isIOS
                              ? SizeConfig.getSize100(context: context)
                              : SizeConfig.getSize60(context: context),
                        ),
                ],
              ),
            ),
            CustomHeaderView(
              progressPersent: 0.2,
              checkNext: checkColor != 0 ? 'next' : null,
              nextOnTap: () {
                try {
                  // Get.back();
                  if (_navigationController.navigationType.value == 'Post') {
                    PageNavigateScreen().push(
                        context,
                        WhatNeedPage(
                          key: abcKey,
                        ));
                  } else {
                    Navigator.of(context).pop();
                  }
                } catch (e) {
                  print(e.toString());
                }
              },
            ),
            NewCustomBottomBar(
              index: 2,
            ),
          ],
        ),
      ),
    );
  }

  Widget _footerHint() {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Online: Your Business is Digital.',
            style: textColor12,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
          SizedBox(height: 5),
          Text(
            'Anywhere: Your Business works in any city.',
            style: textColor12,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
          SizedBox(height: 5),
          Text(
            'Place: Your Business is in a Specific Place.',
            style: textColor12,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
        ],
      ),
    );
  }

  Widget searchBox() {
    return Padding(
      padding: EdgeInsets.only(
          left: SizeConfig.getFontSize25(context: context),
          right: SizeConfig.getFontSize25(context: context),
          top: 15,
          bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: SizedBox(
              height: 7.h,
              child: Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: DynamicColor.gredient1)),
                    child: Theme(
                      data: ThemeData(
                          textSelectionTheme: TextSelectionThemeData(
                              selectionColor:
                                  DynamicColor.selectedtextBGColor)),
                      child: GooglePlaceAutoCompleteTextField(
                          textEditingController:
                              _locationPageController.searchController,
                          googleAPIKey: Keys.googleApiKey,
                          onTap: () {
                            setState(() {
                              isKeyboardOpen = true;
                            });
                            _locationPageController.searchController.text = '';
                          },
                          textStyle: gredient116bold,
                          inputDecoration: InputDecoration(
                              hintText: 'Type',
                              hintStyle: TextStyle(
                                  fontSize: 15,
                                  color:
                                      DynamicColor.lightGrey.withOpacity(0.5)),
                              border: InputBorder.none,
                              // outlineInputBorderBlue,
                              // enabledBorder: outlineInputBorderBlue,
                              // disabledBorder: outlineInputBorderBlue,
                              // focusedBorder: outlineInputBorderBlue,
                              suffixIcon: Icon(
                                Icons.location_on,
                                size: 18,
                                color: DynamicColor.lightGrey,
                              ),
                              contentPadding: const EdgeInsets.only(
                                  top: 15, left: 5, right: 5)),
                          // countries: const ["in", "us"],
                          countries: const ["us", "AE"],
                          currentLatitude: currentLatitude,
                          currentLongitude: currentLongitude,
                          debounceTime: 0,
                          isLatLngRequired: true,
                          getPlaceDetailWithLatLng: (Prediction prediction) {
                            _locationPageController.searchController.text =
                                prediction.description!;
                            displayPrediction(prediction);
                          },
                          itmClick: (Prediction prediction) {
                            setState(() {
                              isKeyboardOpen = false;
                            });
                            FocusScope.of(context).requestFocus(FocusNode());
                          }),
                    )),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget googleMap() {
    return Card(
      elevation: 10,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Container(
          height: 27.h,
          width: MediaQuery.of(context).size.width - 45,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
          child: GoogleMap(
            markers: Set<Marker>.from(markers),
            initialCameraPosition: initialLocation,
            myLocationEnabled: false,
            myLocationButtonEnabled: false,
            mapType: MapType.normal,
            zoomGesturesEnabled: true,
            zoomControlsEnabled: false,
            onMapCreated: (GoogleMapController controller) {
              setState(() {
                controllerCompleter.complete(controller);
                getCurentPosign();
              });
            },
          ),
        ),
      ),
    );
  }

  Widget customBox(topLeft, bottomLeft, topRight, bottomRight,
      IconData iconData, String string, int isCheck,
      {required VoidCallback onPressad}) {
    return InkWell(
      onTap: onPressad,
      child: Column(
        children: [
          Card(
            elevation: checkColor == isCheck ? 0 : 5,
            color: checkColor == isCheck ? Colors.transparent : null,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
              topLeft: Radius.circular(topLeft),
              bottomLeft: Radius.circular(bottomLeft),
              topRight: Radius.circular(topRight),
              bottomRight: Radius.circular(bottomRight),
            )),
            child: Container(
              height: SizeConfig.getSize50(context: context),
              width: SizeConfig.getSize50(context: context),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: checkColor == isCheck ? Colors.transparent : null,
                  gradient: checkColor == isCheck
                      ? null
                      : DynamicColor.gradientColorChange,
                  border: checkColor != isCheck
                      ? null
                      : Border.all(color: DynamicColor.gredient1),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(topLeft),
                    bottomLeft: Radius.circular(bottomLeft),
                    topRight: Radius.circular(topRight),
                    bottomRight: Radius.circular(bottomRight),
                  )),
              child: checkColor == isCheck
                  ? ShaderMask(
                      shaderCallback: (Rect bounds) {
                        return LinearGradient(
                          colors: const [
                            DynamicColor.gredient1,
                            DynamicColor.gredient2
                          ],
                        ).createShader(bounds);
                      },
                      child: Icon(
                        iconData,
                        color: DynamicColor.white,
                        size: 30,
                      ),
                    )
                  : Icon(
                      iconData,
                      color: DynamicColor.white,
                      size: 30,
                    ),
            ),
          ),
          Text(
            string,
            style: TextStyle(color: DynamicColor.textColor, fontSize: 16),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
        ],
      ),
    );
  }

  void onMapDispose() async {
    final GoogleMapController controller = await controllerCompleter.future;
    controller.dispose();
    // log('dispose');
  }

  @override
  void dispose() {
    onMapDispose();
    super.dispose();
  }
}
