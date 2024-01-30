import 'package:driver_app/features/register/domain/entity/driver_entity.dart';
import 'package:driver_app/features/register/domain/entity/vehicle_entity.dart';
import 'package:driver_app/features/register/domain/usecase/insert_driver_info_usecase.dart';
import 'package:driver_app/features/register/presentation/bloc/register/register_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:driver_app/features/register/domain/usecase/register_usecase.dart';

import '../../../../../common/utils/internet/connectivity.dart';

class RegisterCubit extends Cubit<RegisterState> {
  final RegisterUseCase _registerUseCase;
  final InsertDriverInfoUseCase _insertDriverInfoUseCase;

  RegisterCubit({
    required RegisterUseCase registerUseCase,
    required InsertDriverInfoUseCase insertDriverInfoUseCase,
  })  : _registerUseCase = registerUseCase,
        _insertDriverInfoUseCase = insertDriverInfoUseCase,
        super(Initial());

  Future<void> register({
    required DriverEntity driverEntity,
    required VehicleEntity vehicleEntity,
    required String password,
  }) async {
    emit(Loading());
    try {
      if (await Connectivity.isAvailable) {
        var user = await _registerUseCase(
          SignUpParams(
            email: driverEntity.email!,
            password: password,
          ),
        );
        await _insertDriverInfoUseCase(
          driverEntity.copyWith(id: user.uid),
          vehicleEntity,
        );
        emit(Success(user));
      } else {
        emit(Failed("No Internet Connection."));
      }
    } catch (err) {
      emit(Failed(err.toString()));
    }
  }
}
