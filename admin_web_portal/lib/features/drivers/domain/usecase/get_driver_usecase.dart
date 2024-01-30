import 'package:admin_web_portal/features/drivers/data/models/driver_model.dart';
import 'package:admin_web_portal/features/drivers/domain/repository/driver_repository.dart';

class GetDriverUseCase {
  final DriverRepository driverRepository;

  GetDriverUseCase({required this.driverRepository});

  Future<List<DriverModel>> call() async {
    try {
      var data = await driverRepository.getDrivers();
      return data;
    } on ArgumentError catch (error) {
      throw Exception(error);
    } catch (error) {
      throw Exception(error);
    }
  }
}
