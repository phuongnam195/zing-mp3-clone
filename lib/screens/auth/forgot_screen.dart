import 'package:flutter/material.dart';

class ForgotScreen extends StatefulWidget {
  static const routeName = '/auth/forgot';

  const ForgotScreen({Key? key}) : super(key: key);

  @override
  State<ForgotScreen> createState() => _ForgotScreenState();
}

class _ForgotScreenState extends State<ForgotScreen> {
  bool _isSubmitted = false;

  @override
  Widget build(BuildContext context) {
    // Ảnh: Image.asset('assets/images/auth/forgot_image.jpg')

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
