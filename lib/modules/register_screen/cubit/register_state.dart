part of 'register_cubit.dart';

@immutable
abstract class RegisterState {}

class RegisterInitial extends RegisterState {}

class RegisterLoading extends RegisterState {}

class RegisterSuccess extends RegisterState {
  final LoginModel loginModel;

 RegisterSuccess(this.loginModel);
}

class RegisterError extends RegisterState {
  final String error;
  RegisterError(this.error);
}
// states for phone auth
class LoadingPhoneAuth extends RegisterState {}

class ErrorOnPhoneAuth extends RegisterState {
  final String error;
  ErrorOnPhoneAuth({required this.error});
}
//دي لما اخد رقم التليفون من اليوزر 
class PhoneNumberSubmitted extends RegisterState {}
//لما اليوزر يدخل الكوداللي جاله ع الموبايل
class PhoneOTPVerified extends RegisterState {}
//========for change password visibilty========
class RegisterChangePasswordVisbilty extends RegisterState {}
//show when the phone or email already exists on my data base
class RegisterErrorfromPhoneOrEmailExisted extends RegisterState {}

//user sign out
class UserSignedOut extends RegisterState {}


//to change verify button status from disabled to enabled
class ChangeVerifyButtonStatusOnOtpScreen extends RegisterState {}





