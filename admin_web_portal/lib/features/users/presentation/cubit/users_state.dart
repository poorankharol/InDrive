part of 'users_cubit.dart';

@immutable
abstract class UsersState {}

class UsersInitial extends UsersState {}
class UsersLoading extends UsersState {}
class UsersSuccess extends UsersState {
  final List<UserModel> userList;

  UsersSuccess(this.userList);
}
class UsersFailed extends UsersState {
  final String error;

  UsersFailed(this.error);
}
