import 'package:app_store/src/modules/applications/applications_controller.dart';
import 'package:app_store/src/modules/applications/applications_model.dart';
import 'package:app_store/src/modules/applications/deb/debian_controller.dart';
import 'package:app_store/src/modules/applications/flatpak/flatpak_controller.dart';
import 'package:app_store/src/modules/applications/webapps/webapps_controller.dart';
import 'package:flutter/material.dart';

class ButtonInstallWidget extends StatefulWidget {
  final List<String> availables;
  final List<ApplicationsController> applicationsController;
  final ApplicationsModel applicationsModel;
  final String selected;
  const ButtonInstallWidget({
    super.key,
    required this.availables,
    required this.applicationsController,
    required this.applicationsModel,
    required this.selected,
  });

  @override
  State<ButtonInstallWidget> createState() => _ButtonInstallWidgetState();
}

late Future<List<bool>> hasInstalled;

class _ButtonInstallWidgetState extends State<ButtonInstallWidget> {
  @override
  void initState() {
    hasInstalled = Future.wait(List.generate(
        widget.applicationsController.length,
        (index) => widget.applicationsController[index]
            .hasInstalled(widget.applicationsModel, context)));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: hasInstalled,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        List<bool> installeds = List.generate(
            snapshot.data!.length, (index) => snapshot.data![index]);

        return SizedBox(
          height: 60,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(12),
                        bottomRight: Radius.circular(12)))),
            onPressed: () => _installOrUninstall(
                widget.applicationsController,
                widget.applicationsModel,
                snapshot.data!,
                widget.selected,
                context),
            child: Text(_chooseTextButton(installeds, widget.selected)),
          ),
        );
      },
    );
  }
}

String _chooseTextButton(List<bool> hasInstalled, String selected) {
  late String value;
  switch (selected) {
    case "Flatpak":
      if (hasInstalled[0] != true) {
        value = "Instalar";
      } else {
        value = "Desinstalar";
      }
    case "Debian":
      if (hasInstalled[1] != true) {
        value = "Instalar";
      } else {
        value = "Desinstalar";
      }
    case "WebApp":
      if (hasInstalled[2] != true) {
        value = "Instalar";
      } else {
        value = "Desinstalar";
      }
  }

  return value;
}

void _installOrUninstall(
    List<ApplicationsController> applicationsController,
    ApplicationsModel applicationsModel,
    List<bool> hasInstalled,
    String selected,
    BuildContext context) {
  for (var controller in applicationsController) {
    if (controller is FlatpakController && selected == "Flatpak") {
      if (hasInstalled[0] != true) {
        controller.install(applicationsModel, context);
      } else {
        controller.remove(applicationsModel, context);
      }
    }

    if (controller is DebianController && selected == "Debian") {
      if (hasInstalled[1] != true) {
        controller.install(applicationsModel, context);
      } else {
        controller.remove(applicationsModel, context);
      }
    }

    if (controller is WebAppController && selected == "WebApp") {
      if (hasInstalled[2] != true) {
        controller.install(applicationsModel, context);
      } else {
        controller.remove(applicationsModel, context);
      }
    }
  }
}
