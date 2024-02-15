import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class LocationPageController extends GetxController
    with WidgetsBindingObserver {
  Location location = Location();
  Completer<GoogleMapController> controllerCompleter = Completer();
  TextEditingController searchController = TextEditingController();

  RxSet<Marker> markers = <Marker>{}.obs;
  CameraPosition initialLocation =
      const CameraPosition(target: LatLng(0.0, 0.0));

  double currentLatitude = 0.0;
  double currentLongitude = 0.0;
  double placeLatitude = 0.0;
  double placeLongitude = 0.0;

  RxString placeAddress = ''.obs;
  RxString selectedType = ''.obs;
  RxString customText = ''.obs;

  // getCurentPosign() async {
  //   try {
  //     location.requestPermission().then((value) {});
  //     location.getLocation().then((value) {
  //       if (value != null) {
  //         currentLatitude = value.latitude!;
  //         currentLongitude = value.longitude!;
  //         initialLocation = CameraPosition(
  //           target: LatLng(value.latitude!, value.longitude!),
  //           zoom: 14.0,
  //         );

  //         markers.add(
  //           Marker(
  //             markerId: const MarkerId('place'),
  //             position: LatLng(value.latitude ?? 0.0, value.longitude ?? 0.0),
  //             //infoWindow: InfoWindow(title: element.driverName),
  //             icon: BitmapDescriptor.defaultMarker,
  //           ),
  //         );
  //         getAddress(value.latitude!, value.longitude!);
  //       }
  //     });
  //   } catch (e) {
  //     location.requestPermission();
  //   }
  // }

  // Future<Null> displayPrediction(Prediction p) async {
  //   try {
  //     if (p != null) {
  //       markers.clear();
  //       final lat = double.parse('${p.lat}').toDouble();

  //       final lng = double.parse('${p.lng}').toDouble();
  //       placeAddress.value = p.description!;
  //       placeLatitude = double.parse('${p.lat}').toDouble();
  //       placeLongitude = double.parse('${p.lng}').toDouble();
  //       final GoogleMapController controller = await controllerCompleter.future;
  //       controller.animateCamera(CameraUpdate.newCameraPosition(
  //         CameraPosition(
  //           target: LatLng(lat.toDouble(), lng.toDouble()),
  //           zoom: 14.0,
  //         ),
  //       ));

  //       markers.add(
  //         Marker(
  //           draggable: false,
  //           markerId: const MarkerId('place'),
  //           position: LatLng(lat.toDouble(), lng.toDouble()),
  //           //infoWindow: const InfoWindow(title: 'Find Place'),
  //         ),
  //       );
  //       update();
  //     }
  //   } catch (e) {
  //     log('location = ' + e.toString());
  //   }
  // }

  // void getAddress(lat, lang) async {
  //   try {
  //     String url =
  //         'https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$lang&key=${Keys.googleApiKey}';

  //     var response = await http.get(Uri.parse(url));
  //     var jsonResponce = jsonDecode(response.body.toString());

  //     searchController.text = jsonResponce['results'][0]['formatted_address'];
  //   } catch (e) {
  //     log('message = ' + e.toString());
  //   }
  // }

  // void onMapDispose() async {
  //   final GoogleMapController controller = await controllerCompleter.future;
  //   controller.dispose();
  //   log('dispose');
  // }

  // @override
  // void onInit() {
  //   WidgetsBinding.instance.addObserver(this);
  //   getCurentPosign();

  //   super.onInit();
  // }

  // @override
  // void onClose() {
  //   super.onClose();
  //   WidgetsBinding.instance.removeObserver(this);
  // }

  // @override
  // void dispose() {
  //   // onMapDispose();
  //   //searchController.text = '';
  //   markers.clear();

  //   super.dispose();
  // }
}
