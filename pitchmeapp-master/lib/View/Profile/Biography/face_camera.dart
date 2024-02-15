// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pitch_me_app/View/Profile/Biography/controller/controller.dart';
import 'package:pitch_me_app/utils/colors/colors.dart';

class FaceCameraPage extends StatefulWidget {
  const FaceCameraPage({Key? key}) : super(key: key);

  @override
  _FaceCameraPageState createState() => _FaceCameraPageState();
}

class _FaceCameraPageState extends State<FaceCameraPage> {
  GlobalKey<FormState> abcKey = GlobalKey<FormState>();
  final BiographyController controller = Get.put(BiographyController());
  bool _isLoading = true;

  late CameraController _cameraController;

  late List<CameraDescription> _availableCameras;

  @override
  void initState() {
    _getAvailableCameras();

    super.initState();
  }

  @override
  void dispose() {
    _cameraController.dispose();

    super.dispose();
  }

  // get available cameras
  Future<void> _getAvailableCameras() async {
    WidgetsFlutterBinding.ensureInitialized();
    _availableCameras = await availableCameras();
    _initCamera(_availableCameras.reversed.first);
    if (Platform.isIOS) {
      _toggleCameraLens();
    }
  }

  // init camera
  Future<void> _initCamera(CameraDescription description) async {
    _cameraController = CameraController(
        description, ResolutionPreset.ultraHigh,
        enableAudio: false);

    try {
      await _cameraController.initialize();

      setState(() => _isLoading = false);
    } catch (e) {
      print('camera = ' + e.toString());
    }
  }

  void takePicture() async {
    final image = await _cameraController.takePicture();
    controller.fackCheckImagePath = File(image.path);
    if (image.path.isNotEmpty) {
      Navigator.of(context).pop();
    }
  }

  void _toggleCameraLens() {
    // get current lens direction (front / rear)
    final lensDirection = _cameraController.description.lensDirection;
    CameraDescription newDescription;
    if (lensDirection == CameraLensDirection.front) {
      newDescription = _availableCameras.firstWhere((description) =>
          description.lensDirection == CameraLensDirection.front);
    } else {
      newDescription = _availableCameras.firstWhere((description) =>
          description.lensDirection == CameraLensDirection.front);
    }

    if (newDescription != null) {
      _initCamera(newDescription);
    } else {
      print('Asked camera not available');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Container(
        color: Colors.white,
        child: const Center(
          child: CircularProgressIndicator(
            color: DynamicColor.gredient1,
          ),
        ),
      );
    } else {
      return Column(
        children: [
          Expanded(child: CameraPreview(_cameraController)),
          Container(
              width: double.infinity,
              color: DynamicColor.white,
              child: Align(
                alignment: Alignment.center,
                child: Container(
                  padding: const EdgeInsets.all(15),
                  child: FloatingActionButton(
                    heroTag: 1,
                    backgroundColor: Colors.red,
                    child: Icon(Icons.camera_alt),
                    onPressed: () {
                      takePicture();
                    },
                  ),
                ),
              )),
        ],
      );
    }
  }
}
