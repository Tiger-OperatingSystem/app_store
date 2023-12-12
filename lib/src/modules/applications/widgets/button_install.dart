import 'package:app_store/src/modules/applications/applications_controller.dart';
import 'package:app_store/src/modules/applications/applications_model.dart';
import 'package:flutter/material.dart';

class ButtonInstallWidget extends StatefulWidget {
  final ApplicationsModel applicationModel;
  const ButtonInstallWidget({super.key, required this.applicationModel});

  @override
  State<ButtonInstallWidget> createState() => _ButtonInstallWidgetState();
}

late List<String> _list;

class _ButtonInstallWidgetState extends State<ButtonInstallWidget> {
  final applicationsController = ApplicationsController();
  String dropdownValue = _list.first;
  late Future<List> waits;

  @override
  void initState() {
    waits = Future.wait([applicationsController
                      .hasInstalledFlatpak(widget.applicationModel, context), 
                      applicationsController
                      .hasInstalledDebian(widget.applicationModel, context),
                      applicationsController
                      .isDebianPackage(widget.applicationModel, context)]);
    super.initState();
  }
     
  @override
  Widget build(BuildContext context) {
      return FutureBuilder(
        future: waits,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          bool hasInstalledFlatpak = snapshot.data![0];
          bool hasInstalledDebian = snapshot.data![1];
          bool isDebianPackage = snapshot.data![2];

          _list  = [];

          if(!isDebianPackage) {
            _list.add("Flatpak");
          } else {
            _list.addAll(["Nativo", "Flatpak"]);
          }

          return Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              DropdownMenu(
                inputDecorationTheme: InputDecorationTheme(
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12),
                      bottomLeft: Radius.circular(12)
                    )
                  ),
                  fillColor: Theme.of(context).colorScheme.onSecondary,
                  filled: true
                ),
                initialSelection: _list.first,
                onSelected: (value) {
                  setState(() {
                    dropdownValue = value!;
                  });
                },
                dropdownMenuEntries: _list.map((value) {
                  return DropdownMenuEntry(
                    value: value, 
                    label: value);
                }).toList(),
              ),

              SizedBox(
                height: 60,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(12),
                        bottomRight: Radius.circular(12)
                        )
                    )
                  ),
                  onPressed: (){
                    if(dropdownValue != "Nativo") {
                      return _installOrRemoveFlatpak(
                        widget.applicationModel, 
                        hasInstalledFlatpak, 
                        applicationsController, context);
                    }

                    return _installOrRemoveDebianPackage(
                      widget.applicationModel, 
                      hasInstalledDebian, 
                      applicationsController, context);
                  }, 
                  child: Text(_installOrUninstall([hasInstalledDebian, hasInstalledFlatpak], dropdownValue)))),
            ],
          );
        },
      );           
  }
}

String _installOrUninstall(List<bool> hasInstalled, String selected) {
  String installOrUninstall = "Instalar";
  if(selected == "Nativo") {
    if(hasInstalled[0]) {
      installOrUninstall = "Desinstalar";
    }

    return installOrUninstall;
  }

  if(selected == "Flatpak") {
    if(hasInstalled[1]) {
      installOrUninstall = "Desinstalar";
    }

    return installOrUninstall;
  }

  return installOrUninstall;

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