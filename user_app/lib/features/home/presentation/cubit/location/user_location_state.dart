part of 'user_location_cubit.dart';

@immutable
abstract class UserLocationState {}

class UserLocationInitial extends UserLocationState {}
class UserLocationPickup extends UserLocationState {
  final AddressModel? pickUpAddress;
  UserLocationPickup({this.pickUpAddress});
}
class UserLocationDestination extends UserLocationState {
  final AddressModel? destinationAddress;
  UserLocationDestination({this.destinationAddress});
}
