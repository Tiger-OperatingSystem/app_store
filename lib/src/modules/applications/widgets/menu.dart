
import 'package:app_store/src/modules/applications/categories/new_view.dart';
import 'package:app_store/src/modules/applications/categories/office_view.dart';
import 'package:app_store/src/modules/applications/categories/popular_view.dart';
import 'package:app_store/src/modules/applications/categories/recently_updated_view.dart';
import 'package:app_store/src/modules/applications/widgets/items_menu.dart';
import 'package:flutter/material.dart';

class MenuWidget extends StatelessWidget {
  const MenuWidget({super.key});

  @override
  Widget build(BuildContext context) {
    Map<int, Widget> menu = {
      0: const ItemMenuWidget(
        title: "Populares",
        page: CategoriesPopularView(),
        icon: Icons.auto_graph,
      ),
      1: const ItemMenuWidget(
        title: "Recem adicionados",
        page: CategoriesNewView(),
        icon: Icons.celebration,
      ),
      2: const ItemMenuWidget(
        title: "Recem atualizados",
        page: CategoriesRecentlyUpdatedView(),
        icon: Icons.history,
      ),
      3: const ItemMenuWidget(
        title: "Produtividade",
        page: CategoriesOfficeView(),
        icon: Icons.work,
      ),
      4: ListTile(
        leading: CircleAvatar(
          maxRadius: 16,
          backgroundColor: Theme.of(context).colorScheme.primary,
          foregroundColor: Theme.of(context).colorScheme.onPrimary,
          child: const Icon(Icons.photo_album, size: 18),
        ),
        title: const Text("Gráficos & Fotografia",
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
        onTap: () {},
      ),
      5: ListTile(
        leading: CircleAvatar(
          maxRadius: 16,
          backgroundColor: Theme.of(context).colorScheme.primary,
          foregroundColor: Theme.of(context).colorScheme.onPrimary,
          child: const Icon(Icons.book, size: 18),
        ),
        title: const Text("Educação",
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
        onTap: () {},
      ),
      6: ListTile(
        leading: CircleAvatar(
          maxRadius: 16,
          backgroundColor: Theme.of(context).colorScheme.primary,
          foregroundColor: Theme.of(context).colorScheme.onPrimary,
          child: const Icon(Icons.interests_rounded, size: 18),
        ),
        title: const Text("Networking",
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
        onTap: () {},
      ),
      7: ListTile(
        leading: CircleAvatar(
          maxRadius: 16,
          backgroundColor: Theme.of(context).colorScheme.primary,
          foregroundColor: Theme.of(context).colorScheme.onPrimary,
          child: const Icon(Icons.work, size: 18),
        ),
        title: const Text("Desenvolvimento",
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
        onTap: () {},
      ),
      8: ListTile(
        leading: CircleAvatar(
          maxRadius: 16,
          backgroundColor: Theme.of(context).colorScheme.primary,
          foregroundColor: Theme.of(context).colorScheme.onPrimary,
          child: const Icon(Icons.biotech, size: 18),
        ),
        title: const Text("Ciência",
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
        onTap: () {},
      ),
      9: ListTile(
        leading: CircleAvatar(
          maxRadius: 16,
          backgroundColor: Theme.of(context).colorScheme.primary,
          foregroundColor: Theme.of(context).colorScheme.onPrimary,
          child: const Icon(Icons.system_update_tv_outlined, size: 18),
        ),
        title: const Text("Utiliitários",
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
        onTap: () {},
      ),
    };

    return ListView.separated(
      itemCount: menu.length,
      separatorBuilder: (context, index) => Divider(),
      itemBuilder: (context, index) {
        return menu[index];
      },
    );
  }
}
