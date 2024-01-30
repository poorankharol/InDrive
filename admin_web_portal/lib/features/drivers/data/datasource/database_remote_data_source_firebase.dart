import 'package:admin_web_portal/features/drivers/data/models/driver_model.dart';
import 'package:firebase_database/firebase_database.dart';
import 'database_remote_data_source.dart';

class DatabaseRemoteDataSourceFirebase implements DatabaseRemoteDataSource {
  DatabaseRemoteDataSourceFirebase({
    FirebaseDatabase? firebaseDatabase,
  }) : _firebaseDatabase = firebaseDatabase ?? FirebaseDatabase.instance;

  final FirebaseDatabase _firebaseDatabase;

  @override
  Future<List<DriverModel>> getDrivers() async {
    DatabaseReference driversRef = _firebaseDatabase.ref().child("drivers");
    DatabaseEvent snapshot = await driversRef.once();
    if (snapshot.snapshot.exists) {
      Map value = snapshot.snapshot.value as Map;
      List<DriverModel> driverList = value.values
          .map((e) => DriverModel.fromJson(e))
          .toList();
      return driverList;
    } else {
      return []; // Return an empty list if no data exists
    }
  }
}
