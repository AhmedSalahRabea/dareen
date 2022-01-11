part of 'app_cubit.dart';

@immutable
abstract class AppState {}

class AppInitial extends AppState {}
//========when change app mode ===
class ThemeModeChange extends AppState{}
//========when update user data ===
class UpdateUserDataLoading extends AppState{}
class UpdateUserDataSuccess extends AppState{}
class UpdateUserDataError extends AppState{}



