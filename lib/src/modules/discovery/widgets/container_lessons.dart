import 'package:flutter/material.dart';

class ContainerLessonsWidget extends StatelessWidget {
  const ContainerLessonsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        alignment: Alignment.topLeft,
        width: MediaQuery.of(context).size.width,
        height: 500,
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surfaceVariant,
            borderRadius: BorderRadius.circular(12)),
        child: Column(
          children: [
            Padding(
                padding: const EdgeInsets.all(18.0),
                child: Card(
                  color: Theme.of(context).colorScheme.primary,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Cursos gratuitos',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onPrimary,
                        fontSize:
                            Theme.of(context).textTheme.titleLarge!.fontSize,
                      ),
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
