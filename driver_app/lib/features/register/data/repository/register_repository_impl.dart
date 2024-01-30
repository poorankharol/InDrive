import 'package:driver_app/features/register/data/models/driver_model.dart';
import 'package:driver_app/features/register/data/models/vehicle_model.dart';
import 'package:driver_app/features/register/domain/entity/driver_entity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

import '../../../../common/firebase/data_sources/auth_remote_data_source.dart';
import '../../domain/entity/vehicle_entity.dart';
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

  @override
  Future<void> insertDriverInfo(
      {required DriverEntity driver,
      required VehicleEntity vehicleEntity}) async {
    User? user = await remoteDataSource.user.first;

    DatabaseReference userRef =
        FirebaseDatabase.instance.ref().child("drivers").child(user!.uid);

    final vehicleMap = VehicleModel(
      carModel: vehicleEntity.carModel,
      carColor: vehicleEntity.carColor,
      carNumber: vehicleEntity.carNumber,
    ).toDocument();

    final driverMap = DriverModel(
            email: driver.email,
            photo: driver.photo,
            phone: driver.phone,
            blockStatus: driver.blockStatus,
            id: driver.id,
            name: driver.name,
            vehicleEntity: vehicleMap)
        .toDocument();

    userRef.set(driverMap);
  }
}
