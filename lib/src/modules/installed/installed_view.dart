import 'dart:io';

import 'package:app_store/src/modules/applications/applications_controller.dart';
import 'package:app_store/src/modules/installed/installed_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class InstalledView extends StatelessWidget {
  const InstalledView({super.key});

  @override
  Widget build(BuildContext context) {
    final installedController = InstalledController();

    return ListenableBuilder(
      listenable: context.watch<ApplicationsController>(),
      builder: (context, child) {
        return FutureBuilder(
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
        );
      },
    );
  }
}
