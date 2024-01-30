import 'package:user_app/features/home/data/datasource/user_remote_data_source.dart';
import 'package:user_app/features/home/data/models/user_model.dart';
import 'package:user_app/features/home/domain/repository/home_repository.dart';

import '../../../../common/firebase/data_sources/auth_remote_data_source.dart';

class HomeRepositoryImpl implements HomeRepository {
  final AuthRemoteDataSource remoteDataSource;
  final UserRemoteDataSource userRemoteDataSource;

  const HomeRepositoryImpl({
    required this.remoteDataSource,
    required this.userRemoteDataSource,
  });

  @override
  Future<UserModel?> getUser() async {
    return await userRemoteDataSource.getUser();
  }

  @override
  Future<void> signOut() async {
    await remoteDataSource.signOut();
  }
}
