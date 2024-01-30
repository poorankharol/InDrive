abstract class AuthenticationProvider {
  Future<String?> authenticate({String? email,String? password});

  Future<String?> authenticateSilently();

  Future<void> logout();
}
