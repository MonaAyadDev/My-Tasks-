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

  Future<void> updateTasks({required int id}) async {
    emit(UpdateTaskLoading());
    try {
      final response = await HomeRepo.updateTasks(
        taskId: id,
        title: titleController.text,
        des: desController.text,
      );
      if (response != null) {
        await tasks();
        emit(UpdateTaskSuccess());
      } else {
        emit(UpdateTaskError());
      }
    } catch (e) {
      emit(UpdateTaskError());
    }
  }

  @override
  Future<void> close() {
    titleController.dispose();
    desController.dispose();
    return super.close();
  }
}
