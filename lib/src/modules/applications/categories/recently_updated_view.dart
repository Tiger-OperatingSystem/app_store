import 'package:app_store/src/core/http.dart';
import 'package:app_store/src/modules/applications/applications_model.dart';
import 'package:app_store/src/modules/applications/widgets/card_applications.dart';
import 'package:flutter/material.dart';

class CategoriesRecentyUpdatedView extends StatelessWidget {
  const CategoriesRecentyUpdatedView({super.key});

  final String categoryName = "Recem atualizados";
  final String endpoint = "recently-updated";

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Http.get(endpoint),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        return SizedBox(
          height: MediaQuery.of(context).size.height / 1.2,
          child: GridView.builder(
            shrinkWrap: true,
            itemCount: snapshot.data!.length,
            gridDelegate:  const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3, 
                childAspectRatio: 2),
            itemBuilder: (context, index) {
              final applicationModel =
                  ApplicationsModel.fromJson(snapshot.data?[index] ?? {});
              return CardApplicationsWiget(applicationModel: applicationModel);
            },
          ),
        );
      },
    );
  }
}
