import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:user_app/features/home/data/models/address_model.dart';

part 'user_end_location_state.dart';

class UserEndLocationCubit extends Cubit<UserEndLocationState> {
  AddressModel? destination;
  UserEndLocationCubit() : super(UserEndLocationInitial());

  void updateDestinationLocation(AddressModel addressModel) {
    destination = addressModel;
    emit(UserEndLocation(destinationAddress: addressModel));
  }
}
