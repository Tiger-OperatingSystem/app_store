import 'package:app_store/src/modules/main/widgets/logo.dart';
import 'package:app_store/src/modules/main/widgets/menu_tab.dart';
import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';

class HeaderWidget extends StatelessWidget implements PreferredSizeWidget {
  final WindowManager windowManager;
  final BuildContext context;
  const HeaderWidget(
      {super.key, required this.windowManager, required this.context});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: const LogoWidget(),
      title: Text(
        "Central de Programas",
        style: Theme.of(context).textTheme.titleSmall,
      ),
      bottom: const MenuTab(),
      flexibleSpace: GestureDetector(
        onDoubleTap: () => _maximize(windowManager),
      ),
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

  @override
  Size get preferredSize => const Size.fromHeight(120);
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
    if (await windowManager.isMaximized()) {
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
