import 'package:admin_web_portal/features/drivers/data/models/driver_model.dart';

import '../../domain/repository/driver_repository.dart';
import '../datasource/database_remote_data_source.dart';

class DriverRepositoryImpl implements DriverRepository {
  final DatabaseRemoteDataSource remoteDataSource;

  const DriverRepositoryImpl({
    required this.remoteDataSource,
  });

  @override
  Future<List<DriverModel>> getDrivers() async {
    return remoteDataSource.getDrivers();
  }
}
