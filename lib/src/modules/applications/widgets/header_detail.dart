import 'package:app_store/src/modules/applications/applications_model.dart';
import 'package:app_store/src/modules/applications/widgets/button_install.dart';
import 'package:flutter/material.dart';

class HeaderApplicationDetailWidget extends StatelessWidget {
  final ApplicationsModel applicationModel;
  const HeaderApplicationDetailWidget({
    super.key,
    required this.applicationModel,
  });

  @override
  Widget build(BuildContext context) {
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

          ButtonInstallWidget(applicationModel: applicationModel),
          
          // Space
          const Expanded(child: SizedBox.shrink()),
        ],
      ),
    );
  }
}
