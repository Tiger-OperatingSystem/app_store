// ignore_for_file: must_be_immutable

import 'package:app_store/src/modules/applications/flatpak/flatpak_controller.dart';
import 'package:app_store/src/modules/applications/widgets/menu.dart';
import 'package:app_store/src/modules/applications/widgets/search_package.dart';
import 'package:app_store/src/store/navigation_store.dart';
import 'package:flutter/material.dart';

class ApplicationsMainView extends StatefulWidget {
  const ApplicationsMainView({
    super.key,
  });

  @override
  State<ApplicationsMainView> createState() => _ApplicationsMainViewState();
}

class _ApplicationsMainViewState extends State<ApplicationsMainView> {
  @override
  Widget build(BuildContext context) {
    final flatpakController = FlatpakController();
    return SizedBox(
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
              child: ListenableBuilder(
                listenable: currentView,
                builder: (context, child) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SearchPackageWidget(
                        onPressed: (value) {
                          flatpakController.search(value, context);
                        },
                      ),

                      // View
                      currentView.value,
                    ],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
