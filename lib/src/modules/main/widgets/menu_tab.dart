import 'package:flutter/material.dart';

class MenuTab extends StatelessWidget implements PreferredSizeWidget {
  const MenuTab({super.key});

  @override
  Widget build(BuildContext context) {
    return TabBar(tabs: List.generate(_menu.length, (index) => _menu[index]!));
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(10);
}

Map<int, Widget> _menu = {
  0: Tab(icon: Icon(Icons.explore), text: "Descubra"),
  1: Tab(icon: Icon(Icons.shopping_bag), text: "Programas"),
  2: Tab(icon: Icon(Icons.cloud_download_rounded), text: "Instaladas"),
};
