// ignore_for_file: avoid_print, non_constant_identifier_names

import 'package:dareen_app/data/models/user_data_model.dart';
import 'package:dareen_app/modules/login/login_screen.dart';
import 'package:dareen_app/shared/components/functions.dart';
import 'package:dareen_app/shared/network/remote/doi_helper.dart';
import 'package:dareen_app/shared/network/remote/end_points.dart';
import 'package:dareen_app/shared/widgets/my_ok_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());
  static RegisterCubit get(context) => BlocProvider.of(context);
  late String verificationId;
  String? otpCode;
  String? phoneNumber;
  //=========this method uses when user press on sign up button to login==========
  //an object from my loginModel class to use it inside the method
  late LoginModel loginModel;
  void userRegister({
    required String name,
    required String phoneNumber,
    required String email,
    required String password,
    required String password_confirmation,
    required String region,
    required String address,
    required BuildContext context,
  }) {
    emit(RegisterLoading());
    DioHelper.postData(
      url: REGISTER,
      data: {
        'name': name,
        'phoneNumber': phoneNumber,
        'email': email,
        'password': password,
        'password_confirmation': password_confirmation,
        'region': region,
        'address': address,
      },
    ).then((value) {
      loginModel = LoginModel.fromJson(value.data);
      if (loginModel.status) {
        token = loginModel.token;
        print('new token from register=========$token');
        emit(RegisterSuccess(loginModel));
      } else {
        showMyAlertDialog(
          context: context,
          title: 'خطأ أثناء التسجيل',
          isBarrierDismissible: false,
          content: loginModel.error![0],
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                navigateAndFinish(context: context, screen: LoginScreen());
              },
              child: const Text(
                'حسناً',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        );

        emit(RegisterErrorfromPhoneOrEmailExisted());
      }
    }).catchError((error) {
      showMyAlertDialog(
        context: context,
        title: 'خطأ أثناء التسجيل',
        content:
            'حدث خطأ غير متوقع أثناء التسجيل يرجي إدخال الكود بشكل صحيح أو التحقق من الإتصال بالإنترنت وأعدالمحاولة مرة أخري',
        actions: [
          MyOkTextButtonForDailog(),
        ],
      );
      print(error.toString());
      emit(RegisterError(error.toString()));
    });
  }

  //functions for phoneAuth
  //الدالة دي لما اليوزر يدخل رقم التليفون ويدوس التالي هيكون معايا رقم التليفون هباصيهولها وهيا هتوديه الفايربيز وتبدأ العملية
  Future<void> submitPhoneNumber(String phoneNumber) async {
    //طبيعي اول مايدخل رقم موبايله ويدوس التالي اعمل بعث للتحميل
    emit(LoadingPhoneAuth());
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: '+2$phoneNumber',
      timeout: const Duration(seconds: 60),
      // forceResendingToken: 50,
      //Automatic handling of the SMS code on Android devices
      verificationCompleted: verificationCompleted,
      //Handle failure events such as invalid phone numbers or whether the SMS quota has been exceeded.
      verificationFailed: verificationFailed,
      //Handle when a code has been sent to the device from Firebase
      codeSent: codeSent,
      //Handle a timeout of when automatic SMS code handling fails.
      codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
    );
  }

  //في بعض موبايلات الاندرويد بيهندل الكود لوحده ولما ده يحصل بيتم استدعاء هذه الدالة
  //وبما ان الجهاز هو اللي دخله يبقي ده معناه ان الكود صحيح وعشان كده بيديني الكريدينشال اللي ممكن من خلاله اعمل تسجيل دخول
  void verificationCompleted(PhoneAuthCredential credential) async {
    print('===========verificationCompleted ');
    //دي دالة تسجيل الدخول لانه كده خلاص المفروض دخل الكود صح
    await signIn(credential);
  }

//دي الدالة اللي هيتم استدعائها في حالة حصل اي خطأ في المصادقة
  void verificationFailed(FirebaseAuthException error) {
    print('========verificationFailed : ${error.toString()}');
    //هنا هعالج الاخطاء واظهرها للمستخدم
    if (error.code == 'invalid-phone-number') {
    } else {
      print('The code is incorrect');
    }

    // Handle other errors

    emit(ErrorOnPhoneAuth(error: error.toString()));
  }

  //الدالة دي يتم استدعائها لما الكود يتبعت من الفايربيز
  void codeSent(String verificationId, int? resendToken) async {
    //اول حاجه هخزن الكود اللي هيتبعتلي من الفايربيز في المتغير اللي عامله فوق
    this.verificationId = verificationId;
    print('=============codeSent');
    print('=============verificationId ${this.verificationId} ');
    //معني ان الكود اتعبتلي فكده رقم الموبايل صحيح وعشان كده هأميت الستاس دي
    emit(PhoneNumberSubmitted());
  }

  void codeAutoRetrievalTimeout(String verificationId) {
    print('=============codeAutoRetrievalTimeout');
  }

//دي في حالة ان الكود جاله ودخله بشكل صحيح
//بس ده في حالة ان اليوزر اللي دخله مش اوتوماتيك
  Future<void> submitOTP(String otpCode) async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
      //verificationId ده اللي جالي في الرسالة
      //otpCode ده اللي انا كتبته بإيدي
      verificationId: verificationId,
      smsCode: otpCode,
    );
    await signIn(credential);
  }

//دي الدالة المسئولة عن تسجيل الدخول لما يكون الكود صحيح وهتشتغل لو دخل اوتوماتيك او اليوزر دخله صح
  Future<void> signIn(PhoneAuthCredential credential) async {
    try {
      await FirebaseAuth.instance.signInWithCredential(credential);
      //ده معناه انهعمل عملية تسجيل دخول ناجحة
      emit(PhoneOTPVerified());
    } catch (error) {
      print(error.toString());
      emit(ErrorOnPhoneAuth(error: error.toString()));
    }
  }

  //دالة تسجيل الخروج
  Future<void> signOut(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    navigateAndFinish(context: context, screen: LoginScreen());
    emit(UserSignedOut());
  }

  //الدالة اللي هتجيب بيانات المستخدم
  User getLoogedInUser() {
    User firebaseUser = FirebaseAuth.instance.currentUser!;
    return firebaseUser;
  }

  bool isVerifyButtonEnabled = false;
  void changeVerifyButtonEnabled() {
    isVerifyButtonEnabled = true;
    emit(ChangeVerifyButtonStatusOnOtpScreen());
  }

  //======to change password icon in form text field ========
  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;
  //the icon will change based on isPassword variable value...
  void changePasswordVisibilty() {
    isPassword = !isPassword;
    suffix =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(RegisterChangePasswordVisbilty());
  }
}
