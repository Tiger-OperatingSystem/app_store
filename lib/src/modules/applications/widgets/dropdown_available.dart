import 'package:app_store/src/modules/applications/applications_controller.dart';
import 'package:app_store/src/modules/applications/applications_model.dart';
import 'package:app_store/src/modules/applications/flatpak/flatpak_controller.dart';
import 'package:app_store/src/modules/applications/widgets/button_install.dart';
import 'package:flutter/material.dart';

class DropdownAvailableWidget extends StatefulWidget {
  final ApplicationsModel applicationModel;
  final List<ApplicationsController> applicationsController;
  const DropdownAvailableWidget(
      {super.key,
      required this.applicationModel,
      required this.applicationsController});

  @override
  State<DropdownAvailableWidget> createState() =>
      _DropdownAvailableWidgetState();
}

List<String> _list = [""];
late Future<List<bool>> waits;
String dropdownValue = _list.first;

class _DropdownAvailableWidgetState extends State<DropdownAvailableWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _list = [];
    final flatpakController = FlatpakController();
    return FutureBuilder(
      future: flatpakController.isAvailable(widget.applicationModel, context),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        bool isAvailableFlatpak = snapshot.data!;

        if (isAvailableFlatpak) {
          _list.add("Flatpak");
        }

        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            DropdownMenu(
              inputDecorationTheme: InputDecorationTheme(
                  border: const OutlineInputBorder(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(12),
                          bottomLeft: Radius.circular(12))),
                  fillColor: Theme.of(context).colorScheme.onSecondary,
                  filled: true),
              initialSelection: _list.first,
              onSelected: (value) {
                setState(() {
                  dropdownValue = value!;
                });
              },
              dropdownMenuEntries: _list.map((value) {
                return DropdownMenuEntry(value: value, label: value);
              }).toList(),
            ),
            ButtonInstallWidget(
              availables: _list,
              applicationsController: widget.applicationsController,
              applicationsModel: widget.applicationModel,
              selected: dropdownValue,
            ),
          ],
        );
      },
    );
  }
}
