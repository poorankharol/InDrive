import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:user_app/features/home/data/models/user_model.dart';
import 'package:user_app/features/home/domain/usecase/get_user_usecase.dart';

import '../../../../../common/utils/internet/connectivity.dart';

part 'get_user_state.dart';

class GetUserCubit extends Cubit<GetUserState> {
  final GetUserUseCase _getUserUseCase;

  GetUserCubit({
    required GetUserUseCase getUserUseCase,
  })  : _getUserUseCase = getUserUseCase,
        super(GetUserInitial());

  Future<void> getUser() async {
    emit(GetUserLoading());
    try {
      if (await Connectivity.isAvailable) {
        var user = await _getUserUseCase();
        emit(GetUserSuccess(user));
      } else {
        emit(GetUserFailed("No Internet Connection."));
      }
    } catch (err) {
      emit(GetUserFailed(err.toString()));
    }
  }
}
