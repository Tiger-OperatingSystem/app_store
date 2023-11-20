import 'package:app_store/src/core/navigation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ItemMenuWidget extends StatelessWidget {
  final String title;
  final Widget page;
  const ItemMenuWidget({super.key, required this.title, required this.page});

  @override
  Widget build(BuildContext context) {
    final navigation = context.read<Navigation>();
    return ListTile(
        leading: CircleAvatar(
          maxRadius: 16,
          backgroundColor: Theme.of(context).colorScheme.primary,
          foregroundColor: Theme.of(context).colorScheme.onPrimary,
          child: const Icon(Icons.celebration_outlined, size: 18),
        ),
        title: Text(title,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
        onTap: () => navigation.pageView(page, context),
      );
  }
}