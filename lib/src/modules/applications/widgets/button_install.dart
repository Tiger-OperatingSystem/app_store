import 'package:app_store/src/modules/applications/applications_controller.dart';
import 'package:app_store/src/modules/applications/applications_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ButtonInstallWidget extends StatelessWidget {
  final ApplicationsModel applicationModel;
  const ButtonInstallWidget({super.key, required this.applicationModel});

  @override
  Widget build(BuildContext context) {
    final applicationsController = context.read<ApplicationsController>();
    return ListenableBuilder(
              listenable: context.watch<ApplicationsController>(),
              builder: (context, child) {
                return FutureBuilder(
                  future: Future.wait([applicationsController
                      .hasInstalledFlatpak(applicationModel), 
                      applicationsController
                      .hasInstalledDebian(applicationModel, context),
                      applicationsController
                      .isDebianPackage(applicationModel, context)]),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    final hasInstalledFlatpak = snapshot.data![0];
                    final hasInstalledDebian = snapshot.data![1];
                    final isDebianPackage = snapshot.data![2];

                    return Row(
                      children: [
                        
                        Visibility(
                          visible: isDebianPackage ? true : false,
                          child: ElevatedButton.icon(
                            icon: !hasInstalledDebian
                                ? const Icon(Icons.download)
                                : const Icon(Icons.delete),
                            onPressed: () => _installOrRemove(
                              applicationModel,
                              hasInstalledFlatpak,
                              applicationsController,
                            ),
                            label: Text("Nativo",
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                          ),
                        ),

                        ElevatedButton.icon(
                          icon: !hasInstalledFlatpak
                              ? const Icon(Icons.download)
                              : const Icon(Icons.delete),
                          onPressed: () => _installOrRemove(
                            applicationModel,
                            hasInstalledFlatpak,
                            applicationsController,
                          ),
                          label: Text("Flatpak",
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ),
                      ]
                    );
                  },
                );
              },
            );
  }
}

void _installOrRemove(ApplicationsModel applicationsModel, bool hasInstalled,
    ApplicationsController applicationsController) {
  try {
    if (!hasInstalled) {
      applicationsController.installFlatpak(applicationsModel);
    } else {
      applicationsController.removeFlatpak(applicationsModel);
    }
  } catch (e) {
    rethrow;
  }
}