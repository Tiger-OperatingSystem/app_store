import 'package:app_store/src/modules/applications/widgets/items_menu.dart';
import 'package:flutter/material.dart';

class MenuWidget extends StatelessWidget {
  const MenuWidget({super.key});

  @override
  Widget build(BuildContext context) {
    List<Widget> menu = [
      const ItemMenuWidget(
        title: "Populares",
        endpoint: "collection/popular",
        icon: Icons.auto_graph,
      ), 
      const ItemMenuWidget(
        title: "Recem adicionados",
        endpoint: "collection/new",
        icon: Icons.celebration,
      ),
      const ItemMenuWidget(
        title: "Recem atualizados",
        endpoint: "collection/recently-updated",
        icon: Icons.history,
      ),
      const ItemMenuWidget(
        title: "Produtividade",
        endpoint: "category/Office",
        icon: Icons.work,
      ),
      const ItemMenuWidget(
        title: "Gráficos e Fotografia",
        endpoint: "category/Graphics",
        icon: Icons.photo,
      ),
      const ItemMenuWidget(
        title: "Áudio & Vídeo",
        endpoint: "category/AudioVideo",
        icon: Icons.multitrack_audio,
      ),
      const ItemMenuWidget(
        title: "Educação",
        endpoint: "category/Education",
        icon: Icons.book,
      ),
      const ItemMenuWidget(
        title: "Networking",
        endpoint: "category/Network",
        icon: Icons.work,
      ),
      const ItemMenuWidget(
        title: "Desenvolvimento",
        endpoint: "category/Development",
        icon: Icons.build,
      ),
      const ItemMenuWidget(
        title: "Ciência",
        endpoint: "category/Science",
        icon: Icons.biotech,
      ),
      const ItemMenuWidget(
        title: "Utilitários",
        endpoint: "category/Utility",
        icon: Icons.system_update_tv_outlined,
      ),
    ];

    return ListView.separated(
      itemCount: menu.length,
      separatorBuilder: (context, index) => const Divider(),
      itemBuilder: (context, index) {
        return menu[index];
      },
    );
  }
}
