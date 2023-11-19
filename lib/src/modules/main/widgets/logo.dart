import 'package:flutter/material.dart';

class LogoWidget extends StatelessWidget {
  const LogoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: CircleAvatar(
        child: Image.asset(
          'assets/images/logo.png',
          fit: BoxFit.cover,
          width: 35,
          height: 35,
        ),
      ),
    );
  }
}
