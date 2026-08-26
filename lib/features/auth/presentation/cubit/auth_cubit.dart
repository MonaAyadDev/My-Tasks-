import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_tasks/features/auth/data/models/auth_params.dart';
import 'package:my_tasks/features/auth/data/repositories/auth_repo.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final passwordConfirmationController = TextEditingController();
  final nameController = TextEditingController();

  Future<void> login() async {
    emit(AuthLodingState());
    final response = await AuthRepo.login(
      AuthParams(
        email: emailController.text,
        password: passwordController.text,
      ),
    );
    if (response != null) {
      return emit(AuthSuccsesState());
    } else {
      emit(AuthErrorState());
    }
  }

  Future<void> register() async {
    emit(AuthLodingState());
    var respons = await AuthRepo.register(
      AuthParams(
        email: emailController.text,
        password: passwordController.text,
        name: nameController.text,
        passwordConfirmation: passwordConfirmationController.text,
      ),
    );
    if (respons != null) {
      emit(AuthSuccsesState());
    } else {
      emit(AuthErrorState());
    }
  }
}
