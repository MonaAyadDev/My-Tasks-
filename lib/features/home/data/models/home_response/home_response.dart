import 'datum.dart';
import 'meta.dart';

class HomeResponse {
  List<Datum>? data;
  Meta? meta;
  dynamic error;

  HomeResponse({this.data, this.meta, this.error});

  factory HomeResponse.fromJson(Map<String, dynamic> json) => HomeResponse(
    data: (json['data'] as List<dynamic>?)
        ?.map((e) => Datum.fromJson(e as Map<String, dynamic>))
        .toList(),
    meta: json['meta'] == null
        ? null
        : Meta.fromJson(json['meta'] as Map<String, dynamic>),
    error: json['error'] as dynamic,
  );

  Map<String, dynamic> toJson() => {
    'data': data?.map((e) => e.toJson()).toList(),
    'meta': meta?.toJson(),
    'error': error,
  };
}
