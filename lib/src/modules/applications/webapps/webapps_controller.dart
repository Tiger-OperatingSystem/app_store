// ignore_for_file: use_build_context_synchronously

import 'package:app_store/src/core/http.dart';
import 'package:app_store/src/handlers/exceptions.dart';
import 'package:app_store/src/modules/applications/applications_controller.dart';
import 'package:app_store/src/modules/applications/applications_model.dart';
import 'package:flutter/material.dart';

class WebAppController extends ApplicationsController {
  @override
  Future<ApplicationsModel> getById(String appid, BuildContext context) {
    throw UnimplementedError();
  }

  @override
  Future<bool> hasInstalled(
      ApplicationsModel applicationsModel, BuildContext context) {
    throw UnimplementedError();
  }

  @override
  Future<void> install(
      ApplicationsModel applicationsModel, BuildContext context) {
    throw UnimplementedError();
  }

  @override
  Future<bool> isAvailable(
      ApplicationsModel applicationsModel, BuildContext context) async {
    try {
      final data = await Http.get(
          "Tiger-OperatingSystem/TigerStore-Addons/main/webapps.json");
      for (var element in data) {
        if (element["name"] != applicationsModel.name) {
          return false;
        }
      }

      return true;
    } catch (e) {
      throw CustomExceptionsWidget(e.toString(), context);
    }
  }

  @override
  Future<void> remove(
      ApplicationsModel applicationsModel, BuildContext context) {
    throw UnimplementedError();
  }

  @override
  Future<void> search(String search, BuildContext context) {
    throw UnimplementedError();
  }
}
