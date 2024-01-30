import '../authentication/enum/authentication_type.dart';

abstract class TokenManager {
  Future<void> saveTokenSecurely(String token,AuthenticationType authenticationType);

  Future<String?> getSecurelyStoredToken();
}
