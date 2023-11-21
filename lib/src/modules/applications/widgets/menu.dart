import 'package:app_store/src/modules/applications/widgets/items_menu.dart';
import 'package:flutter/material.dart';

class MenuWidget extends StatelessWidget {
  const MenuWidget({super.key});

  @override
  Widget build(BuildContext context) {
    Map<int, Widget> menu = {
      0: const ItemMenuWidget(
        title: "Populares",
        endpoint: "collection/popular",
        icon: Icons.auto_graph,
      ),
      1: const ItemMenuWidget(
        title: "Recem adicionados",
        endpoint: "collection/new",
        icon: Icons.celebration,
      ),
      2: const ItemMenuWidget(
        title: "Recem atualizados",
        endpoint: "collection/recently-updated",
        icon: Icons.history,
      ),
      3: const ItemMenuWidget(
        title: "Produtividade",
        endpoint: "category/Office",
        icon: Icons.work,
      ),
      4: const ItemMenuWidget(
        title: "Gráficos e Fotografia",
        endpoint: "category/Graphics",
        icon: Icons.photo,
      ),
      5: const ItemMenuWidget(
        title: "Educação",
        endpoint: "category/Education",
        icon: Icons.book,
      ),
      6: const ItemMenuWidget(
        title: "Networking",
        endpoint: "category/Network",
        icon: Icons.work,
      ),
      7: const ItemMenuWidget(
        title: "Desenvolvimento",
        endpoint: "category/Development",
        icon: Icons.build,
      ),
      8: const ItemMenuWidget(
        title: "Ciência",
        endpoint: "category/Science",
        icon: Icons.biotech,
      ),
      9: const ItemMenuWidget(
        title: "Utilitários",
        endpoint: "category/Utility",
        icon: Icons.system_update_tv_outlined,
      ),
    };

    return ListView.separated(
      itemCount: menu.length,
      separatorBuilder: (context, index) => const Divider(),
      itemBuilder: (context, index) {
        return menu[index];
      },
    );
  }
}
