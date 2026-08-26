import 'package:my_tasks/core/service/apis.dart';
import 'package:my_tasks/core/service/dio_provider.dart';
import 'package:my_tasks/features/home/data/models/home_response/home_response.dart';

class HomeRepo {
  static Future<HomeResponse?> getTasks() async {
    try {
      var response = await DioHelper.get(endPoint: Apis.task);

      if (response.statusCode == 200) {
        HomeResponse data = HomeResponse.fromJson(response.data);
        return data;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  static Future<HomeResponse?> updateTasks({
    required int taskId,
    String? title,
    String? des,
  }) async {
    try {
      var response = await DioHelper.put(
        endPoint: 'tasks/$taskId',
        data: {'title': title, 'description': des},
      );

      if (response.statusCode == 200) {
        HomeResponse data = HomeResponse.fromJson(response.data);
        return data;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}
