import 'dart:convert';

import 'package:http/http.dart' as http;

class Http {
  static const String _base = "https://flathub.org/api/v1/apps/";

  static Future get(String route) async {
    try {
      final response = await http.get(Uri.parse("${Http._base}/$route"));

      return jsonDecode(utf8.decode(response.body.codeUnits));
    } catch (e) {
      rethrow;
    }
  }
}
