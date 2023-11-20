import 'package:app_store/src/core/navigation.dart';
import 'package:app_store/src/modules/applications/categories/new_view.dart';
import 'package:app_store/src/modules/applications/categories/popular_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MenuWidget extends StatelessWidget {
  const MenuWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final navigation = context.read<Navigation>();
    Map<int, Widget> menu = {
      0: ListTile(
        leading: CircleAvatar(
          maxRadius: 16,
          backgroundColor: Theme.of(context).colorScheme.primary,
          foregroundColor: Theme.of(context).colorScheme.onPrimary,
          child: const Icon(Icons.auto_graph_rounded, size: 18),
        ),
        title: const Text("Populares",
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
        onTap: () =>
            navigation.pageView(const CategoriesPopularView(), context),
      ),
      1: ListTile(
        leading: CircleAvatar(
          maxRadius: 16,
          backgroundColor: Theme.of(context).colorScheme.primary,
          foregroundColor: Theme.of(context).colorScheme.onPrimary,
          child: const Icon(Icons.celebration_outlined, size: 18),
        ),
        title: const Text("Recem adicionados",
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
        onTap: () => navigation.pageView(const CategoriesNewView(), context),
      ),
      2: ListTile(
          leading: CircleAvatar(
            maxRadius: 16,
            backgroundColor: Theme.of(context).colorScheme.primary,
            foregroundColor: Theme.of(context).colorScheme.onPrimary,
            child: const Icon(Icons.update, size: 18),
          ),
          title: const Text("Recem atualizados",
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
          onTap: () {}),
      3: ListTile(
        leading: CircleAvatar(
          maxRadius: 16,
          backgroundColor: Theme.of(context).colorScheme.primary,
          foregroundColor: Theme.of(context).colorScheme.onPrimary,
          child: const Icon(Icons.work, size: 18),
        ),
        title: const Text("Produtividade",
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
        onTap: () {},
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
