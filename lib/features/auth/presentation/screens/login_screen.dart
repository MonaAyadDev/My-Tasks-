import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_tasks/core/helper/app_dialogs.dart';
import 'package:my_tasks/core/helper/extinsions.dart';
import 'package:my_tasks/core/routes/routes.dart';
import 'package:my_tasks/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:my_tasks/core/widgets/main_form_field.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<AuthCubit>();
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthLodingState) {
          AppDialogs.loadingDialog(context);
        } else if (state is AuthSuccsesState) {
          context.pop();
          context.pushToBase(Routes.homeScreen);
        } else if (state is AuthErrorState) {
          context.pop();
          AppDialogs.errorDialog(context, message: 'Invalid email or password');
        }
      },
      child: Scaffold(
        backgroundColor: const Color(0xFFF2E7CC),
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Icon(
                    Icons.check_circle_outline_rounded,
                    size: 80,
                    color: Color(0xFF6F4680),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'my Tasks 📝',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1D2935),
                    ),
                  ),
                  const SizedBox(height: 36),
                  MainFormField(
                    controller: cubit.emailController,
                    label: 'Email',
                    hint: 'nhfgy88@gmail.com',
                    keyboardType: TextInputType.emailAddress,
                    prefixIcon: const Icon(Icons.email_outlined),
                  ),
                  const SizedBox(height: 18),
                  MainFormField(
                    controller: cubit.passwordController,
                    label: 'Password',
                    hint: '123456',
                    keyboardType: TextInputType.visiblePassword,
                    prefixIcon: const Icon(Icons.lock_outline),
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () {
                      cubit.login();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF51375B),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 0,
                    ),
                    child: const Text(
                      'Login ',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 14),

                  ElevatedButton(
                    onPressed: () {
                      context.pushNamed(Routes.registerScreen);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF51375B),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 0,
                    ),
                    child: const Text(
                      'Register ',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
