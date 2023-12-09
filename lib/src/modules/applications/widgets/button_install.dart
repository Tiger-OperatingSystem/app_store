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
                      .hasInstalledFlatpak(applicationModel, context), 
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
                      mainAxisSize: MainAxisSize.max,
                      children: [

                        Visibility(
                          visible: isDebianPackage ? true : false,
                          child: SizedBox(
                            height: 80,
                            child: ElevatedButton.icon(
                              icon: !hasInstalledDebian
                                  ? const Icon(Icons.download)
                                  : const Icon(Icons.delete),
                              onPressed: () => _installOrRemoveDebianPackage(
                                applicationModel,
                                hasInstalledFlatpak,
                                applicationsController,
                                context,
                              ),
                              label: Text(!hasInstalledDebian ? "Installar nativo" : "Desinstalar nativo",
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(width: 15),

                        SizedBox(
                          height: 80,
                          child: ElevatedButton.icon(
                            icon: !hasInstalledFlatpak
                                ? const Icon(Icons.download)
                                : const Icon(Icons.delete),
                            onPressed: () => _installOrRemoveFlatpak(
                              applicationModel,
                              hasInstalledDebian,
                              applicationsController,
                              context,
                            ),
                            label: Text(!hasInstalledFlatpak ? "Installar flatpak" : "Desinstalar flatpak",
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
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

void _installOrRemoveFlatpak(ApplicationsModel applicationsModel, bool hasInstalled,
    ApplicationsController applicationsController, BuildContext context) {
  try {
    if (!hasInstalled) {
      applicationsController.installFlatpak(applicationsModel, context);
    } else {
      applicationsController.removeFlatpak(applicationsModel, context);
    }
  } catch (e) {
    rethrow;
  }
}

void _installOrRemoveDebianPackage(ApplicationsModel applicationsModel, bool hasInstalled,
    ApplicationsController applicationsController, BuildContext context) {
  try {
    if (!hasInstalled) {
      applicationsController.installDebianPackage(applicationsModel, context);
    } else {
      applicationsController.removeDebianPackage(applicationsModel, context);
    }
  } catch (e) {
    rethrow;
  }
}