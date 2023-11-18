import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';

class HeaderWidget {
  static PreferredSizeWidget build(BuildContext context, 
  WindowManager windowManager) {
    return AppBar(
      actions: [
        Container(
          alignment: Alignment.topCenter,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                onPressed: () async => _minimize(windowManager), 
                icon: const Icon(Icons.minimize), 
                iconSize: 16, 
                constraints: const BoxConstraints(minWidth: 5)),
              IconButton(
                onPressed: () async => await _maximize(windowManager), 
                icon: const Icon(Icons.rectangle_outlined), 
                iconSize: 16, 
                constraints: const BoxConstraints(minWidth: 5)),
              IconButton(
                onPressed: () async => await _close(windowManager), 
                icon: const Icon(Icons.close), 
                iconSize: 16, 
                constraints: const BoxConstraints(minWidth: 5)),
            ],
          ),
        )
      ],
    );
  }
}

Future<void> _minimize(WindowManager windowManager) async {
  try {
    await windowManager.minimize();
  } catch (e) {
    rethrow;
  }
}

Future<void> _maximize(WindowManager windowManager) async {
  try {
    if(await windowManager.isMaximized()) {
      await windowManager.unmaximize();
    } else {
      await windowManager.maximize();
    }
  } catch (e) {
    rethrow;
  }
}

Future<void> _close(WindowManager windowManager) async {
  try {
    await windowManager.close();
  } catch (e) {
    rethrow;
  }
}