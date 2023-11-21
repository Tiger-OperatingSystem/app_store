import 'package:app_store/src/core/navigation.dart';
import 'package:app_store/src/modules/applications/widgets/build_applications.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ApplicationsController extends ChangeNotifier {
  Future<void> search(String search, BuildContext context) async {
    final navigation = context.read<Navigation>();

    try {
      navigation.pageView(
          BuildApplicationsWidget(endpoint: "search/$search"), context);
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }
}
