import 'dart:io';

import 'package:app_store/src/modules/applications/applications_controller.dart';
import 'package:app_store/src/modules/installed/installed_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class InstalledView extends StatelessWidget {
  const InstalledView({super.key});

  @override
  Widget build(BuildContext context) {
    final installedController = context.read<InstalledController>();
    List<ButtonSegment> segmentList = const [
      ButtonSegment(
        value: 0,
        icon: Icon(Icons.install_desktop),
        label: Text("Nativo")
        ),
      ButtonSegment(
        value: 1,
        icon: Icon(Icons.install_desktop),
        label: Text("Flatpak")
      ),
    ];

    return ListenableBuilder(
      listenable: context.watch<InstalledController>(),
      builder: (context, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: SegmentedButton(
                segments: segmentList, 
                selected: installedController.segmentSelected,
                onSelectionChanged: (value) => installedController.changeSegmentSelected(value, context)
              ),
            ),

            FutureBuilder(
              future: installedController.flatpakInstalled(context),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
            
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    final applicationModel = snapshot.data![index];
            
                    return ListTile(
                      leading: Image.file(
                        width: 35,
                        height: 35,
                        File(applicationModel.iconDesktopUrl!),
                      ),
                      title: Text(applicationModel.name!),
                      subtitle: Text(applicationModel.summary!),
                      trailing: SizedBox(
                        height: 40,
                        child: ElevatedButton(
                            onPressed: () {
                              context
                                  .read<ApplicationsController>()
                                  .removeFlatpak(applicationModel, context);
                            },
                            child: const Text("Remover")),
                      ),
                    );
                  },
                );
              },
            ),
          ],
        );
      },
    );
  }
}
