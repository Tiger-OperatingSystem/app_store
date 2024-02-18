import 'package:app_store/src/core/navigation.dart';
import 'package:app_store/src/injector.dart';
import 'package:app_store/src/modules/applications/widgets/build_applications.dart';
import 'package:flutter/material.dart';

class ItemMenuWidget extends StatelessWidget {
  final String title;
  final String endpoint;
  final IconData icon;
  const ItemMenuWidget({
    super.key,
    required this.title,
    required this.endpoint,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final navigation = getIt.get<Navigation>();
    return ListTile(
      leading: Icon(
        icon,
        size: 18,
        color: Theme.of(context).colorScheme.primary,
      ),
      title: Text(title,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
      onTap: () => navigation.pageView(
          BuildApplicationsWidget(endpoint: endpoint), context),
    );
  }
}
