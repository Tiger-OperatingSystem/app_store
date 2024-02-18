import 'package:app_store/src/store/navigation_store.dart';
import 'package:flutter/material.dart';

class Navigation extends ChangeNotifier {
  void pageView(Widget view, BuildContext context) {
    try {
      currentView.value = view;
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
