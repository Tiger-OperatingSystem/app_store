// ignore_for_file: must_be_immutable

import 'package:app_store/src/core/http.dart';
import 'package:app_store/src/modules/applications/applications_model.dart';
import 'package:app_store/src/modules/applications/widgets/card_applications.dart';
import 'package:app_store/src/store/navigation_store.dart';
import 'package:flutter/material.dart';

class BuildApplicationsWidget extends StatelessWidget {
  String endpoint;
  BuildApplicationsWidget({
    super.key,
    required this.endpoint,
  });

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: currentView,
      builder: (context, child) {
        return FutureBuilder(
          future: Http.get(endpoint),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            return Expanded(
              child: GridView.builder(
                shrinkWrap: true,
                itemCount: snapshot.data.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 2,
                ),
                itemBuilder: (context, index) {
                  final applicationModel =
                      ApplicationsModel.fromJson(snapshot.data![index]);
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
