import 'package:app_store/src/injector.dart';
import 'package:process_run/shell.dart';
import 'package:window_manager/window_manager.dart';
import 'package:app_store/app_widget.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await windowManager.ensureInitialized();

  WindowOptions windowOptions = const WindowOptions(
    center: true,
    skipTaskbar: false,
    titleBarStyle: TitleBarStyle.hidden,
  );

  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.setTitle('Tiger Store');
    await windowManager.show();
    await windowManager.focus();
  });

  // Injectors
  setup();

  runApp(const AppWidget());
}

var shell = Shell();
