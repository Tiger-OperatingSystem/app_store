import 'package:app_store/src/core/navigation.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void setup() {
  getIt.registerSingleton<Navigation>(Navigation());
}
