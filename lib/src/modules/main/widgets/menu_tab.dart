import 'package:flutter/material.dart';

class MenuTab extends StatelessWidget implements PreferredSizeWidget {
  const MenuTab({super.key});

  @override
  Widget build(BuildContext context) {
    return TabBar(tabs: List.generate(_menu.length, (index) => _menu[index]!));
  }

  @override
  Size get preferredSize => const Size.fromHeight(10);
}

Map<int, Widget> _menu = {
  //0: const Tab(icon: Icon(Icons.explore), text: "Descubra"),
  0: const Tab(icon: Icon(Icons.shopping_bag), text: "Programas"),
  1: const Tab(icon: Icon(Icons.cloud_download_rounded), text: "Instalados"),
};
