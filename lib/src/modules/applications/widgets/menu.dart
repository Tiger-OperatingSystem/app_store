
import 'package:app_store/src/modules/applications/categories/development_view.dart';
import 'package:app_store/src/modules/applications/categories/education_view.dart';
import 'package:app_store/src/modules/applications/categories/graphics_view.dart';
import 'package:app_store/src/modules/applications/categories/networking_view.dart';
import 'package:app_store/src/modules/applications/categories/new_view.dart';
import 'package:app_store/src/modules/applications/categories/office_view.dart';
import 'package:app_store/src/modules/applications/categories/popular_view.dart';
import 'package:app_store/src/modules/applications/categories/recently_updated_view.dart';
import 'package:app_store/src/modules/applications/categories/science_view.dart';
import 'package:app_store/src/modules/applications/categories/utility_view.dart';
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
      4:  const ItemMenuWidget(
        title: "Gráficos e Fotografia",
        page: CategoriesGraphicsView(),
        icon: Icons.photo,
      ),
      5: const ItemMenuWidget(
        title: "Educação",
        page: CategoriesEducationView(),
        icon: Icons.book,
      ),
      6: const ItemMenuWidget(
        title: "Networking",
        page: CategoriesNetworkingView(),
        icon: Icons.work,
      ),
      7: const ItemMenuWidget(
        title: "Desenvolvimento",
        page: CategoriesDevelopmentView(),
        icon: Icons.build,
      ),
      8: const ItemMenuWidget(
        title: "Ciência",
        page: CategoriesScienceView(),
        icon: Icons.biotech,
      ),
      9: const ItemMenuWidget(
        title: "Utilitários",
        page: CategoriesUtilityView(),
        icon: Icons.system_update_tv_outlined,
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
