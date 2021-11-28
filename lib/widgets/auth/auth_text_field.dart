import 'dart:ui';

import 'package:flutter/material.dart';

class AuthTextField extends StatelessWidget {
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final String labelText;
  final BorderRadius borderRadius;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final bool obscureText;
  final void Function(String value)? onSubmitted;
  final bool hasBorderSide;

  const AuthTextField({
    this.controller,
    this.focusNode,
    required this.labelText,
    required this.borderRadius,
    this.keyboardType,
    this.textInputAction,
    this.obscureText = false,
    this.onSubmitted,
    this.hasBorderSide = false,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final fontSize = screenHeight / 36;
    final verticalPadding = screenHeight / 45;

    return TextField(
      controller: controller,
      focusNode: focusNode,
      cursorColor: Colors.black,
      obscureText: obscureText,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      onSubmitted: onSubmitted,
      style: TextStyle(
          fontFamily: 'Helvetica Neue',
          color: Colors.black,
          fontSize: fontSize,
          fontWeight: FontWeight.w500),
      decoration: InputDecoration(
        filled: true,
        fillColor: const Color(0xfff4f4f4),
        hoverColor: Colors.transparent,
        floatingLabelBehavior: FloatingLabelBehavior.never,
        isDense: true,
        contentPadding:
            EdgeInsets.symmetric(horizontal: 15, vertical: verticalPadding),
        labelText: labelText,
        labelStyle: TextStyle(
            color: Colors.black.withOpacity(0.5),
            fontSize: fontSize,
            fontWeight: FontWeight.w500),
        enabledBorder: OutlineInputBorder(
          borderSide: hasBorderSide
              ? BorderSide(color: Colors.grey[500]!, width: 0.5)
              : BorderSide.none,
          borderRadius: borderRadius,
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: hasBorderSide
              ? BorderSide(color: Colors.grey[500]!, width: 0.5)
              : BorderSide.none,
          borderRadius: borderRadius,
        ),
      ),
    );
  }
}
