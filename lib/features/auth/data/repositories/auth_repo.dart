import 'package:my_tasks/core/helper/cache_helper.dart';
import 'package:my_tasks/core/service/apis.dart';
import 'package:my_tasks/core/service/dio_provider.dart';
import 'package:my_tasks/features/auth/data/models/auth_params.dart';
import 'package:my_tasks/features/auth/data/models/auth_response/auth_response.dart';

class AuthRepo {
  static Future<AuthResponse?> login(AuthParams data) async {
    try {
      var response = await DioHelper.post(
        endPoint: Apis.login,
        data: data.toJson(),
      );

      if (response.statusCode == 200) {
        AuthResponse authResponse = AuthResponse.fromJson(response.data);

        final token = authResponse.data?.token;
        if (token != null) {
          await CacheHelper.setData(key: 'token', value: token);
        }

        return authResponse;
      } else {
        return null;
      }
    } catch (e) {
      print('LOGIN ERROR: $e');
      return null;
    }
  }

  static Future<AuthResponse?> register(AuthParams data) async {
    try {
      var response = await DioHelper.post(
        endPoint: Apis.register,
        data: data.toJson(),
      );

      if (response.statusCode == 201) {
        AuthResponse authResponse = AuthResponse.fromJson(response.data);

        final token = authResponse.data?.token;
        if (token != null) {
          await CacheHelper.setData(key: 'token', value: token);
        }

        return authResponse;
      } else {
        return null;
      }
    } catch (e) {
      print('REGISTER ERROR: $e');
      return null;
    }
  }
}
