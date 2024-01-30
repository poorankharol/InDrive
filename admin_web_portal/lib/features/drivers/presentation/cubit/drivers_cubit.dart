import 'package:admin_web_portal/features/drivers/domain/usecase/get_driver_usecase.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../common/utils/internet/connectivity.dart';
import '../../data/models/driver_model.dart';

part 'drivers_state.dart';

class DriversCubit extends Cubit<DriversState> {
  final GetDriverUseCase _getDriverUseCase;

  DriversCubit({required GetDriverUseCase getDriverUseCase})
      : _getDriverUseCase = getDriverUseCase,
        super(DriversInitial());

  Future<void> getDrivers() async {
    emit(DriversLoading());
    try {
      //if (await Connectivity.isAvailable) {
        var drivers = await _getDriverUseCase();
        emit(DriversSuccess(drivers));
      //} else {
      //  emit(DriversFailed("No Internet Connection."));
      //}
    } catch (e) {
      emit(DriversFailed(e.toString()));
    }
  }
}
