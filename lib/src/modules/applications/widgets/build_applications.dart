// ignore_for_file: must_be_immutable

import 'package:app_store/src/core/http.dart';
import 'package:app_store/src/core/navigation.dart';
import 'package:app_store/src/modules/applications/applications_model.dart';
import 'package:app_store/src/modules/applications/widgets/card_applications.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BuildApplicationsWidget extends StatelessWidget {
  String endpoint;
  BuildApplicationsWidget({
    super.key,
    required this.endpoint,
  });

  @override
  Widget build(BuildContext context) {
    List itemsWithIcon = [];

    return ListenableBuilder(
      listenable: context.watch<Navigation>(),
      builder: (context, child) {
        return FutureBuilder(
          future: _getItemsWithIcon(endpoint, itemsWithIcon),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            return Expanded(
              child: GridView.builder(
                shrinkWrap: true,
                itemCount: itemsWithIcon.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 2,
                ),
                itemBuilder: (context, index) {
                  final applicationModel =
                      ApplicationsModel.fromJson(itemsWithIcon[index]);
                  return CardApplicationsWiget(
                      applicationModel: applicationModel);
                },
              ),
            );
          },
        );
      },
    );
  }
}

Future<List> _getItemsWithIcon(String endpoint, List list) async {
  try {
    final data = await Http.get(endpoint);

    return await Future.delayed(Duration.zero, () {
      for (var element in data) {
        if (element['iconDesktopUrl'] != null) {
          list.add(element);
        }
      }

      return list;
    });
  } catch (e) {
    rethrow;
  }
}
