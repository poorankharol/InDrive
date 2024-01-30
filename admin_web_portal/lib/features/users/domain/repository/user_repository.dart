import 'package:admin_web_portal/features/users/data/models/user_model.dart';

abstract class UserRepository {
  Future<List<UserModel>> getUsers();
}
