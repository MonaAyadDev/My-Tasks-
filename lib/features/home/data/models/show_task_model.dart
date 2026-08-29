import 'package:my_tasks/features/home/data/models/home_response/datum.dart';

class ShowTaskResponse {
  RequestModel? data;
  dynamic error;

  ShowTaskResponse({this.data, this.error});

  factory ShowTaskResponse.fromJson(Map<String, dynamic> json) => ShowTaskResponse(
    data: json['data'] == null
        ? null
        : RequestModel.fromJson(json['data'] as Map<String, dynamic>),
    error: json['error'],
  );
}