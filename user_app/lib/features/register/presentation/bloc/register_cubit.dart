import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_app/features/register/domain/usecase/register_usecase.dart';
import 'package:user_app/features/register/presentation/bloc/register_state.dart';

import '../../../../common/utils/internet/connectivity.dart';

class RegisterCubit extends Cubit<RegisterState> {
  final RegisterUseCase _registerUseCase;

  RegisterCubit({
    required RegisterUseCase registerUseCase,
  })  : _registerUseCase = registerUseCase,
        super(Initial());

  Future<void> register(
      {required String email, required String password}) async {
    emit(Loading());
    try {
      if (await Connectivity.isAvailable) {
        var user = await _registerUseCase(
          SignUpParams(email: email, password: password),
        );
        emit(Success(user));
      } else {
        emit(Failed("No Internet Connection."));
      }
    } catch (err) {
      emit(Failed(err.toString()));
    }
  }

  Future<void> insertIntoDatabase({
    required User user,
    required String name,
    required String phone,
    required bool blockStatus,
  }) async {
    emit(Loading());
    DatabaseReference userRef =
        FirebaseDatabase.instance.ref().child("users").child(user.uid);
    Map userMap = {
      "name": name,
      "email": user.email,
      "phone": phone,
      "id": user.uid,
      "blockStatus": blockStatus
    };
    userRef.set(userMap);

    emit(AddUserToDbSuccess());
  }
}
