import 'package:flutter/material.dart';

abstract class Cache extends ChangeNotifier {
  Future read(String key);
  Future<void> save(String key, String data);
  Future<void> remove(String key);
}
