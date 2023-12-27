// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:app_store/main.dart';
import 'package:app_store/src/handlers/exceptions.dart';
import 'package:app_store/src/modules/applications/applications_model.dart';
import 'package:flutter/material.dart';
import 'package:process_run/shell.dart';
import 'package:xml/xml.dart';

class InstalledController extends ChangeNotifier {
  final _basePathFlatpak = "/var/lib/flatpak/app";
  final _basePathFlatpakImage =
      "current/active/files/share/app-info/icons/flatpak/64x64";

  Future<List<ApplicationsModel>> flatpakInstalled(BuildContext context) async {
    try {
      List<ApplicationsModel> list = [];
      final appsData = await _getApplicationsFlatpak(context);

      for (int i = 0; i < appsData.length; i++) {
        final flatpakId = appsData;
        final name = await _getAppDataXml('name', context);
        final summary = await _getAppDataXml('summary', context);
        final iconDesktopUrl =
            "$_basePathFlatpak/${appsData[i]}/$_basePathFlatpakImage/${appsData[i]}.png";

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

  Future<List<String>> _getApplicationsFlatpak(BuildContext context) async {
    try {
      List<String> list = [];
      final path = _basePathFlatpak;
      final data = await shell.run("ls $path");

      for (var elements in data.outLines) {
        list.add(elements);
      }

      return list;
    } catch (e) {
      throw CustomExceptionsWidget(e.toString(), context);
    }
  }

  Future<List> _getAppDataXml(String tag, BuildContext context) async {
    try {
      List<String> list = [];
      final flatpak = await _getApplicationsFlatpak(context);

      for (var elements in flatpak) {
        final file = File(
            "$_basePathFlatpak/$elements/current/active/files/share/appdata/$elements.appdata.xml");
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

  Set<dynamic> segmentSelected = {0};
  void changeSegmentSelected(Set<dynamic> value, BuildContext context) {
    try {
      segmentSelected = value;
      notifyListeners();
    } catch (e) {
      throw CustomExceptionsWidget(e.toString(), context);
    }
  }
}