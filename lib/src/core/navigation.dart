import 'package:app_store/src/modules/applications/widgets/build_applications.dart';
import 'package:flutter/material.dart';

class Navigation extends ChangeNotifier {
  Widget currentView = BuildApplicationsWidget(endpoint: "collection/popular");
  void pageView(Widget view, BuildContext context) {
    try {
      currentView = view;
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  static void push(Widget view, BuildContext context) {
    try {
      Navigator.push(context, MaterialPageRoute(builder: (context) => view));
    } catch (e) {
      rethrow;
    }
  }
}
