import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:pitch_me_app/core/apis/authApis.dart';
import 'package:pitch_me_app/models/auth/registerDataModel.dart';
import 'package:pitch_me_app/utils/extras/extras.dart';
import 'package:pitch_me_app/utils/widgets/extras/loading.dart';

import '../../models/auth/userLoginModel.dart';
import '../../screens/businessIdeas/emailConfirm.dart';

class SignupController extends GetxController {
  TextEditingController txtEmail = TextEditingController(),
      txtUserName = TextEditingController(),
      txtPassword = TextEditingController(),
      txtConfirmPassword = TextEditingController();
  FocusNode emailNode = FocusNode(),
      userNameNode = FocusNode(),
      passwordNode = FocusNode(),
      confirmPasswordNode = FocusNode();

  final count = 0.obs;
  var agree = false.obs;
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
    if (txtUserName.text.isEmpty) {
      myToast(context, msg: 'Username is required');
      return false;
    }
    if (txtPassword.text.isEmpty) {
      myToast(context, msg: 'Password is required');
      return false;
    }
    if (txtConfirmPassword.text.isEmpty) {
      myToast(context, msg: 'Confirm Password is required');
      return false;
    }
    if (txtPassword.text.length < 6) {
      myToast(context, msg: 'Password should be 6 characters long');
      return false;
    }
    if (txtConfirmPassword.text.length < 6) {
      myToast(context, msg: 'Confirm Password should be 6 characters long');
      return false;
    }

    if (txtConfirmPassword.text != txtPassword.text) {
      myToast(context, msg: "Password doesn't matched");
      return false;
    }
    if (!agree.value) {
      myToast(context, msg: 'Please accept terms and conditions');
      return false;
    }
    return true;
  }

  submit(context) async {
    if (validate(context)) {
      Get.dialog(Loading());
      try {
        RegisterDataModel registerDataModel = RegisterDataModel(
          email: txtEmail.text,
          name: txtUserName.text,
          confirmPass: txtConfirmPassword.text,
          password: txtPassword.text,
        );

        UserLoginModel? result = await authApis.register(context,
            registerDataModel: registerDataModel);
        if (result != null) {
          await authApis.sendEmail(context,
              email: registerDataModel.email!, type: 1);
          Get.back();
          Get.to(() => Email_screen());
        } else {
          Get.back();
        }
      } catch (e) {
        Get.back();
      }
    }
  }
}

class SignUpBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SignupController>(
      () => SignupController(),
    );
  }
}
