import 'package:firebase_auth/firebase_auth.dart';

import '../../../../common/firebase/data_sources/auth_remote_data_source.dart';
import '../../domain/repository/login_repository.dart';

class LoginRepositoryImpl implements LoginRepository {
  final AuthRemoteDataSource remoteDataSource;

  const LoginRepositoryImpl({
    required this.remoteDataSource,
  });

  @override
  Stream<User?> get authUser {
    return remoteDataSource.user;
  }

  @override
  Future<User> login({
    required String email,
    required String password,
  }) async {
    final authModel = await remoteDataSource.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    return authModel;
  }

  @override
  Future<void> signOut() async {
    await remoteDataSource.signOut();
  }
}
