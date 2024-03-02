import 'package:get/get.dart';

class TutorialController extends GetxController {
  RxList tutorialList = [
    {
      'url': 'https://soop1.s3.ap-south-1.amazonaws.com/pitchme/homepage.mp4',
      'name': 'Home',
    },
    {
      'url':
          'https://soop1.s3.ap-south-1.amazonaws.com/pitchme/watchsalespage.mp4',
      'name': 'Watch Sales Pitch',
    },
    {
      'url':
          'https://soop1.s3.ap-south-1.amazonaws.com/pitchme/addtutorial.mp4',
      'name': 'Add Sales Pitch',
    },
    {
      'url': 'https://soop1.s3.ap-south-1.amazonaws.com/pitchme/pptutorial.mp4',
      'name': 'Profile',
    },
  ].obs;
}
