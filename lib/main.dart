import 'package:app_store/src/core/navigation.dart';
import 'package:app_store/src/modules/applications/applications_controller.dart';
import 'package:process_run/shell.dart';
import 'package:provider/provider.dart';
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
    await windowManager.setTitle('Central de Programas');
    await windowManager.show();
    await windowManager.focus();
  });

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => Navigation()),
        ChangeNotifierProvider(create: (context) => ApplicationsController()),
      ],
      child: const AppWidget(),
    ),
  );
}

var shell = Shell();
