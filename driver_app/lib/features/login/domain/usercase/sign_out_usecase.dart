
import '../repository/login_repository.dart';

class SignOutUseCase {
  final LoginRepository authRepository;

  SignOutUseCase({required this.authRepository});

  Future<void> call() async {
    try {
      await authRepository.signOut();
    } catch (error) {
      throw Exception(error);
    }
  }
}
