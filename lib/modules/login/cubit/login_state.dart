part of 'login_cubit.dart';

@immutable
abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {
  final LoginModel loginModel;

  LoginSuccess(this.loginModel);
}

class LoginError extends LoginState {
  final String error;
  LoginError(this.error);
}

class LoginErrorOnEmailOrPassword extends LoginState {}

//========for change password visibilty========
class LoginChangePasswordVisbilty extends LoginState {}

//========for change password ========
class ChangePasswordLoading extends LoginState {}

class ChangePasswordSuccess extends LoginState {}

class ChangePasswordError extends LoginState {}
class ChangePasswordFailedWrongPassword extends LoginState {}

