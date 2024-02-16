import 'dart:convert';

import 'package:http/http.dart' as http;

class Http {
  static const String _flathub_base = "https://flathub.org/api/v1/apps/";
  static const String _github_base  = "https://raw.githubusercontent.com/";

  static Future get(String route) async {
    String _base = route.startsWith("Tiger-OperatingSystem/")?_github_base:_flathub_base;
    try {
      final response = await http.get(Uri.parse("$_base/$route"));
      return jsonDecode(response.body);
    } catch (e) {
      print(e); // Debug info
      rethrow;
    }
  }
}
