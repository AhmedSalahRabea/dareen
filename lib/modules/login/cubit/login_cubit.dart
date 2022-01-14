// ignore_for_file: avoid_print

import 'package:dareen_app/data/models/user_data_model.dart';
import 'package:dareen_app/home/cubit/shop_cubit.dart';
import 'package:dareen_app/home/home_screen.dart';
import 'package:dareen_app/modules/cart/cubit/cart_cubit.dart';
import 'package:dareen_app/shared/components/functions.dart';
import 'package:dareen_app/shared/cubit/app_cubit.dart';
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
  void userLogin({
    required String phoneNumber,
    required String password,
    required BuildContext context,
  }) {
    ShopCubit.get(context).curretIndex = 0;
    emit(LoginLoading());
    DioHelper.postData(
      url: LOGIN,
      data: {
        'phoneNumber': phoneNumber,
        'password': password,
      },
    ).then((value) {
      loginModel = LoginModel.fromJson(value.data);
      if (loginModel.status) {
        //token = loginModel.token;
        saveUserDataInSharedPref(
          token: loginModel.token!,
          userId: loginModel.data!.id,
          userName: loginModel.data!.name,
          phoneNumber: loginModel.data!.phoneNumber,
          userRegion: loginModel.data!.region,
          userAddress: loginModel.data!.address,
        ).then((value) {
          ShopCubit.get(context).getCategoryData(context);
          ShopCubit.get(context).getFavourites(userId);
          CartCubit.get(context).getCartProducts();

          navigateAndFinish(context: context, screen: HomeScreen());
          emit(LoginSuccess(loginModel));
        });
        // ShopCubit.get(context).getCategoryData(context);
        // ShopCubit.get(context).getFavourites(userId);
        // CartCubit.get(context).getCartProducts();
        print('new token from login=========$token');
      } else {
        showMyAlertDialog(
          context: context,
          title: ' خطأ أثناء تسجيل الدخول',
          content: loginModel.message!,
          actions: [
            MyOkTextButtonForDailog(),
          ],
        );
        emit(LoginErrorOnEmailOrPassword());
      }
    }).catchError((error) {
      showMyAlertDialog(
        context: context,
        title: ' خطأ أثناء تسجيل الدخول',
        content:
            'حدث خطأ ما أثناء تسجيل الدخول برجاء التأكد من الإتصال بالإنترنت وأعد المحاولة مرة أخري',
        actions: [
          MyOkTextButtonForDailog(),
        ],
      );
      print(error.toString());
      emit(LoginError(error.toString()));
    });
  }

  // Future<void> signOut(BuildContext context) async {
  //   await FirebaseAuth.instance.signOut();
  //   navigateAndFinish(context: context, screen: LoginScreen());
  // }

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
