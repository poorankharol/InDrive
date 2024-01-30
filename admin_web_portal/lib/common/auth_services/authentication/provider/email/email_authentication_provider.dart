import 'package:firebase_auth/firebase_auth.dart';

import '../../../token/firebase_token_manager.dart';
import '../authentication_provider.dart';

class EmailAuthenticationProvider implements AuthenticationProvider {
  @override
  Future<String?> authenticateSilently() async {
    return FirebaseTokenManager.refreshToken();
  }

  @override
  Future<void> logout() async {
    FirebaseAuth.instance.signOut();
  }

  @override
  Future<String?> authenticate({String? email, String? password}) async {
    final credentials = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email!, password: password!);

    if (credentials.credential == null) {
      return null;
    }
    return credentials.credential?.accessToken ?? "";
  }
}
