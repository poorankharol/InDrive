import 'dart:io';

import 'package:admin_web_portal/features/drivers/data/models/driver_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class DatabaseRemoteDataSource {
  Future<List<DriverModel>> getDrivers();
}
