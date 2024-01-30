import 'package:driver_app/features/register/domain/entity/driver_entity.dart';
import 'package:driver_app/features/register/domain/entity/vehicle_entity.dart';

import '../repository/register_repository.dart';

class InsertDriverInfoUseCase {
  final RegisterRepository authRepository;

  InsertDriverInfoUseCase({required this.authRepository});

  Future<void> call(DriverEntity driver,VehicleEntity vehicleEntity) async {
    try {
      await authRepository.insertDriverInfo(driver: driver,vehicleEntity: vehicleEntity);
    } on ArgumentError catch (error) {
      throw Exception(error);
    } catch (error) {
      throw Exception(error);
    }
  }
}
