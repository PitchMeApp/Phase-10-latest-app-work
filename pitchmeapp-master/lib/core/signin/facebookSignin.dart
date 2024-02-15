import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

Future<UserCredential?> signInWithFacebook() async {
  try {
    // Trigger the sign-in flow
    await FacebookAuth.instance.logOut();
    final LoginResult loginResult = await FacebookAuth.instance.login();

    // Create a credential from the access token
    print("Login result =${loginResult.accessToken}");
    print("Before facebook auth");
    final OAuthCredential facebookAuthCredential =
        FacebookAuthProvider.credential(loginResult.accessToken!.token);

    // Once signed in, return the UserCredential
    return FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
  } catch (e) {
    print('error = ' + e.toString());
    //myToast(msg: 'Error at fb ${e.toString()}');
    //return null;
  }
  return null;
}
