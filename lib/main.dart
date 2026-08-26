import 'package:flutter/material.dart';
import 'package:my_tasks/core/helper/cache_helper.dart';
import 'package:my_tasks/core/routes/routes.dart';
import 'package:my_tasks/core/service/dio_provider.dart';
import 'package:my_tasks/root/main_app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  DioHelper.init();

  String startRoute = CacheHelper.getData(key: 'token') != null
      ? Routes.homeScreen
      : Routes.loginScreen;

  runApp(MainApp(initialRoute: startRoute));
}
