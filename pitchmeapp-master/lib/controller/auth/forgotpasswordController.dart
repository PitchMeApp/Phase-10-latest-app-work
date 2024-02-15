import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:pitch_me_app/core/apis/authApis.dart';
import 'package:pitch_me_app/screens/auth/linkSentScreen.dart';
import 'package:pitch_me_app/utils/extras/extras.dart';
import 'package:pitch_me_app/utils/widgets/extras/loading.dart';

class ForgotPasswordController extends GetxController {
  TextEditingController txtEmail = TextEditingController(),
      txtUserName = TextEditingController(),
      txtPassword = TextEditingController(),
      txtConfirmPassword = TextEditingController();
  FocusNode emailNode = FocusNode(),
      userNameNode = FocusNode(),
      passwordNode = FocusNode(),
      confirmPasswordNode = FocusNode();

  final count = 0.obs;

  AuthApis authApis = AuthApis();

  bool validate(context) {
    if (txtEmail.text.isEmpty) {
      myToast(context, msg: 'Email is required');
      return false;
    }
    if (GetUtils.isEmail(txtEmail.text) == false) {
      myToast(context, msg: 'Please enter correct email');
      return false;
    }
    return true;
  }

  submit(context) async {
    if (validate(context)) {
      Get.dialog(Loading());
      bool? result =
          await authApis.sendEmail(context, email: txtEmail.text, type: 2);
      Get.back();
      if (result != null) {
        Get.to(() => LinkSentScreen());
      }
    }
  }
}

class ForgotPasswordBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ForgotPasswordController>(
      () => ForgotPasswordController(),
    );
  }
}
