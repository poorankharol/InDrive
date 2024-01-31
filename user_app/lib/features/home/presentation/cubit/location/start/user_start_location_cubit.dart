import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:user_app/features/home/data/models/address_model.dart';

part 'user_start_location_state.dart';

class UserStartLocationCubit extends Cubit<UserStartLocationState> {
  AddressModel? origin;

  UserStartLocationCubit() : super(UserStartLocationInitial());

  void updatePickLocation(AddressModel addressModel) {
    origin = addressModel;
    emit(UserStartLocation(pickUpAddress: addressModel));
  }
}
