// ignore_for_file: avoid_print

import 'package:dareen_app/data/models/success_or_failed_model.dart';
import 'package:dareen_app/data/models/user_data_model.dart';
import 'package:dareen_app/home/cubit/shop_cubit.dart';
import 'package:dareen_app/shared/components/functions.dart';
import 'package:dareen_app/shared/network/remote/doi_helper.dart';
import 'package:dareen_app/shared/network/remote/end_points.dart';
import 'package:dareen_app/shared/widgets/my_ok_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());
  static LoginCubit get(context) => BlocProvider.of(context);
  //=========this method uses when user press on login button to login==========
  //an object from my loginModel class to use it inside the method
  late LoginModel loginModel;
  Future<void> userLogin({
    required String phoneNumber,
    required String password,
    required BuildContext context,
  }) async {
    ShopCubit.get(context).curretIndex = 0;
    emit(LoginLoading());
    await DioHelper.postData(
      url: LOGIN,
      data: {
        'phoneNumber': phoneNumber,
        'password': password,
      },
    ).then((value) {
      loginModel = LoginModel.fromJson(value.data);
      emit(LoginSuccess(loginModel));
      // if (loginModel.status) {
      //   //token = loginModel.token;
      //   saveUserDataInSharedPref(
      //     token: loginModel.token!,
      //     userId: loginModel.data!.id,
      //     userName: loginModel.data!.name,
      //     phoneNumber: loginModel.data!.phoneNumber,
      //     userRegion: loginModel.data!.region,
      //     userAddress: loginModel.data!.address,
      //   ).then((value) {
      //     ShopCubit.get(context).getCategoryData(context);
      //     ShopCubit.get(context).getFavourites(userId);
      //     CartCubit.get(context).getCartProducts();

      //     navigateAndFinish(context: context, screen: HomeScreen());
      //     emit(LoginSuccess(loginModel));
      //   });
      //   // ShopCubit.get(context).getCategoryData(context);
      //   // ShopCubit.get(context).getFavourites(userId);
      //   // CartCubit.get(context).getCartProducts();
      //   print('new token from login=========$token');
      // } else {
      //   showMyAlertDialog(
      //     context: context,
      //     title: ' خطأ أثناء تسجيل الدخول',
      //     content: loginModel.message!,
      //     actions: [
      //       MyOkTextButtonForDailog(),
      //     ],
      //   );
      //   emit(LoginErrorOnEmailOrPassword());
      // }
    }).catchError((error) {
      showMyAlertDialog(
        context: context,
        title: ' خطأ أثناء تسجيل الدخول',
        content:
          const  Text('حدث خطأ ما أثناء تسجيل الدخول برجاء التأكد من الإتصال بالإنترنت وأعد المحاولة مرة أخري',     textDirection: TextDirection.rtl,
      style:  TextStyle(color: Colors.black, fontSize: 16),),
        actions: [
         const MyOkTextButtonForDailog(),
        ],
      );
      print(error.toString());
      emit(LoginError(error.toString()));
    });
  }

  //====== to change password =========
  SuccessOrFailedModel? changePasswordModel;
  void changeUserPassword({
    required String oldPassword,
    required String newPassword,
  }) async {
    emit(ChangePasswordLoading());
    await DioHelper.postData(
      url: CHANGEPASSWORD,
      data: {
        'user_id': userId,
        'old_password': oldPassword,
        'new_password': newPassword,
      },
    ).then((value) {
      changePasswordModel = SuccessOrFailedModel.fromJson(value.data);
      if (changePasswordModel!.status!) {
        emit(ChangePasswordSuccess());
      } else {
        emit(ChangePasswordFailedWrongPassword());
      }
    }).catchError((error) {
      print(error.toString());
      emit(ChangePasswordError());
    });
  }

  //to update phoneNumber
  // Future<void> updatePhoneNumber() async {
  //   await FirebaseAuth.instance.setSettings(
  //     phoneNumber: phoneNumber,
  //     );
  // }

  //======to change password icon in form text field ========
  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;
  //the icon will change based on isPassword variable value...
  void changePasswordVisibilty() {
    isPassword = !isPassword;
    suffix =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(LoginChangePasswordVisbilty());
  }
}
