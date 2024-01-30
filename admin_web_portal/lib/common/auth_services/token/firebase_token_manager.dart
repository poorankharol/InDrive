import 'package:firebase_auth/firebase_auth.dart';

sealed class FirebaseTokenManager{
  static Future<String?> refreshToken() async {
    String? refreshedToken;
    await FirebaseAuth.instance.currentUser
        ?.getIdTokenResult(true)
        .then((value) async {
      refreshedToken = value.token;
    });
    return refreshedToken;
  }

}
