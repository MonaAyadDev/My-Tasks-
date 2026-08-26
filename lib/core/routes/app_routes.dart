import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_tasks/core/routes/routes.dart';
import 'package:my_tasks/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:my_tasks/features/auth/presentation/screens/login_screen.dart';
import 'package:my_tasks/features/auth/presentation/screens/register_screen.dart';
import 'package:my_tasks/features/home/presentation/cubit/home_cubit.dart';
import 'package:my_tasks/features/home/presentation/screens/home_screen.dart';

class AppRouter {
  static MaterialPageRoute<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.loginScreen:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => AuthCubit(),
            child: LoginScreen(),
          ),
        );
      case Routes.registerScreen:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => AuthCubit(),
            child: RegisterScreen(),
          ),
        );
      case Routes.homeScreen:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => HomeCubit()..tasks(),
            child: HomeScreen(),
          ),
        );
      default:
        return MaterialPageRoute(
          builder: (context) => Scaffold(
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Text('404 ')],
            ),
          ),
        );
    }
  }
}
