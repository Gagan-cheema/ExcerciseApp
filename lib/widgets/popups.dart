import 'package:exercise_app/constants/constants.dart';
import 'package:flutter/material.dart';

class Popup {
  const Popup._();

  static Future<void> showErrorDialog(
    BuildContext context, {
    String message = kSomethingNotRight,
  }) async {
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(kOpps),
        content: Text(message),
        actionsAlignment: MainAxisAlignment.center,
        actions: [
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(kOkey),
          ),
        ],
      ),
    );
  }
}
