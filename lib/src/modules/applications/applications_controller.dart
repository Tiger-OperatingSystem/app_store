import 'package:app_store/src/core/navigation.dart';
import 'package:app_store/src/modules/applications/applications_search_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ApplicationsController extends ChangeNotifier {
  static Future<void> search(String search, BuildContext context) async {
    final navigation = context.read<Navigation>();

    try {
      navigation.pageView(ApplicationsSearchView(search: search), context);
    } catch (e) {
      rethrow;
    }
  }
}
