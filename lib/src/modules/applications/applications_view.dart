// ignore_for_file: must_be_immutable

import 'package:app_store/src/core/navigation.dart';
import 'package:app_store/src/modules/applications/widgets/menu.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ApplicationsView extends StatelessWidget {
  String? searchAplication;
  ApplicationsView({
    super.key,
    this.searchAplication,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Row(
        children: [
          // Menu side
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.onInverseSurface),
              child: const MenuWidget(),
            ),
          ),
          // Content side
          Expanded(
            flex: 4,
            child: Padding(
              padding:
                  const EdgeInsets.only(left: 12.0, top: 12.0, right: 12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  context.watch<Navigation>().currentView,
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

final isSearch = ValueNotifier(false);

Widget _switch(bool isSearch, String searchAplication, BuildContext context) {
  try {
    if (isSearch) {
      return Center(child: Text(searchAplication));
    }

    return context.watch<Navigation>().currentView;
  } catch (e) {
    rethrow;
  }
}
