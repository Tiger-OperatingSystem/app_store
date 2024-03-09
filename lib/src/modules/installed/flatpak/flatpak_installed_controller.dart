// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:app_store/main.dart';
import 'package:app_store/src/handlers/exceptions.dart';
import 'package:app_store/src/modules/applications/applications_model.dart';
import 'package:app_store/src/modules/installed/installed_controller.dart';
import 'package:flutter/material.dart';
import 'package:process_run/shell.dart';
import 'package:xml/xml.dart';

class FlatpakInstalledController extends InstalledController {
  final _basePath = "/var/lib/flatpak/app";
  final _basePathImage =
      "current/active/files/share/app-info/icons/flatpak/64x64";
  @override
  Future<List<ApplicationsModel>> build(BuildContext context) async {
    try {
      List<ApplicationsModel> list = [];
      final appsData = await applicationsInstalled(context);

      for (int i = 0; i < appsData.length; i++) {
        final flatpakId = appsData;
        final name = await dataFromXML('name', context);
        final summary = await dataFromXML('summary', context);
        final iconDesktopUrl =
            "$_basePath/${appsData[i]}/$_basePathImage/${appsData[i]}.png";

        final applicationModel = ApplicationsModel(
          flatpakAppId: flatpakId[i],
          name: name[i],
          summary: summary[i],
          iconDesktopUrl: iconDesktopUrl,
        );

        list.add(applicationModel);
      }
      return list;
    } catch (e) {
      throw CustomExceptionsWidget(e.toString(), context);
    }
  }

  @override
  Future<List<String>> applicationsInstalled(BuildContext context) async {
    try {
      List<String> list = [];
      final path = _basePath;
      final data = await shell.run("ls $path");

      for (var elements in data.outLines) {
        list.add(elements);
      }

      return list;
    } catch (e) {
      throw CustomExceptionsWidget(e.toString(), context);
    }
  }

  @override
  Future<List> dataFromXML(String tag, BuildContext context) async {
    try {
      List<String> list = [];
      final flatpak = await applicationsInstalled(context);

      for (var elements in flatpak) {
        final file = File(
            "$_basePath/$elements/current/active/files/share/appdata/$elements.appdata.xml");
        final document = XmlDocument.parse(file.readAsStringSync());

        final data = document
            .findAllElements(tag)
            .map((element) => element.innerText)
            .first;

        list.add(data);
      }

      return list;
    } catch (e) {
      throw CustomExceptionsWidget(e.toString(), context);
    }
  }
}
