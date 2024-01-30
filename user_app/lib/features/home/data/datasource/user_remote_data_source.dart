import 'package:user_app/features/home/data/models/user_model.dart';

abstract class UserRemoteDataSource{
  Future<UserModel?> getUser();
}