// ignore_for_file: constant_identifier_names
enum AuthenticationType {
  // cases
  B2C('b2c'),
  Google('google'),
  Apple('apple'),
  Email('email');

  final String type;
  const AuthenticationType(this.type);
}

extension ConvertLogin on String {
  AuthenticationType toAuthenticationType() {
    switch (this) {
      case 'b2c':
        return AuthenticationType.B2C;
      case 'google':
        return AuthenticationType.Google;
      case 'apple':
        return AuthenticationType.Apple;
      case 'email':
        return AuthenticationType.Email;
      default:
        return AuthenticationType.B2C;
    }
  }
}
