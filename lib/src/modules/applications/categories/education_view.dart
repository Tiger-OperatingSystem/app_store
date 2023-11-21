import 'package:app_store/src/core/http.dart';
import 'package:app_store/src/modules/applications/applications_model.dart';
import 'package:app_store/src/modules/applications/widgets/card_applications.dart';
import 'package:flutter/material.dart';

class CategoriesEducationView extends StatefulWidget {
  const CategoriesEducationView({super.key});

  @override
  State<CategoriesEducationView> createState() =>
      _CategoriesEducationViewState();
}

List _itemsWithIcon = [];

class _CategoriesEducationViewState extends State<CategoriesEducationView> {
  final String categoryName = "Educação";

  final String endpoint = "category/Education";

  @override
  void initState() {
    _getItemsWithIcon(endpoint);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _itemsWithIcon = [];
  }

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
        return Expanded(
          child: GridView.builder(
            shrinkWrap: true,
            itemCount: _itemsWithIcon.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 2,
            ),
            itemBuilder: (context, index) {
              final applicationModel =
                  ApplicationsModel.fromJson(_itemsWithIcon[index]);
              return CardApplicationsWiget(applicationModel: applicationModel);
            },
          ),
        );
      },
    );
  }
}

Future<List> _getItemsWithIcon(String endpoint) async {
  try {
    final data = await Http.get(endpoint);
    for (var element in data) {
      if (element['iconDesktopUrl'] != null) {
        _itemsWithIcon.add(element);
      }
    }
    return _itemsWithIcon;
  } catch (e) {
    rethrow;
  }
}
