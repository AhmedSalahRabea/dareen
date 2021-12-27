part of 'app_cubit.dart';

@immutable
abstract class AppState {}

class AppInitial extends AppState {}
class ThemeModeChange extends AppState{}
class OnBoardingScreenSeen extends AppState{}
//========emit to know which screen is opened first===
class ShowOnBoardingScreen extends AppState{}
class ShowOnLoginScreen extends AppState{}
class ShowOnHomeScreen extends AppState{}


