// ignore_for_file: use_build_context_synchronously

import 'package:app_store/main.dart';
import 'package:app_store/src/handlers/exceptions.dart';
import 'package:app_store/src/modules/applications/applications_controller.dart';
import 'package:app_store/src/modules/applications/applications_model.dart';
import 'package:flutter/material.dart';

import 'package:process_run/shell.dart';

class DebianController extends ApplicationsController {
  @override
  Future<ApplicationsModel> getById(String appid, BuildContext context) {
    throw UnimplementedError();
  }

  @override
  Future<bool> hasInstalled(
      ApplicationsModel applicationsModel, BuildContext context) async {
    try {
      final name =
          applicationsModel.name!.replaceAll(RegExp(r' '), "-").toLowerCase();
      final data = await shell.run("apt list --installed $name");

      for (var element in data.outLines) {
        if (element.contains(name)) {
          return true;
        }
      }

      return false;
    } catch (e) {
      throw CustomExceptionsWidget(e.toString(), context);
    }
  }

  @override
  Future<void> install(
      ApplicationsModel applicationsModel, BuildContext context) async {
    try {
      final name =
          applicationsModel.name!.replaceAll(RegExp(r' '), "-").toLowerCase();
      final result = await shell.run("pkexec apt-get install $name -y");
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
      final name =
          applicationsModel.name!.replaceAll(RegExp(r' '), "-").toLowerCase();
      final result = await shell.run("pkexec apt-get remove $name -y");
      result;
      notifyListeners();
    } catch (e) {
      throw CustomExceptionsWidget(e.toString(), context);
    }
  }

  @override
  Future<void> search(String search, BuildContext context) {
    throw UnimplementedError();
  }

  @override
  Future<bool> isAvailable(
      ApplicationsModel applicationsModel, BuildContext context) async {
    try {
      final name =
          applicationsModel.name!.replaceAll(RegExp(r' '), "-").toLowerCase();
      final data = await shell.run("apt list $name");

      for (var element in data.outLines) {
        if (element.contains(name)) {
          return true;
        }
      }

      return false;
    } catch (e) {
      throw CustomExceptionsWidget(e.toString(), context);
    }
  }
}
