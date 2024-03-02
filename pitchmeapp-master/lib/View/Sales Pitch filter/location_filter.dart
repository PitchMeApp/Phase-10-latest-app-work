import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:google_places_flutter/model/prediction.dart';
import 'package:http/http.dart' as http;
import 'package:location/location.dart';
import 'package:pitch_me_app/View/Sales%20Pitch%20filter/Controller/filter_controller.dart';
import 'package:pitch_me_app/View/Sales%20Pitch%20filter/filter_page.dart';
import 'package:pitch_me_app/View/Sales%20Pitch%20filter/industry_filter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

import '../../utils/colors/colors.dart';
import '../../utils/sizeConfig/sizeConfig.dart';
import '../../utils/strings/images.dart';
import '../../utils/strings/keys.dart';
import '../../utils/strings/strings.dart';
import '../../utils/styles/styles.dart';
import '../../utils/widgets/Navigation/custom_navigation.dart';
import '../../utils/widgets/containers/containers.dart';
import '../../utils/widgets/extras/backgroundWidget.dart';
import '../Custom header view/appbar_with_white_bg.dart';
import '../Custom header view/new_bottom_bar.dart';
import '../Manu/manu.dart';

class LocationFilterPage extends StatefulWidget {
  const LocationFilterPage({super.key});

  @override
  State<LocationFilterPage> createState() => _LocationFilterPageState();
}

class _LocationFilterPageState extends State<LocationFilterPage> {
  SalesPitchFilterController controller = Get.put(SalesPitchFilterController());

  Location location = Location();
  Completer<GoogleMapController> controllerCompleter = Completer();

  Set<Marker> markers = <Marker>{};
  CameraPosition initialLocation =
      const CameraPosition(target: LatLng(0.0, 0.0));

  bool isKeyboardOpen = false;
  @override
  void initState() {
    super.initState();
    getCurentPosign();
    getFilterData();
  }

  void getFilterData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var location = prefs.getString('location').toString();
    var location_tap = prefs.getInt('location_tap')!;
    setState(() {
      log(location);
      if (location != 'Online' && location != 'Anywhere') {
        controller.searchController.text = location;
        controller.selectedLocation.value = 'Place';
        controller.openSearchBox.value = 1;
        log('messagef');
      } else {
        log('s');
        controller.searchController.text = '';
        controller.selectedLocation.value = location;
        controller.openSearchBox.value = 0;
      }

      controller.checkColor.value = location_tap;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: BackGroundWidget(
        backgroundImage: Assets.backgroundImage,
        fit: BoxFit.cover,
        child: Stack(
          children: [
            Column(
              children: [
                Expanded(
                  flex: 2,
                  child: Column(
                    children: [
                      Stack(
                        alignment: Alignment.topCenter,
                        children: [
                          ClipPath(
                            clipper: CurveClipper(),
                            child: Container(
                              decoration: BoxDecoration(
                                  gradient: DynamicColor.gradientColorChange),
                              height: MediaQuery.of(context).size.height * 0.27,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                top: SizeConfig.getSizeHeightBy(
                                    context: context, by: 0.15)),
                            child: whiteBorderContainer(
                                child: Image.asset(Assets.handshakeImage),
                                color: Colors.transparent,
                                height: SizeConfig.getSizeHeightBy(
                                    context: context, by: 0.12),
                                width: SizeConfig.getSizeHeightBy(
                                    context: context, by: 0.12),
                                cornerRadius: 25),
                          ),
                          ComanFilterIcon(),
                        ],
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const SizedBox(height: 10),
                        Container(
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom:
                                      BorderSide(color: DynamicColor.black))),
                          child: Text(
                            'Choose what type of Pitches you want to see',
                            style: textColor12,
                          ),
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.04),
                        FilterTitleComanWidget(
                          context: context,
                          title: TextStrings.textKey['location']!,
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: 10,
                              bottom: 10,
                              left: SizeConfig.getFontSize25(context: context),
                              right:
                                  SizeConfig.getFontSize25(context: context)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              customBox(
                                  0.0, 10.0, 10.0, 0.0, Icons.wifi, 'Online', 1,
                                  onPressad: () {
                                controller.selectedLocation.value = 'Online';
                                setState(() {
                                  controller.openSearchBox.value = 0;
                                  if (controller.checkColor.value == 1) {
                                    controller.checkColor.value = 0;
                                    controller.selectedLocation.value = '';
                                    controller.customText.value = '';
                                  } else {
                                    controller.selectedLocation.value =
                                        'Online';
                                    controller.customText.value =
                                        'Your Business is Digital.';
                                    controller.checkColor.value = 1;
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
                                    controller.openSearchBox.value = 0;
                                    if (controller.checkColor.value == 2) {
                                      controller.checkColor.value = 0;
                                      controller.selectedLocation.value = '';
                                      controller.customText.value = '';
                                    } else {
                                      controller.selectedLocation.value =
                                          'Anywhere';
                                      controller.customText.value =
                                          'Your Business works in any city.';
                                      controller.checkColor.value = 2;
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
                                    if (controller.checkColor.value == 3) {
                                      controller.checkColor.value = 0;
                                      controller.openSearchBox.value = 0;
                                      controller.selectedLocation.value = '';
                                      controller.customText.value = '';
                                      controller.searchController.text = '';
                                    } else {
                                      controller.openSearchBox.value = 1;
                                      controller.selectedLocation.value =
                                          'Place';
                                      controller.customText.value =
                                          'Your Business is in a Specific Place.';
                                      controller.checkColor.value = 3;
                                    }
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                        Column(
                          children: [
                            // _locationPageController.selectedLocation.value.isEmpty
                            //     ? Container()
                            //     : _footerHint(),
                            _footerHint(),
                            controller.openSearchBox.value == 1
                                ? searchBox()
                                : Container(),
                            const SizedBox(height: 20),
                            controller.openSearchBox.value == 1
                                ? googleMap()
                                : Container(),
                          ],
                        ),
                        isKeyboardOpen == true
                            ? SizedBox(
                                height: SizeConfig.getSize100(
                                        context: context) +
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
                ),
              ],
            ),
            CustomAppbarWithWhiteBg(
              title: TextStrings.textKey['filter_pitch']!,
              backCheckBio: 'back',
              backOnTap: () {
                controller.finalSelectedData['location'] = null;
                Navigator.of(context).pop();
              },
              onPressad: () {
                PageNavigateScreen().push(
                    context,
                    ManuPage(
                      title: TextStrings.textKey['filter_pitch']!,
                      pageIndex: 1,
                      isManu: 'Manu',
                    ));
              },
            ),
            controller.selectedLocation.value.isNotEmpty
                ? doneButton()
                : Container(),
            NewCustomBottomBar(
              index: 1,
              isBack: true,
            ),
          ],
        ),
      ),
    );
  }

  Widget doneButton() {
    return Padding(
      padding: EdgeInsets.only(
          bottom: SizeConfig.getSize30(context: context) +
              SizeConfig.getSize55(context: context) +
              SizeConfig.getSize5(context: context),
          right: SizeConfig.getFontSize25(context: context)),
      child: Align(
          alignment: Alignment.bottomRight,
          child: AppBarIconContainer(
            height: SizeConfig.getSize38(context: context),
            width: SizeConfig.getSize38(context: context),
            color: DynamicColor.green,
            child: Icon(
              Icons.check,
              color: DynamicColor.white,
              size: 30,
            ),
            onTap: () async {
              controller.finalSelectedData['location'] =
                  controller.selectedLocation.value == 'Place'
                      ? controller.searchController.text
                      : controller.selectedLocation.value;
              var s = controller.selectedLocation.value == 'Place'
                  ? controller.searchController.text
                  : controller.selectedLocation.value;
              log(s);
              SharedPreferences prefs = await SharedPreferences.getInstance();
              prefs.setString('location', s);
              prefs.setInt('location_tap', controller.checkColor.value);
              PageNavigateScreen().back(context);
            },
          )),
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
                    child: GooglePlaceAutoCompleteTextField(
                        textEditingController: controller.searchController,
                        googleAPIKey: Keys.googleApiKey,
                        onTap: () {
                          setState(() {
                            isKeyboardOpen = true;
                          });
                          controller.searchController.text = '';
                        },
                        textStyle: gredient116bold,
                        inputDecoration: InputDecoration(
                            hintText: 'Type',
                            hintStyle: TextStyle(
                                fontSize: 15,
                                color: DynamicColor.lightGrey.withOpacity(0.5)),
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
                        currentLatitude: controller.currentLatitude.value,
                        currentLongitude: controller.currentLongitude.value,
                        debounceTime: 0,
                        isLatLngRequired: true,
                        getPlaceDetailWithLatLng: (Prediction prediction) {
                          controller.searchController.text =
                              prediction.description!;
                          log(controller.searchController.text);
                          displayPrediction(prediction);
                        },
                        itmClick: (Prediction prediction) {
                          setState(() {
                            isKeyboardOpen = false;
                          });
                          FocusScope.of(context).requestFocus(FocusNode());
                        })),
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
            onMapCreated: (GoogleMapController controllers) {
              setState(() {
                controllerCompleter.complete(controllers);
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
            elevation: controller.checkColor.value == isCheck ? 0 : 5,
            color: controller.checkColor.value == isCheck
                ? Colors.transparent
                : null,
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
                  color: controller.checkColor.value == isCheck
                      ? Colors.transparent
                      : null,
                  gradient: controller.checkColor.value == isCheck
                      ? null
                      : DynamicColor.gradientColorChange,
                  border: controller.checkColor.value != isCheck
                      ? null
                      : Border.all(color: DynamicColor.gredient1),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(topLeft),
                    bottomLeft: Radius.circular(bottomLeft),
                    topRight: Radius.circular(topRight),
                    bottomRight: Radius.circular(bottomRight),
                  )),
              child: controller.checkColor.value == isCheck
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
  // location

  getCurentPosign() async {
    try {
      location.requestPermission().then((value) {});
      location.getLocation().then((value) {
        if (value != null) {
          setState(() {
            controller.currentLatitude.value = value.latitude!;
            controller.currentLongitude.value = value.longitude!;
            initialLocation = CameraPosition(
              target: LatLng(value.latitude!, value.longitude!),
              zoom: 14.0,
            );

            Timer(Duration(milliseconds: 500), () {
              setState(() {
                markers.add(
                  Marker(
                    markerId: const MarkerId('place'),
                    position:
                        LatLng(value.latitude ?? 0.0, value.longitude ?? 0.0),
                    //infoWindow: InfoWindow(title: element.driverName),
                    icon: BitmapDescriptor.defaultMarker,
                  ),
                );
              });
            });
            getAddress(value.latitude!, value.longitude!);
          });
        }
      });
    } catch (e) {
      location.requestPermission();
    }
  }

  Future<Null> displayPrediction(Prediction p) async {
    try {
      if (p != null) {
        setState(() async {
          markers.clear();
          final lat = double.parse('${p.lat}').toDouble();

          final lng = double.parse('${p.lng}').toDouble();
          controller.placeAddress.value = p.description!;
          controller.placeLatitude.value = double.parse('${p.lat}').toDouble();
          controller.placeLongitude.value = double.parse('${p.lng}').toDouble();
          final GoogleMapController controllers =
              await controllerCompleter.future;
          controllers.animateCamera(CameraUpdate.newCameraPosition(
            CameraPosition(
              target: LatLng(lat.toDouble(), lng.toDouble()),
              zoom: 14.0,
            ),
          ));

          Timer(Duration(milliseconds: 500), () {
            setState(() {
              markers.add(
                Marker(
                  draggable: false,
                  markerId: const MarkerId('place'),
                  position: LatLng(lat.toDouble(), lng.toDouble()),
                  //infoWindow: const InfoWindow(title: 'Find Place'),
                ),
              );
            });
          });
        });
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
      if (controller.searchController.text.isEmpty) {
        controller.searchController.text =
            jsonResponce['results'][0]['formatted_address'];
      }

      setState(() {});
    } catch (e) {
      // log('message = ' + e.toString());
    }
  }
}
