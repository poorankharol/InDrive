import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:driver_app/features/login/domain/usercase/sign_out_usecase.dart';
import 'package:driver_app/features/login/presentation/bloc/login_state.dart';

import '../../../../common/utils/internet/connectivity.dart';
import '../../domain/usercase/login_usecase.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginUseCase _loginUseCase;
  final SignOutUseCase _signOutUseCase;

  LoginCubit({
    required LoginUseCase loginUseCase,
    required SignOutUseCase signOutUseCase,
  })  : _loginUseCase = loginUseCase,
        _signOutUseCase = signOutUseCase,
        super(Initial());

  Future<void> login({required String email, required String password}) async {
    emit(Loading());
    try {
      if (await Connectivity.isAvailable) {
        var user = await _loginUseCase(
          LoginParams(email: email, password: password),
        );
        DatabaseReference userRef =
            FirebaseDatabase.instance.ref().child("drivers").child(user.uid);
        userRef.once().then((snapshot) async {
          if (snapshot.snapshot.value != null) {
            if ((snapshot.snapshot.value as Map)['blockStatus'] == false) {
              emit(Success(user));
            } else {
              emit(Failed("Your account is blocked."));
              await _signOutUseCase();
            }
          }
        });
      } else {
        emit(Failed("No Internet Connection."));
      }
    } catch (err) {
      emit(Failed(err.toString()));
    }
  }
}
