import 'dart:convert';

import 'package:http/http.dart' as http;

class Http {
  static const String _flathubBase = "https://flathub.org/api/v1/apps/";
  static const String _githubBase = "https://raw.githubusercontent.com/";

  static Future get(String route) async {
    String base =
        route.startsWith("Tiger-OperatingSystem/") ? _githubBase : _flathubBase;
    try {
      final response = await http.get(Uri.parse("$base/$route"));
      return jsonDecode(response.body);
    } catch (e) {
      //print(e); // Debug info
      rethrow;
    }
  }
}
