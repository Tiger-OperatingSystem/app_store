import 'package:app_store/src/modules/applications/applications_controller.dart';
import 'package:app_store/src/modules/applications/applications_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HeaderApplicationDetailWidget extends StatelessWidget {
  final ApplicationsModel applicationModel;
  const HeaderApplicationDetailWidget({
    super.key,
    required this.applicationModel,
  });

  @override
  Widget build(BuildContext context) {
    final applicationsController = context.read<ApplicationsController>();
    return Container(
      padding: const EdgeInsets.all(22),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Space
          const Expanded(child: SizedBox.shrink()),
          Image.network(
            applicationModel.iconDesktopUrl!,
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                applicationModel.name!,
                style: Theme.of(context).textTheme.displayLarge,
              ),
              Text(
                "por ${applicationModel.developerName ?? "Nenhum"}",
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ],
          ),

          // Space
          const Expanded(child: SizedBox.shrink()),
          SizedBox(
            height: 80,
            width: 220,
            child: ListenableBuilder(
              listenable: context.watch<ApplicationsController>(),
              builder: (context, child) {
                return FutureBuilder(
                  future: applicationsController.hasInstalled(applicationModel),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    final hasInstalled = snapshot.data!;

                    return ElevatedButton.icon(
                      icon: !hasInstalled
                          ? const Icon(Icons.download)
                          : const Icon(Icons.delete),
                      onPressed: () => _installOrRemove(
                        applicationModel,
                        hasInstalled,
                        applicationsController,
                      ),
                      label: Text(
                        !hasInstalled ? "Instalar" : "Remover",
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    );
                  },
                );
              },
            ),
          ),

          // Space
          const Expanded(child: SizedBox.shrink()),
        ],
      ),
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
