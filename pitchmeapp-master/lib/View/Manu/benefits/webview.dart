import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:pitch_me_app/View/Manu/benefits/payment_faild.dart';
import 'package:pitch_me_app/View/Manu/benefits/payment_success.dart';
import 'package:pitch_me_app/devApi%20Service/get_api.dart';
import 'package:pitch_me_app/utils/extras/extras.dart';
import 'package:pitch_me_app/utils/widgets/Navigation/custom_navigation.dart';

class WebViewPage extends StatefulWidget {
  String webUrl;
  String clientKey;
  String publickKey;
  WebViewPage({
    super.key,
    required this.webUrl,
    required this.clientKey,
    required this.publickKey,
  });

  @override
  State<WebViewPage> createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  final GlobalKey webViewKey = GlobalKey();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //'https://salespitchapp.com/paymentsuccess.html'
    return InAppWebView(
      key: webViewKey,
      initialUrlRequest: URLRequest(url: Uri.parse(widget.webUrl)),
      onLoadStart: (InAppWebViewController controller, url) {
        print('retrn = ' + url!.path.toString());
        // print('message 1 ' + url.origin);
        // print('message 2 ' + url.host);
        // print('message 3 ' + url.authority);
        setState(() {});

        if (url.path == "/paymentsuccess.html") {
          myToast(context, msg: 'Processing done');
          checkPaymentApi();
          // controller.goBack();
        } else if (url.path.contains('redirectmembership')) {
          myToast(context, msg: 'Processing done');
          checkPaymentApi();
        } else if (url.path == "/paymentfailure.html") {
          myToast(context, msg: 'Processing faild');
          controller.goBack();
          PageNavigateScreen().normalpushReplesh(context, PaymentFaildPage());
        } else if (url.path == "/api/acceptance/post_pay") {
          myToast(context, msg: 'Processing pending');
          //  checkPaymentApi();
        } else {}
      },
    );
  }

  Future<void> checkPaymentApi() async {
    try {
      await GetApiService()
          .getStatusApi(
              widget.publickKey.toString(), widget.clientKey.toString())
          .then((value) {
        print('message 1 = ' + value.toString());
        if (value["id"] != null) {
          myToast(context, msg: 'Membership under updation');
          updateMembershipApi();
        } else {
          updateMembershipApi();
          // myToast(context, msg: 'Updation Failed');
        }
      });
      // var tempData = json.decode(res);
    } catch (e) {
      print('status error = ' + e.toString());
    }
  }

  Future<void> updateMembershipApi() async {
    try {
      await GetApiService().updateMembershipApi().then((value) {
        print('message 3 = ' + value.toString());
        if (value["message"] == "User has been successfully updated") {
          myToast(context, msg: 'Membership updated');
          PageNavigateScreen().normalpushReplesh(context, PaymentSuccessPage());
          //  PageNavigateScreen().pushRemovUntil(context, Floatbar(0));
        } else {
          myToast(context, msg: 'Membership faild to update');
        }
      });
      // var tempData = json.decode(res);
    } catch (e) {
      print('member error = ' + e.toString());
    }
  }

  @override
  void dispose() {
    super.dispose();
  }
}
