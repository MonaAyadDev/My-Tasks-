import 'package:flutter/material.dart';

class AppDialogs {
  static Future<dynamic> loadingDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        child: CircularProgressIndicator(),
      ),
    );
  }

  static Future<dynamic> errorDialog(BuildContext context, {String? message}) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Error'),
        content: Text(message ?? 'Something went wrong, please try again.'),
      ),
    );
  }
}
