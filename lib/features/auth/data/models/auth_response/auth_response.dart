import 'data.dart';

class AuthResponse {
  Data? data;
  dynamic error;

  AuthResponse({this.data, this.error});

  factory AuthResponse.fromJson(Map<String, dynamic> json) => AuthResponse(
    data: json['data'] == null
        ? null
        : Data.fromJson(json['data'] as Map<String, dynamic>),
    error: json['error'] as dynamic,
  );
}
