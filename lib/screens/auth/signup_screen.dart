import 'package:flutter/material.dart';

import '../../widgets/auth/signup_card.dart';

class SignUpScreen extends StatelessWidget {
  static const routeName = '/auth/signup';

  const SignUpScreen({Key? key}) : super(key: key);

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
