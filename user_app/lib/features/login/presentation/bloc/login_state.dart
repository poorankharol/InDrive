import 'package:firebase_auth/firebase_auth.dart';

abstract class LoginState {}

class Initial extends LoginState {}

class Loading extends LoginState {}

class Success extends LoginState {
  final User user;

  Success(this.user);
}

class AddUserToDbSuccess extends LoginState {}

class Failed extends LoginState {
  final String error;

  Failed(this.error);
}
