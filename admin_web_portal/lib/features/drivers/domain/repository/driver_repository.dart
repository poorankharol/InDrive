import 'package:admin_web_portal/features/drivers/data/models/driver_model.dart';

abstract class DriverRepository{
  Future<List<DriverModel>> getDrivers();
}