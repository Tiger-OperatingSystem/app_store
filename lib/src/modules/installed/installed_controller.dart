// ignore_for_file: use_build_context_synchronously

import 'package:app_store/src/modules/applications/applications_model.dart';
import 'package:flutter/material.dart';

abstract class InstalledController extends ChangeNotifier {
  Future<List<ApplicationsModel>> build(BuildContext context);
  Future<List<String>> applicationsInstalled(BuildContext context);
  Future<List> dataFromXML(String tag, BuildContext context);
}
