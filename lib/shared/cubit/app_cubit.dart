// ignore_for_file: avoid_print


import 'package:dareen_app/shared/network/local/cache_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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

  //======== to detect is the user saw onboarding screen or no ====
  void onboardingSeen(bool? isOnBoardingSeen) {
    if (isOnBoardingSeen == null) {
      CacheHelper.saveDataInSharedPrefrences(
        key: 'isOnBoardingSeen',
        value: true,
      ).then((value) {
        emit(OnBoardingScreenSeen());
      });
    }
  }

  //=======to detect the start screen========
//  late Widget startScreen;
//   void homeScreen(isOnBoardingSeen) {
//     if (isOnBoardingSeen == null) {
//       startScreen = OnBoardingScreen(isOnBoardingSeen: isOnBoardingSeen);
//       emit(ShowOnBoardingScreen());
//     } else {
//       FirebaseAuth.instance.userChanges().listen((User? user) {
//         if (user == null) {
//           startScreen = LoginScreen();
//           print('===== show login screen');
//           emit(ShowOnLoginScreen());
//         } else {
//           startScreen = HomeScreen();
//           print('===== show home screen');
//           emit(ShowOnHomeScreen());
//         }
//       });
//     }
//   }
//  late Widget startScreen;
//   void homeScreen(isOnBoardingSeen) {
//     if (isOnBoardingSeen == null) {
//       startScreen = OnBoardingScreen(isOnBoardingSeen: isOnBoardingSeen);
//       emit(ShowOnBoardingScreen());
//     } else {
//       FirebaseAuth.instance.userChanges().listen((User? user) {
//         if (user == null) {
//           startScreen = LoginScreen();
//           print('===== show login screen');
//           emit(ShowOnLoginScreen());
//         } else {
//           startScreen = HomeScreen();
//           print('===== show home screen');
//           emit(ShowOnHomeScreen());
//         }
//       });
//     }
//   }
}
