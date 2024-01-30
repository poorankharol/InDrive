import 'package:firebase_auth/firebase_auth.dart';

abstract class RegisterState {}

class Initial extends RegisterState {}

class Loading extends RegisterState {}

class Success extends RegisterState {
  final User user;

  Success(this.user);
}

class AddUserToDbSuccess extends RegisterState {}

class Failed extends RegisterState {
  final String error;

  Failed(this.error);
}

