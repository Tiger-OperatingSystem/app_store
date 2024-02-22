import 'package:app_store/src/core/cache.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedCacheRepository extends Cache {
  @override
  Future read(String key) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      //await prefs.clear();
      return prefs.getString(key);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> remove(String key) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(key);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> save(String key, String data) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final expiration = DateTime.now().add(const Duration(days: 7));
      await prefs.setString('expiration', expiration.toIso8601String());
      await prefs.setString(key, data);
    } catch (e) {
      rethrow;
    }
  }
}
