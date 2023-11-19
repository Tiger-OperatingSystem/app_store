import 'package:flutter/material.dart';

class Navigation extends ChangeNotifier {
  Widget currentView = const Center(child: Text('currentView'));
  void pageView(Widget view, BuildContext context) {
    try {
      currentView = view;
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }
}
