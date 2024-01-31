part of 'directions_cubit.dart';

@immutable
abstract class DirectionsState {}

class DirectionsInitial extends DirectionsState {}

class DirectionsLoading extends DirectionsState {}

class DirectionsSuccess extends DirectionsState {
  final DirectionsModel directionsModel;

  DirectionsSuccess(this.directionsModel);
}

class DirectionsFailed extends DirectionsState {
  final String error;

  DirectionsFailed(this.error);
}
