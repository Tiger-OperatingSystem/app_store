import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomExceptionsWidget implements Exception {
  CustomExceptionsWidget(
    String message,
    BuildContext context,
  ) {
    _showHandler(message, context);
  }

  Future<void> _showHandler(String message, BuildContext context) async {
    String uriReport = "https://github.com/Tiger-OperatingSystem/app_store/issues";
    showDialog(context: context, builder: (context) {
      return  AlertDialog(
        title: const Text("Ocorreu um erro."),
        content: Text(message),
        actions: [
          ElevatedButton(onPressed: () async {
            await launchUrl(Uri.parse(uriReport));
          }, 
          child: const Text("Reportar este problema")),
        ],
      );
    });
  }
}