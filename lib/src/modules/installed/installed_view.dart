import 'dart:io';
import 'package:app_store/src/modules/applications/flatpak/flatpak_controller.dart';
import 'package:app_store/src/modules/installed/flatpak/flatpak_installed_controller.dart';
import 'package:flutter/material.dart';

class InstalledView extends StatelessWidget {
  const InstalledView({super.key});

  @override
  Widget build(BuildContext context) {
    final installedController = FlatpakInstalledController();
    final flatpakController = FlatpakController();
    return FutureBuilder(
      future: installedController.build(context),
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
                File(applicationModel.iconDesktopUrl ?? ""),
              ),
              title: Text(applicationModel.name!),
              subtitle: Text(applicationModel.summary!),
              trailing: SizedBox(
                height: 40,
                child: ElevatedButton(
                    onPressed: () async {
                      await flatpakController.remove(applicationModel, context);
                    },
                    child: const Text("Remover")),
              ),
            );
          },
        );
      },
    );
  }
}
