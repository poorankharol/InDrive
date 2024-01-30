part of 'drivers_cubit.dart';

@immutable
abstract class DriversState {}

class DriversInitial extends DriversState {}
class DriversLoading extends DriversState {}
class DriversSuccess extends DriversState {
  final List<DriverModel> driverList;

  DriversSuccess(this.driverList);
}
class DriversFailed extends DriversState {
  final String error;

  DriversFailed(this.error);
}
