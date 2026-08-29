import 'datum.dart';
import 'meta.dart';

class HomeResponse {
  //يستقبل القيمه الراجعه من السيرفر "json"
  List<RequestModel>? data;
  Meta? meta;
  dynamic error;

  HomeResponse({this.data, this.meta, this.error});

  factory HomeResponse.fromJson(Map<String, dynamic> json) => HomeResponse(
    data: (json['data'] as List<dynamic>?)
        ?.map((e) => RequestModel.fromJson(e as Map<String, dynamic>))
        .toList(),
    meta: json['meta'] == null
        ? null
        : Meta.fromJson(json['meta'] as Map<String, dynamic>),
    error: json['error'] as dynamic,
  );
}
