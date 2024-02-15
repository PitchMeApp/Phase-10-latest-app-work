import 'package:get/get.dart';

class TutorialController extends GetxController {
  RxList tutorialList = [
    {
      'url': 'https://d2vaqd2kfxjiiz.cloudfront.net/pitchme/homepage.mp4',
      'name': 'Home',
    },
    {
      'url':
          'https://soop1.s3.ap-south-1.amazonaws.com/pitchme/watchsalespage.mp4',
      'name': 'Watch Sales Pitch',
    },
    {
      'url': 'https://d2vaqd2kfxjiiz.cloudfront.net/pitchme/addtutorial.mp4',
      'name': 'Add Sales Pitch',
    },
    {
      'url': 'https://soop1.s3.ap-south-1.amazonaws.com/pitchme/pptutorial.mp4',
      'name': 'Profile',
    },
  ].obs;
}
