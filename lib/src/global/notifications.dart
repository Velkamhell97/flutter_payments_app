import 'package:flutter/material.dart';

import '../models/models.dart';
import '../widgets/widgets.dart';

class Notifications{
  static final navigatorKey = GlobalKey<NavigatorState>();
  static final messengerKey = GlobalKey<ScaffoldMessengerState>();

  static Future<bool> _dialogBuilder(DialogModel dialog) async {
    return await showGeneralDialog<bool>(
      context: navigatorKey.currentContext!, 
      pageBuilder: (_, animation, __) => SlideTransition(
        position: Tween(begin: const Offset(0.0, 1.0), end: const Offset(0.0, 0.0)).animate(animation),
        child: CustomDialog(dialog: dialog),
      ),
    ) ?? false;
  }

  static Future<void> showLoadingDialog() async {
    return showDialog(
      context: navigatorKey.currentContext!,
      builder: (_) {
        return const AlertDialog(
          title: Text('Espere...'),
          content: LinearProgressIndicator(),
        );
      }
    );
  }

  static Future<bool> paymentSuccessDialog() async {
    const dialog = DialogModel(
      icon: Icon(Icons.check_circle_outline, color: Colors.greenAccent), 
      title: "Payment Success", 
      body: "The payment was made successfully", 
      mainButton: 'Accept',
      // secondaryButton: 'Decline'
    );

    return await _dialogBuilder(dialog);
  }

  static Future<void> showSnackBar(String message) async{
    messengerKey.currentState!.showSnackBar(CustomSnackBar(message: message));
  }
}