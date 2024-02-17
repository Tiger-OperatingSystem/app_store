import 'package:app_store/src/modules/applications/applications_controller.dart';
import 'package:app_store/src/modules/applications/applications_model.dart';
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

class _DropdownAvailableWidgetState extends State<DropdownAvailableWidget> {
  late String dropdownValue = _list.first;
  late Future<List> waits;

  @override
  void initState() {
    waits = Future.wait(
        List.generate(widget.applicationsController.length, (index) {
      return widget.applicationsController[index]
          .isAvailable(widget.applicationModel, context);
    }));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _list = [];
    return FutureBuilder(
      future: waits,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        bool isAvailableFlatpak = snapshot.data![0];
        bool isAvailableDebian = snapshot.data![1];

        if (isAvailableFlatpak) {
          _list.add("Flatpak");
        }

        if (isAvailableDebian) {
          _list.add("Debian");
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
          ],
        );
      },
    );
  }
}
