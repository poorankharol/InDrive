import '../enum/authentication_type.dart';

abstract class AuthenticationManager{
  Future<bool> authenticateUser(AuthenticationType authenticationType);
  Future<String?> authenticateSilently(AuthenticationType authenticationType);
  Future<bool> logout();
}
