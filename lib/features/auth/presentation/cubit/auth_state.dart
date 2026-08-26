part of 'auth_cubit.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class AuthLodingState extends AuthState {}

final class AuthSuccsesState extends AuthState {}

final class AuthErrorState extends AuthState {}
