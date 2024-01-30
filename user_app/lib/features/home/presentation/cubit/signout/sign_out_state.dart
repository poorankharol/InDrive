part of 'sign_out_cubit.dart';

@immutable
abstract class SignOutState {}

class SignOutInitial extends SignOutState {}
class SignOutLoading extends SignOutState {}
class SignOutSuccess extends SignOutState {}
class SignOutFailed extends SignOutState {
  final String error;

  SignOutFailed(this.error);
}
