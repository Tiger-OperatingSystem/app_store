// ignore_for_file: use_build_context_synchronously

import 'package:app_store/main.dart';
import 'package:app_store/src/core/http.dart';
import 'package:app_store/src/core/navigation.dart';
import 'package:app_store/src/handlers/exceptions.dart';
import 'package:app_store/src/modules/applications/applications_controller.dart';
import 'package:app_store/src/modules/applications/applications_model.dart';
import 'package:app_store/src/modules/applications/widgets/build_applications.dart';
import 'package:flutter/material.dart';
import 'package:process_run/shell.dart';
import 'package:provider/provider.dart';

class FlatpakController extends ApplicationsController {
  @override
  Future<void> search(String search, BuildContext context) async {
    final navigation = context.read<Navigation>();
    try {
      navigation.pageView(
          BuildApplicationsWidget(endpoint: "search/$search"), context);
      notifyListeners();
    } catch (e) {
      throw CustomExceptionsWidget(e.toString(), context);
    }
  }

  @override
  Future<ApplicationsModel> getById(String appid, BuildContext context) async {
    try {
      final data = await Http.get(appid);
      return ApplicationsModel.fromJson(data);
    } catch (e) {
      throw CustomExceptionsWidget(e.toString(), context);
    }
  }

  @override
  Future<bool> hasInstalled(
      ApplicationsModel applicationsModel, BuildContext context) async {
    try {
      late bool hasInstalled;
      final result = await shell.run('''ls /var/lib/flatpak/app/''');

      if (result.outText.toString().contains(applicationsModel.flatpakAppId!)) {
        hasInstalled = true;
      } else {
        hasInstalled = false;
      }

      return hasInstalled;
    } catch (e) {
      throw CustomExceptionsWidget(e.toString(), context);
    }
  }

  @override
  Future<void> install(
      ApplicationsModel applicationsModel, BuildContext context) async {
    try {
      final result = await shell.run(
        '''flatpak-install-gui --override-appname="${applicationsModel.name}" ${applicationsModel.flatpakAppId}''',
      );
      result;
      notifyListeners();
    } catch (e) {
      throw CustomExceptionsWidget(e.toString(), context);
    }
  }

  @override
  Future<void> remove(
      ApplicationsModel applicationsModel, BuildContext context) async {
    try {
      final result = await shell.run(
        '''flatpak-install-gui --override-appname="${applicationsModel.name}" --remove ${applicationsModel.flatpakAppId}''',
      );
      result;
      notifyListeners();
    } catch (e) {
      throw CustomExceptionsWidget(e.toString(), context);
    }
  }

  @override
  Future<bool> isAvailable(
      ApplicationsModel applicationsModel, BuildContext context) async {
    try {
      final data =
          await shell.run("flatpak search ${applicationsModel.flatpakAppId}");

      for (var element in data.outLines) {
        if (element.contains(applicationsModel.flatpakAppId!)) {
          return true;
        }
      }

      return false;
    } catch (e) {
      throw CustomExceptionsWidget(e.toString(), context);
    }
  }
}
