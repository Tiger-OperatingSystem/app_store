// ignore_for_file: use_build_context_synchronously

import 'package:app_store/main.dart';
import 'package:app_store/src/core/http.dart';
import 'package:app_store/src/core/navigation.dart';
import 'package:app_store/src/handlers/exceptions.dart';
import 'package:app_store/src/modules/applications/applications_model.dart';
import 'package:app_store/src/modules/applications/widgets/build_applications.dart';
import 'package:flutter/material.dart';
import 'package:process_run/shell.dart';
import 'package:provider/provider.dart';

class ApplicationsController extends ChangeNotifier {
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

  static Future<ApplicationsModel> getByFlatpakAppId(
      String flatpakAppId, BuildContext context) async {
    try {
      final data = await Http.get(flatpakAppId);
      return ApplicationsModel.fromJson(data);
    } catch (e) {
      throw CustomExceptionsWidget(e.toString(), context);
    }
  }

  Future<bool> hasInstalledFlatpak(ApplicationsModel applicationsModel, BuildContext context) async {
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

  Future<void> installFlatpak(ApplicationsModel applicationsModel, BuildContext context) async {
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

  Future<void> removeFlatpak(ApplicationsModel applicationsModel, BuildContext context) async {
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

  Future<bool> hasInstalledDebian(ApplicationsModel applicationsModel, BuildContext context) async {
    try {

      final name = applicationsModel.name!.replaceAll(RegExp(r' '), "-").toLowerCase();
      final data = await shell.run("apt list --installed $name");

      for(var element in data.outLines) {
        if(element.contains(name)) {
          return true;
        }
      }

      return false;
    } catch (e) {
      throw CustomExceptionsWidget(e.toString(), context);
    }
  }

  Future<bool> isDebianPackage(ApplicationsModel applicationsModel, BuildContext context) async {
    try {
      final name = applicationsModel.name!.replaceAll(RegExp(r' '), "-").toLowerCase();
      final data = await shell.run("apt list $name");

      for(var element in data.outLines) {
        if(element.contains(name)) {
          return true;
        }
      }

      return false;
    } catch (e) {
      throw CustomExceptionsWidget(e.toString(), context);
    }
  }

  Future<void> installDebianPackage(ApplicationsModel applicationsModel, BuildContext context) async {
    try {
      final name = applicationsModel.name!.replaceAll(RegExp(r' '), "-").toLowerCase();
      final result = await shell.run("pkexec apt-get install $name -y");
      result;
      notifyListeners();
    } catch (e) {
      throw CustomExceptionsWidget(e.toString(), context);
    }
  }

  Future<void> removeDebianPackage(ApplicationsModel applicationsModel, BuildContext context) async {
    try {
      final name = applicationsModel.name!.replaceAll(RegExp(r' '), "-").toLowerCase();
      final result = await shell.run("pkexec apt-get remove $name -y");
      result;
      notifyListeners();
    } catch (e) {
      throw CustomExceptionsWidget(e.toString(), context);
    }
  }  
}
