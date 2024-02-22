import 'dart:convert';

import 'package:app_store/src/modules/applications/shared_cache_repository.dart';
import 'package:http/http.dart' as http;

class Http {
  static const String _flathubBase = "https://flathub.org/api/v1/apps/";
  static const String _githubBase = "https://raw.githubusercontent.com/";

  static Future get(String route) async {
    final cache = SharedCacheRepository();
    final today = DateTime.now();
    String base =
        route.startsWith("Tiger-OperatingSystem/") ? _githubBase : _flathubBase;
    try {
      if (await cache.read(route) == null ||
          await cache.read('expiration') == null) {
        print('created cache');
        final response = await http.get(Uri.parse("$base/$route"));
        await cache.save(route, response.body);
        return get(route);
      }

      final expiration = DateTime.parse(await cache.read('expiration'));
      if (expiration.isAfter(today) && await cache.read(route) != null) {
        print('read cache dont expirated');
        return jsonDecode(await cache.read(route));
      }

      return get(route);
    } catch (e) {
      //print(e); // Debug info
      rethrow;
    }
  }
}
