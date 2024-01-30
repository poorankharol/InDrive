import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:user_app/features/login/domain/usercase/sign_out_usecase.dart';

import '../../../../../common/utils/internet/connectivity.dart';

part 'sign_out_state.dart';

class SignOutCubit extends Cubit<SignOutState> {
  final SignOutUseCase _signOutUseCase;

  SignOutCubit({
    required SignOutUseCase signOutUseCase,
  })  : _signOutUseCase = signOutUseCase,
        super(SignOutInitial());

  Future<void> signOut() async {
    emit(SignOutLoading());
    try {
      if (await Connectivity.isAvailable) {
        var user = await _signOutUseCase();
        emit(SignOutSuccess());
      } else {
        emit(SignOutFailed("No Internet Connection."));
      }
    } catch (err) {
      emit(SignOutFailed(err.toString()));
    }
  }
}
