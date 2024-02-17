import 'package:app_store/src/modules/applications/applications_controller.dart';
import 'package:app_store/src/modules/applications/applications_model.dart';
import 'package:app_store/src/modules/applications/deb/debian_controller.dart';
import 'package:app_store/src/modules/applications/flatpak/flatpak_controller.dart';
import 'package:app_store/src/modules/applications/webapps/webapps_controller.dart';
import 'package:app_store/src/modules/applications/widgets/dropdown_available.dart';
import 'package:flutter/material.dart';

class HeaderApplicationDetailWidget extends StatelessWidget {
  final ApplicationsModel applicationModel;
  HeaderApplicationDetailWidget({
    super.key,
    required this.applicationModel,
  });

  final List<ApplicationsController> _controllers = [
    FlatpakController(),
    DebianController(),
    WebAppController(),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(22),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Space
          const Expanded(child: SizedBox.shrink()),
          Image.network(applicationModel.iconDesktopUrl!,
              height: 64.0, width: 64.0),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                applicationModel.name!,
                style: Theme.of(context).textTheme.displayLarge,
              ),
              Text(
                "por ${applicationModel.developerName ?? "Desconhecido"}",
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ],
          ),

          // Space
          const Expanded(child: SizedBox.shrink()),
          SizedBox(
            child: DropdownAvailableWidget(
              applicationModel: applicationModel,
              applicationsController: _controllers,
            ),
          ),
          // Space
          const Expanded(child: SizedBox.shrink()),
        ],
      ),
    );
  }
}
