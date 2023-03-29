import 'package:flutter/material.dart';

class MenssageSnackBar {
  static void show(BuildContext context, String message) {
    final snackBar = SnackBar(
      content: Text(message),
      duration: const Duration(seconds: 3),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.only(bottom: 10.0, left: 10.0, right: 10.0),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
