import 'package:flutter/material.dart';

class CustomExceptionsWidget implements Exception {
  CustomExceptionsWidget(
    String message,
    BuildContext context,
  ) {
    _showHandler(message, context);
  }

  Future<void> _showHandler(String message, BuildContext context) async {
    showDialog(context: context, builder: (context) {
      return  AlertDialog(
        title: const Text("Ocorreu um erro."),
        content: Text(message),
        actions: [
          ElevatedButton(onPressed: (){}, child: const Text("Reportar este problema")),
        ],
      );
    });
  }
}