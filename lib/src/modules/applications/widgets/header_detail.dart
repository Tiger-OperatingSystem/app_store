import 'package:app_store/main.dart';
import 'package:app_store/src/modules/applications/applications_controller.dart';
import 'package:app_store/src/modules/applications/applications_model.dart';
import 'package:flutter/material.dart';

class HeaderApplicationDetailWidget extends StatelessWidget {
  final ApplicationsModel applicationModel;
  const HeaderApplicationDetailWidget({
    super.key,
    required this.applicationModel,
  });

  @override
  Widget build(BuildContext context) {
    final hasInstalled = ApplicationsController.hasInstalled(
        applicationModel, installedApplications);
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
            child: ElevatedButton.icon(
                icon: !hasInstalled
                    ? const Icon(Icons.download)
                    : const Icon(Icons.delete),
                onPressed: () => _installOrRemove(
                      applicationModel,
                      hasInstalled,
                    ),
                label: Text(
                  !hasInstalled ? "Instalar" : "Remover",
                  style: Theme.of(context).textTheme.titleMedium,
                )),
          ),

          // Space
          const Expanded(child: SizedBox.shrink()),
        ],
      ),
    );
  }
}

void _installOrRemove(ApplicationsModel applicationsModel, bool hasInstalled) {
  try {
    if (!hasInstalled) {
      ApplicationsController.installFlatpak(applicationsModel);
    } else {
      ApplicationsController.removeFlatpak(applicationsModel);
    }
  } catch (e) {
    rethrow;
  }
}
