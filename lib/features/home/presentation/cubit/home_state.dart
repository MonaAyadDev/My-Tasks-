part of 'home_cubit.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeSuccess extends HomeState {
  final List<RequestModel> data;
  HomeSuccess(this.data);
}

class HomeError extends HomeState {
  final String message;
  HomeError(this.message);
}

class UpdateTaskLoading extends HomeState {}

class UpdateTaskSuccess extends HomeState {}

class UpdateTaskError extends HomeState {}

class ShowTaskLoading extends HomeState {}

class ShowTaskSuccess extends HomeState {
  final RequestModel task;
  ShowTaskSuccess(this.task);
}

class ShowTaskError extends HomeState {
  final String message;
  ShowTaskError(this.message);
}


class AddTaskLoading extends HomeState {}

class AddTaskSuccess extends HomeState {}

class AddTaskError extends HomeState {}