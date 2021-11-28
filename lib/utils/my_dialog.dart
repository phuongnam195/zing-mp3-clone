import 'package:flutter/material.dart';

class MyDialog {
  static void show(BuildContext context, String title, String message) {
    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
              title: Text(
                title,
                style: const TextStyle(fontSize: 22),
              ),
              content: Text(
                message,
                style: const TextStyle(fontSize: 20, color: Colors.black),
              ),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.of(ctx).pop();
                    },
                    child: const Text(
                      'OK',
                      style: TextStyle(fontSize: 18),
                    ))
              ],
            ));
  }
}
