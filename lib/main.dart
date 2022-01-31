// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables, use_key_in_widget_constructors, avoid_print, must_be_immutable

import 'dart:async';

import 'package:dareen_app/home/cubit/shop_cubit.dart';
import 'package:dareen_app/home/home_screen.dart';
import 'package:dareen_app/modules/cart/cubit/cart_cubit.dart';
import 'package:dareen_app/modules/login/cubit/login_cubit.dart';
import 'package:dareen_app/modules/on_boarding/on_boarding_screen.dart';
import 'package:dareen_app/modules/register_screen/cubit/register_cubit.dart';
import 'package:dareen_app/shared/bloc_bserver/bloc_observer.dart';
import 'package:dareen_app/shared/cubit/app_cubit.dart';
import 'package:dareen_app/shared/network/local/cache_helper.dart';
import 'package:dareen_app/shared/network/remote/doi_helper.dart';
import 'package:dareen_app/shared/network/remote/end_points.dart';
import 'package:dareen_app/shared/styles/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

//this method help me to recieve notifications when app is terminated
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print('========== when app is closed');
  print(message.notification!.body.toString());
}

void main() async {
  //to run every thing before runApp()
  WidgetsFlutterBinding.ensureInitialized();
  //to intial firebase in my project
  await Firebase.initializeApp();
  var deviceToken = await FirebaseMessaging.instance.getToken();
  print('Device token is:' + deviceToken.toString());

  //to recieve notifications when app is open in foreground
  FirebaseMessaging.onMessage.listen((event) {
    print('========== when app opened in foreground');
    print(event.data.toString());
    //  print(event.notification);
  });
  //to recieve notifications when app is open in background
  //this methos called when user clickon the notification
  FirebaseMessaging.onMessageOpenedApp.listen((event) {
    print('========== when app opened in background');

    // if (event.data['productId'] != null) {
    //   print('=========== before');
    //   NotificationServices(productId:int.parse(event.data['productId']) );
    //   print('=========== after');
    // }
    print(event.data.toString());
  });
  //to recieve notifications when app is terminated or tottaky closed
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  //هنا بعمل تهيئة للشارد برفرنسيز وللدايو عشان ميبقوش بنل لما استدعي الدوال بتاعتهم
  await CacheHelper.init();
  DioHelper.init();
  //هنا هشوف هل المستخدم محدد الثيم بتاعه ولا اول مرة
  bool? isLight = CacheHelper.getDataFromSharedPrefrences(key: 'isLight');
  //هذه الدالة عشان افعل البلوك اوبسيرفر في المشروع بتاعي
  BlocOverrides.runZoned(
    () {
      runApp(MyApp(isLight: isLight));
      // Use cubits...
    },
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  final bool? isLight;

  MyApp({
    required this.isLight,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<RegisterCubit>(
          create: (context) => RegisterCubit(),
        ),
        BlocProvider<LoginCubit>(
          create: (context) => LoginCubit(),
        ),
        BlocProvider<AppCubit>(
            create: (context) => AppCubit()..changeAppMode(fromShared: isLight)
            // ..recieveNotifications(context)
            // ..homeScreen(isOnBoardingSeen),
            ),
        BlocProvider<ShopCubit>(
          create: (context) => ShopCubit()
            ..getCategoryData(context)
            ..getFavourites(userId)
            ..getAllProducts(),
        ),
        BlocProvider<CartCubit>(
          create: (context) => CartCubit()..getCartProducts(),
        ),
      ],
      child: BlocConsumer<AppCubit, AppState>(
          listener: (context, state) {},
          builder: (context, state) {
            AppCubit cubit = AppCubit.get(context);
            //sizer package to make responsive ui and text
            return Sizer(
              builder: (context, orientation, deviceType) => MaterialApp(
                debugShowCheckedModeBanner: false,
                title: 'Flutter Demo',
                theme: MyTheme.myLightThemeMode,
                darkTheme: MyTheme.myDarkThemeMode,
                themeMode: cubit.isLight ? ThemeMode.light : ThemeMode.dark,
                home: userId != null ? HomeScreen() : OnBoardingScreen(),
              ),
            );
          }),
    );
  }
}
