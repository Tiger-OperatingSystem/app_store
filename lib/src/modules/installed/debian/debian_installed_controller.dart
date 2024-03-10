// ignore_for_file: use_build_context_synchronously, avoid_function_literals_in_foreach_calls

import 'dart:io';

import 'package:app_store/src/handlers/exceptions.dart';
import 'package:app_store/src/modules/applications/applications_model.dart';
import 'package:app_store/src/modules/installed/installed_controller.dart';
import 'package:flutter/material.dart';
import 'package:process_run/shell.dart';
import 'package:xml/xml.dart';

class DebianInstalledController extends InstalledController {
  @override
  Future<List<String>> applicationsInstalled(BuildContext context) async {
    try {
      List<String> list = [];
      final result = await Process.run("/bin/bash",
          ["-c", r"ls /usr/share/applications | sed 's/\.desktop$//'"]);

      list.add(result.outText);

      return list;
    } catch (e) {
      throw CustomExceptionsWidget(
          "Não possível listar as aplicações instaladas. ${e.toString()}",
          context);
    }
  }

  @override
  Future<List> dataFromXML(String tag, BuildContext context) async {
    try {
      List list = [];
      final packages = await applicationsInstalled(context);
      for (var package in packages) {
        print(package);
        final result = await Process.run(
            "/bin/bash", ["-c", "dpkg -L vlc | grep '.xml' | head -n 1"]);
        if (result.errText.isEmpty) {
          final file = File(result.outText);
          final document = XmlDocument.parse(file.readAsStringSync());

          final data = document
              .findAllElements(tag)
              .map((element) => element.innerText)
              .first;

          list.add(data);
        }
      }

      return list;
    } catch (e) {
      throw CustomExceptionsWidget(e.toString(), context);
    }
  }

  @override
  Future<List<ApplicationsModel>> build(BuildContext context) async {
    try {
      List<ApplicationsModel> list = [];
      final packages = await applicationsInstalled(context);

      for (int index = 0; index < packages.length; index++) {
        final package = packages[index];
        final name = await dataFromXML("name", context);
        final summary = await dataFromXML("summary", context);

        final applicationsModel = ApplicationsModel(
          flatpakAppId: package,
          name: name[index],
          summary: summary[index],
        );

        list.add(applicationsModel);
      }

      return list;
    } catch (e) {
      throw CustomExceptionsWidget(e.toString(), context);
    }
  }
}
