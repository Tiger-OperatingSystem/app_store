import 'package:flutter/material.dart';

class ScaffoldRight extends StatelessWidget {
  final Widget appBar;
  final Widget body;
  const ScaffoldRight({
    super.key,
    required this.appBar,
    required this.body,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        appBar,
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: body,
        ),
      ],
    );
  }
}
