import 'package:dio/dio.dart';
import 'package:my_tasks/core/service/apis.dart';
import 'package:my_tasks/core/service/dio_provider.dart';
import 'package:my_tasks/features/home/data/models/home_response/datum.dart';
import 'package:my_tasks/features/home/data/models/home_response/home_response.dart';
import 'package:my_tasks/features/home/data/models/show_task_model.dart';

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

static Future<bool> updateTasks(RequestModel data) async {
  try {
    var response = await DioHelper.put(
      endPoint: 'tasks/${data.taskId}',
      data: data.toJson(),
    );

    print('STATUS CODE: ${response.statusCode}');
    print('BODY: ${response.data}');

    return response.statusCode == 200 || response.statusCode == 201;
  } on DioException catch (e) {
    print('DIO ERROR RESPONSE: ${e.response?.data}'); // ← ده أهم سطر دلوقتي
    return false;
  } catch (e) {
    print('ERROR: $e');
    return false;
  }
}

  static Future<ShowTaskResponse?> showTasks(RequestModel data) async {
    try {
      var response = await DioHelper.get(endPoint: 'tasks/${data.taskId}');
      if (response.statusCode == 200) {
        return ShowTaskResponse.fromJson(response.data);
      }
      return null;
    } catch (e) {
      return null;
    }
  }
static Future<bool> addTasks(RequestModel data) async {
  try {
    var response = await DioHelper.post(
      endPoint: 'tasks',
      data: data.toJson(),
    );

    print('STATUS CODE: ${response.statusCode}');
    print('BODY: ${response.data}');

    return response.statusCode == 200 || response.statusCode == 201;
  } catch (e) {
    print('ERROR: $e');
    return false;
  }
}
}
