import 'package:app_store/src/core/http.dart';
import 'package:app_store/src/modules/applications/applications_model.dart';
import 'package:app_store/src/modules/applications/widgets/card_applications.dart';
import 'package:flutter/material.dart';

class CategoriesPopularView extends StatelessWidget {
  const CategoriesPopularView({super.key});

  final String categoryName = "Populares";
  final String endpoint = "popular";

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Http.get(endpoint),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return SizedBox(
          height: MediaQuery.of(context).size.height / 1.2,
          child: GridView.builder(
            shrinkWrap: true,
            itemCount: snapshot.data!.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 5),
            itemBuilder: (context, index) {
              final applicationModel =
                  ApplicationsModel.fromJson(snapshot.data?[index] ?? {});
              if (applicationModel.iconDesktopUrl != null) {
                return CardApplicationsWiget(
                    applicationModel: applicationModel);
              }

              return SizedBox();
            },
          ),
        );
      },
    );
  }
}
