import 'package:flutter/material.dart';

class InputTextWidget extends StatelessWidget {
  final String labelText;
  final IconData iconData;
  final TextEditingController? controller;
  final bool? obscureText;
  final String? initialValue;
  final Widget? suffixIcon;
  final void Function(String)? onPressed;
  const InputTextWidget({
    super.key,
    required this.labelText,
    required this.iconData,
    this.controller,
    this.obscureText,
    this.initialValue,
    this.suffixIcon,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: TextFormField(
        onFieldSubmitted: onPressed,
        initialValue: initialValue,
        controller: controller,
        obscureText: obscureText ?? false,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(10),
          isDense: true,
          filled: false,
          fillColor: Theme.of(context).colorScheme.background,
          prefixIcon: Icon(iconData),
          suffixIcon: suffixIcon,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
          ),
          hintText: labelText,
        ),
      ),
    );
  }
}
