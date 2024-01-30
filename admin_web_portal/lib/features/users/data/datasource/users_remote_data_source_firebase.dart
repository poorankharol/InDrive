import 'package:admin_web_portal/features/drivers/data/models/driver_model.dart';
import 'package:firebase_database/firebase_database.dart';
import '../models/user_model.dart';
import 'users_remote_data_source.dart';

class UsersRemoteDataSourceFirebase implements UsersRemoteDataSource {
  UsersRemoteDataSourceFirebase({
    FirebaseDatabase? firebaseDatabase,
  }) : _firebaseDatabase = firebaseDatabase ?? FirebaseDatabase.instance;

  final FirebaseDatabase _firebaseDatabase;

  @override
  Future<List<UserModel>> getUsers() async {
    DatabaseReference driversRef = _firebaseDatabase.ref().child("users");
    DatabaseEvent snapshot = await driversRef.once();
    if (snapshot.snapshot.exists) {
      Map value = snapshot.snapshot.value as Map;
      List<UserModel> urerList =
          value.values.map((e) => UserModel.fromJson(e)).toList();
      return urerList;
    } else {
      return []; // Return an empty list if no data exists
    }
  }
}
