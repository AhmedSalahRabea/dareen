// ignore_for_file: avoid_print, non_constant_identifier_names

import 'package:dareen_app/data/models/success_or_delete_model.dart';
import 'package:dareen_app/shared/components/functions.dart';
import 'package:dareen_app/shared/network/local/cache_helper.dart';
import 'package:dareen_app/shared/network/remote/doi_helper.dart';
import 'package:dareen_app/shared/network/remote/end_points.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppInitial());

  static AppCubit get(context) => BlocProvider.of(context);
  //==================change themeMode=================
  bool isLight = false;
  void changeAppMode({bool? fromShared}) {
    if (fromShared != null) {
      isLight = fromShared;
      emit(ThemeModeChange());
    } else {
      isLight = !isLight;
      CacheHelper.saveDataInSharedPrefrences(
        key: 'isLight',
        value: isLight,
      ).then((value) {
        emit(ThemeModeChange());
      });
    }
  }

// =======to open what's app
  void openWhatapp(BuildContext context) async {
    String url = "https://wa.me/+201018388182";
    if (await canLaunch(url)) {
      launch(url);
    } else {
      showMyAlertDialog(
        context: context,
        title: 'خطأ أثناء الوصول إلي الواتساب',
        content: const Text(
          'حدث خطأ ربما يكون تطبيق الواتساب غير موجود علي هاتفك',
          textDirection: TextDirection.rtl,
          style: TextStyle(color: Colors.black, fontSize: 16),
        ),
      );
    }
  }

  // === to call on phone ====
  void callPhone(BuildContext context) async {
    String url = "tel:+201018388182";
    if (await canLaunch(url)) {
      launch(url);
    } else {
      showMyAlertDialog(
        context: context,
        title: 'خطأ أثناء الوصول إلي الهاتف',
        content: const Text(
          'حدث خطأ أثناء الوصول برجاء المحاولة لاحقا',
          textDirection: TextDirection.rtl,
          style: TextStyle(color: Colors.black, fontSize: 16),
        ),
      );
    }
  }
//   void openWhatsapp(BuildContext context) async {
//     String phoneNumber = '+201018388182';
//     var whatsappURL_android = 'whatsapp://send?phone=$phoneNumber';
//     var whatsappURL_ios = 'https://wa.me/$phoneNumber';
//     if (Platform.isIOS) {
//       //for ios devices
//       if (await canLaunch(whatsappURL_ios)) {
//         await launch(whatsappURL_ios);
//       } else {
//         showMyAlertDialog(
//           context: context,
//           title: 'خطأ أثناء الوصول إلي الواتساب',
//           content: 'حدث خطأ ربما يكون تطبيق الواتساب غير موجود علي هاتفك',
//         );
//       }
//     } else {
// //for andriod and web
//       if (await canLaunch(whatsappURL_android)) {
//         await launch(whatsappURL_android);
//       } else {
//         showMyAlertDialog(
//           context: context,
//           title: 'خطأ أثناء الوصول إلي الواتساب',
//           content: 'حدث خطأ ربما يكون تطبيق الواتساب غير موجود علي هاتفك',
//         );
//       }
//     }
//   }

//====to update user Data =====
  SuccessOrFailedModel? updateUserDataModel;
  void updateUserData({
    //required int uId,
    required String userName,
    required String userRegion,
    required String userAddress,
  }) async {
    emit(UpdateUserDataLoading());
    await DioHelper.postData(
      url: UPDATEUSERDATA,
      data: {
        'id': userId,
        'name': userName,
        'region': userRegion,
        'address': userAddress,
      },
    ).then((value) {
      updateUserDataModel = SuccessOrFailedModel.fromJson(value.data);
      if (updateUserDataModel != null) {
        if (updateUserDataModel!.status!) {
          saveUserDataInSharedPref(
            token: token!,
            userId: userId!,
            userName: userName,
            phoneNumber: phoneNumber!,
            userRegion: userRegion,
            userAddress: userAddress,
          );
          emit(UpdateUserDataSuccess());
        }
      }

      //emit(UpdateUserDataSuccess());
    }).catchError((error) {
      print(error.toString());
      emit(UpdateUserDataError());
    });
  }
}
