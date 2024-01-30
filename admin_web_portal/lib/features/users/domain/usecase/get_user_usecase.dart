import 'package:admin_web_portal/features/users/data/models/user_model.dart';

import '../repository/user_repository.dart';

class GetUserUseCase {
  final UserRepository userRepository;

  GetUserUseCase({required this.userRepository});

  Future<List<UserModel>> call() async {
    try {
      var data = await userRepository.getUsers();
      return data;
    } on ArgumentError catch (error) {
      throw Exception(error);
    } catch (error) {
      throw Exception(error);
    }
  }
}
