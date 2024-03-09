import 'dart:convert';

import 'package:app_store/src/modules/applications/libretranlate_translate.dart';
import 'package:app_store/src/modules/applications/shared_cache_repository.dart';
import 'package:http/http.dart' as http;

class Http {
  static const String _flathubBase = "https://flathub.org/api/v1/apps/";
  static const String _githubBase =
      "https://raw.githubusercontent.com/Tiger-OperatingSystem/TigerStore-Addons/";

  static Future get(String route) async {
    final cache = SharedCacheRepository();
    final libreTranslate = LibreTranslate();
    final today = DateTime.now();
    String base = route.startsWith("main/") ? _githubBase : _flathubBase;
    try {
      if (await cache.read(route) == null ||
          await cache.read('expiration') == null) {
        print('created cache');
        final response = await http.get(Uri.parse("$base/$route"));
        final translate = await libreTranslate.fromString(response.body);
        await cache.save(route, jsonEncode(translate));
        return get(route);
      }

      final expiration = DateTime.parse(await cache.read('expiration'));
      if (expiration.isAfter(today) && await cache.read(route) != null) {
        print('read cache dont expirated');
        return jsonDecode(await cache.read(route));
      }
      await cache.remove('expiration');
      await cache.remove(route);
      return get(route);
    } catch (e) {
      //print(e); // Debug info
      rethrow;
    }
  }
}
