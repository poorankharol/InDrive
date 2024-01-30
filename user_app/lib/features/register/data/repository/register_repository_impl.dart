import 'package:firebase_auth/firebase_auth.dart';

import '../../../../common/firebase/data_sources/auth_remote_data_source.dart';
import '../../domain/repository/register_repository.dart';

class RegisterRepositoryImpl implements RegisterRepository {
  final AuthRemoteDataSource remoteDataSource;

  const RegisterRepositoryImpl({
    required this.remoteDataSource,
  });

  @override
  Stream<User?> get authUser {
    return remoteDataSource.user;
  }

  @override
  Future<User> register({
    required String email,
    required String password,
  }) async {
    final authModel = await remoteDataSource.signUpWithEmailAndPassword(
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
