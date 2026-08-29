import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_tasks/features/home/data/models/home_response/datum.dart';
import 'package:my_tasks/features/home/data/models/home_response/home_response.dart';
import 'package:my_tasks/features/home/data/repositories/home_repo.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  final titleController = TextEditingController();
  final desController = TextEditingController();
  final deliveryDateController = TextEditingController();

  Future<void> tasks() async {
    emit(HomeLoading());
    try {
      final response = await HomeRepo.getTasks();
      if (response is HomeResponse) {
        emit(HomeSuccess(response.data ?? []));
      } else {
        emit(HomeError('message'));
      }
    } catch (e) {
      emit(HomeError(' $e'));
    }
  }

  Future<void> updateTasks({
    required int taskId,
    String? status,
    String? priority,
    String? deliveryDate,
  }) async {
    emit(UpdateTaskLoading());
    try {
      final success = await HomeRepo.updateTasks(
        RequestModel(
          taskId: taskId,
          title: titleController.text,
          description: desController.text,
          status: status,
          priority: priority,
          deliveryDate: deliveryDate,
        ),
      );

      if (success) {
        await tasks();
        emit(UpdateTaskSuccess());
      } else {
        emit(UpdateTaskError());
      }
    } catch (e) {
      emit(UpdateTaskError());
    }
  }

  Future<void> showTasks({required int taskId}) async {
    emit(ShowTaskLoading());
    try {
      final response = await HomeRepo.showTasks(RequestModel(taskId: taskId));

      if (response != null && response.data != null) {
        emit(ShowTaskSuccess(response.data!));
      } else {
        emit(ShowTaskError('Failed to load task details'));
      }
    } catch (e) {
      emit(ShowTaskError(e.toString()));
    }
  }

  Future<void> addTasks() async {
    emit(AddTaskLoading());
    try {
      final success = await HomeRepo.addTasks(
        RequestModel(
          title: titleController.text,
          description: desController.text,
          deliveryDate: deliveryDateController.text,
        ),
      );

      if (success) {
        await tasks();
        emit(AddTaskSuccess());
      } else {
        emit(AddTaskError());
      }
    } catch (e) {
      emit(AddTaskError());
    }
  }

  @override
  Future<void> close() {
    titleController.dispose();
    desController.dispose();
    return super.close();
  }
}
