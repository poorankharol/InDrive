part of 'user_end_location_cubit.dart';

@immutable
abstract class UserEndLocationState {}

class UserEndLocationInitial extends UserEndLocationState {}
class UserEndLocation extends UserEndLocationState {
  final AddressModel? destinationAddress;
  UserEndLocation({this.destinationAddress});
}
