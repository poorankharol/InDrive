import 'package:firebase_auth/firebase_auth.dart';

import '../repository/register_repository.dart';

class RegisterUseCase {
  final RegisterRepository authRepository;

  RegisterUseCase({required this.authRepository});

  Future<User> call(SignUpParams params) async {
    try {
      User authUser = await authRepository.register(
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

class SignUpParams {
  final String email;
  final String password;

  SignUpParams({
    required this.email,
    required this.password,
  });
}
