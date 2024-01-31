import 'package:user_app/features/home/data/models/directions_model.dart';

import '../../data/models/user_model.dart';

abstract class HomeRepository {
  Future<UserModel?> getUser();
  Future<void> signOut();
  Future<DirectionsModel> getDirections(String origin,String destination);
}
