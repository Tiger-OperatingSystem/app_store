import 'package:app_store/src/modules/applications/applications_controller.dart';
import 'package:app_store/src/modules/applications/applications_model.dart';
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

        print(snapshot.data);

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
            onPressed: () {},
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
