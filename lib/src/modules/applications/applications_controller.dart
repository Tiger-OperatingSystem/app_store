// ignore_for_file: use_build_context_synchronously

import 'package:app_store/src/modules/applications/applications_model.dart';
import 'package:flutter/material.dart';

abstract class ApplicationsController extends ChangeNotifier {
  Future<void> search(String search, BuildContext context);

  Future<ApplicationsModel> getById(String appid, BuildContext context);

  Future<bool> hasInstalled(
      ApplicationsModel applicationsModel, BuildContext context);

  Future<bool> isAvailable(
      ApplicationsModel applicationsModel, BuildContext context);

  Future<void> install(
      ApplicationsModel applicationsModel, BuildContext context);

  Future<void> remove(
      ApplicationsModel applicationsModel, BuildContext context);
}
