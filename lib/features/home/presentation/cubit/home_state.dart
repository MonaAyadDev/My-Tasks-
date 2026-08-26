part of 'home_cubit.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeSuccess extends HomeState {
  final List<Datum> data;
  HomeSuccess(this.data);
}

class HomeError extends HomeState {
  final String message;
  HomeError(this.message);
}

class UpdateTaskLoading extends HomeState {}

class UpdateTaskSuccess extends HomeState {}

class UpdateTaskError extends HomeState {}
