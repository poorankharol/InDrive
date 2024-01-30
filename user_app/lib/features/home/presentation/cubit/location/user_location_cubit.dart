import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:user_app/features/home/data/models/address_model.dart';

part 'user_location_state.dart';

class UserLocationCubit extends Cubit<UserLocationState> {
  UserLocationCubit() : super(UserLocationInitial());

  void updatePickLocation(AddressModel addressModel) {
    emit(UserLocationPickup(pickUpAddress: addressModel));
  }

  void updateDestinationLocation(AddressModel addressModel) {
    emit(UserLocationDestination(destinationAddress: addressModel));
  }
}
