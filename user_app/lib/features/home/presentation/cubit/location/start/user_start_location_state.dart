part of 'user_start_location_cubit.dart';

@immutable
abstract class UserStartLocationState {}

class UserStartLocationInitial extends UserStartLocationState {}
class UserStartLocation extends UserStartLocationState {
  final AddressModel? pickUpAddress;
  UserStartLocation({this.pickUpAddress});
}
