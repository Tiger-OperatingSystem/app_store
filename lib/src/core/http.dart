import 'dart:convert';

import 'package:http/http.dart' as http;

class Http {
  static const String _base = "https://flathub.org/api/v1/apps/collection/";

  static Future<List> get(String route) async {
    try {
      final response = await http.get(Uri.parse("${Http._base}/$route"));

      return jsonDecode(response.body);
    } catch (e) {
      rethrow;
    }
  }
}
