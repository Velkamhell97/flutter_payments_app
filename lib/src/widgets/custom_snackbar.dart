import 'package:flutter/material.dart';

class CustomSnackBar extends SnackBar {

  static const _style = TextStyle(color: Colors.white);

  CustomSnackBar({
    Key? key,
    required String message,
    String btnLabel = 'OK',
    Duration duration = const Duration(seconds: 2),
    VoidCallback? onPressed
  }) : super(
    backgroundColor: ThemeData.dark().scaffoldBackgroundColor,
    key: key,
    content: Text(message, style: _style),
    duration: duration,
    action: onPressed == null ? null : SnackBarAction(
      onPressed: onPressed,
      label: btnLabel, 
    )
  );
}