import 'dart:io';

import 'package:app_store/src/core/http.dart';
import 'package:app_store/src/core/navigation.dart';
import 'package:app_store/src/modules/applications/applications_model.dart';
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

  static Future<ApplicationsModel> getByFlatpakAppId(
      String flatpakAppId) async {
    try {
      final data = await Http.get(flatpakAppId);
      return ApplicationsModel.fromJson(Map.from(data));
    } catch (e) {
      rethrow;
    }
  }

  static Future<void> initGetInstalled(List installedApplications) async {
    try {
      final result = await Process.run("flatpak", ["list"]);
      installedApplications.add(result.stdout);
    } catch (e) {
      rethrow;
    }
  }

  static bool hasInstalled(
      ApplicationsModel applicationsModel, List applications) {
    try {
      late bool hasInstalled;

      for (var elements in applications) {
        if (elements.toString().contains(applicationsModel.flatpakAppId!)) {
          return hasInstalled = true;
        } else {
          return hasInstalled = false;
        }
      }

      return hasInstalled;
    } catch (e) {
      rethrow;
    }
  }

  static void installFlatpak(ApplicationsModel applicationsModel) {
    try {
      final result = Process.runSync("flatpak-install-gui", [
        "--override-appname='${applicationsModel.name}' ${applicationsModel.flatpakAppId}"
      ]);
      result;
    } catch (e) {
      rethrow;
    }
  }

  static void removeFlatpak(ApplicationsModel applicationsModel) {
    try {
      final result = Process.runSync("flatpak-install-gui", [
        "--override-appname='${applicationsModel.name}' ${applicationsModel.flatpakAppId} --remove"
      ]);
      result;
    } catch (e) {
      rethrow;
    }
  }
}
