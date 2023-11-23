// ignore_for_file: use_build_context_synchronously

import 'package:app_store/main.dart';
import 'package:app_store/src/core/navigation.dart';
import 'package:app_store/src/modules/applications/applications_controller.dart';
import 'package:app_store/src/modules/applications/applications_model.dart';
import 'package:app_store/src/modules/applications/applications_details_view.dart';
import 'package:flutter/material.dart';

class CardApplicationsWiget extends StatelessWidget {
  final ApplicationsModel applicationModel;
  const CardApplicationsWiget({super.key, required this.applicationModel});

  @override
  Widget build(BuildContext context) {
    final hasInstalled = ApplicationsController.hasInstalled(
        applicationModel, installedApplications);
    return GestureDetector(
      onTap: () => _details(applicationModel, context),
      child: Card(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Image.network(applicationModel.iconDesktopUrl!,
                        width: 50, height: 50),
                  ),
                  Expanded(
                    flex: 2,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(applicationModel.name!,
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.primary,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            )),
                        SizedBox(
                          child: Text(
                            applicationModel.summary!,
                            maxLines: 2,
                            style: const TextStyle(
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(12),
                            bottomRight: Radius.circular(12))),
                    elevation: 0,
                    foregroundColor: !hasInstalled
                        ? Theme.of(context).colorScheme.onPrimary
                        : Theme.of(context).colorScheme.onErrorContainer,
                    backgroundColor: !hasInstalled
                        ? Theme.of(context).colorScheme.primary
                        : Theme.of(context).colorScheme.errorContainer),
                onPressed: () {},
                icon: Icon(!hasInstalled ? Icons.download : Icons.delete),
                label: Text(!hasInstalled ? "Instalar" : "Remover")),
          ],
        ),
      ),
    );
  }
}

Future<void> _details(
    ApplicationsModel applicationsModel, BuildContext context) async {
  try {
    Navigation.push(
        ApplicationsDetailsView(applicationsModel: applicationsModel), context);
  } catch (e) {
    rethrow;
  }
}
