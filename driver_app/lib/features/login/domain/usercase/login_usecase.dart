import 'package:firebase_auth/firebase_auth.dart';

import '../repository/login_repository.dart';


class LoginUseCase {
  final LoginRepository authRepository;

  LoginUseCase({required this.authRepository});

  Future<User> call(LoginParams params) async {
    try {
      User authUser = await authRepository.login(
        email: params.email,
        password: params.password,
      );
      return authUser;
    } on ArgumentError catch (error) {
      throw Exception(error);
    } catch (error) {
      throw Exception(error);
    }
  }
}

class LoginParams {
  final String email;
  final String password;

  LoginParams({
    required this.email,
    required this.password,
  });
}
