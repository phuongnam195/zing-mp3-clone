import 'package:flutter/material.dart';

class ForgotScreen extends StatelessWidget {
  static const routeName = '/auth/forgot';

  const ForgotScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.black,
          elevation: 0,
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.keyboard_backspace_rounded),
          ),
        ),
        body: Center(
          child: Text('Trống'),
        ));
  }
}
