import 'package:admin_web_portal/features/users/data/models/user_model.dart';

import '../../domain/repository/user_repository.dart';
import '../datasource/users_remote_data_source.dart';

class UserRepositoryImpl implements UserRepository {
  final UsersRemoteDataSource remoteDataSource;

  const UserRepositoryImpl({
    required this.remoteDataSource,
  });

  @override
  Future<List<UserModel>> getUsers() async {
    return remoteDataSource.getUsers();
  }
}
