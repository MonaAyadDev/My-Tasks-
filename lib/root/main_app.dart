import 'package:flutter/material.dart';
import 'package:my_tasks/core/routes/app_routes.dart';

class MainApp extends StatelessWidget {
  final String initialRoute;

  const MainApp({super.key, required this.initialRoute});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: AppRouter.onGenerateRoute,
      initialRoute: initialRoute,
    );
  }
}
