import 'package:admin_web_portal/features/users/domain/usecase/get_user_usecase.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../data/models/user_model.dart';

part 'users_state.dart';

class UsersCubit extends Cubit<UsersState> {
  final GetUserUseCase _getUserUseCase;

  UsersCubit({required GetUserUseCase getUserUseCase})
      : _getUserUseCase = getUserUseCase,
        super(UsersInitial());

  Future<void> getUsers() async {
    emit(UsersLoading());
    try {
      //if (await Connectivity.isAvailable) {
      var users = await _getUserUseCase();
      emit(UsersSuccess(users));
      //} else {
      //  emit(UsersFailed("No Internet Connection."));
      //}
    } catch (e) {
      emit(UsersFailed(e.toString()));
    }
  }
}
