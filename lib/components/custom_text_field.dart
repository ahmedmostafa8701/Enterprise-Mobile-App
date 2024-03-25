import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    this.hintText,
    this.onChange,
    this.obscureText = false,
    this.autoFocus = false,
    this.validator,
    this.focusNode,
    this.onFieldSubmit,
    this.labelText,
    this.suffixIcon,
    this.controller,
  });

  final String? hintText;
  final String? labelText;
  final Function(String)? onChange;
  final bool obscureText;
  final bool autoFocus;
  final String? Function(String? data)? validator;
  final String Function(String? value)? onFieldSubmit;
  final FocusNode? focusNode;
  final Widget? suffixIcon;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      obscuringCharacter: '*',
      autofocus: autoFocus,
      focusNode: focusNode,
      validator: validator,
      onChanged: onChange,
      onFieldSubmitted: onFieldSubmit,
      style: const TextStyle(
        color: Colors.white,
      ),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(color: Colors.grey),
        labelText: labelText,
        labelStyle: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
        suffixIcon: suffixIcon,
        border: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
      ),
    );
  }
}
