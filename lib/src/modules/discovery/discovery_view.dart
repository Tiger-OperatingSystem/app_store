import 'package:app_store/src/modules/discovery/widgets/container_lessons.dart';
import 'package:flutter/material.dart';

class DiscoveryView extends StatelessWidget {
  const DiscoveryView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        ContainerLessonsWidget(),
      ],
    );
  }
}
