import 'package:app_store/src/modules/applications/applications_model.dart';
import 'package:app_store/src/modules/applications/flatpak/flatpak_controller.dart';
import 'package:app_store/src/modules/applications/widgets/header_detail.dart';
import 'package:app_store/src/modules/applications/widgets/screenshots_detail.dart';
import 'package:flutter/material.dart';

class ApplicationsDetailsView extends StatelessWidget {
  final ApplicationsModel applicationsModel;
  const ApplicationsDetailsView({super.key, required this.applicationsModel});

  @override
  Widget build(BuildContext context) {
    final flatkpakController = FlatpakController();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Voltar"),
      ),

      // Build app details
      body: FutureBuilder(
        future: flatkpakController.getById(
            applicationsModel.flatpakAppId!, context),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          final applicationModel = snapshot.data;

          return SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: ListView(
              children: [
                HeaderApplicationDetailWidget(
                    applicationModel: applicationModel!),
                ScrenshootApplicationDetailWidget(
                    applicationModel: applicationModel),
                Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: Text(
                    applicationModel.summary!,
                    style: Theme.of(context).textTheme.displaySmall,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(32),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primaryContainer,
                  ),
                  child: Text(
                    applicationModel.description!
                        .replaceAll(RegExp(r'<[^>]*>'), ""),
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
