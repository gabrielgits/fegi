import 'package:flutter/material.dart';


void snackBarShow({required String value, required BuildContext context, Color color = Colors.green}) {
  final snackBar = SnackBar(
    content: Text(value),
    duration: const Duration(seconds: 3),
    backgroundColor: color,
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
