import 'package:app_store/src/modules/applications/applications_model.dart';
import 'package:flutter/material.dart';

class CardApplicationsWiget extends StatelessWidget {
  final ApplicationsModel applicationModel;
  const CardApplicationsWiget({super.key, required this.applicationModel});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 50),
            child: Image.network(
              applicationModel.iconDesktopUrl!,
              fit: BoxFit.scaleDown,
              width: MediaQuery.of(context).size.width / 15,
              height: MediaQuery.of(context).size.height / 15,
            ),
          ),
          Expanded(
            child: Text(applicationModel.name!,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                )),
          ),
          Expanded(
            child: SizedBox(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  applicationModel.summary!,
                  maxLines: 2,
                  style: TextStyle(
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ),
          ),
          Container(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                      elevation: 0,
                      foregroundColor: Theme.of(context).colorScheme.onPrimary,
                      backgroundColor: Theme.of(context).colorScheme.primary),
                  onPressed: () {},
                  icon: const Icon(Icons.download),
                  label: const Text("Instalar")),
            ),
          ),
        ],
      ),
    );
  }
}
