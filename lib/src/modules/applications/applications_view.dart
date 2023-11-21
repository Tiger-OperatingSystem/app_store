// ignore_for_file: must_be_immutable

import 'package:app_store/src/core/navigation.dart';
import 'package:app_store/src/modules/applications/applications_controller.dart';
import 'package:app_store/src/modules/applications/widgets/menu.dart';
import 'package:app_store/src/modules/main/widgets/search_package.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ApplicationsView extends StatelessWidget {
  const ApplicationsView({
    super.key,
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
                  SearchPackageWidget(onPressed: (value) {
                    ApplicationsController.search(value, context);
                  }),
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
